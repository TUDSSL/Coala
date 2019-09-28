#include <msp430.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

#include <mspReseter.h>
#include <mspProfiler.h>
#include <mspDebugger.h>
#include <accel.h>
#include <msp-math.h>

#include <coala.h>

// Only for profiling, removable otherwise
#include <ctlflags.h>

// Profiling flags.
#if ENABLE_PRF
__nv uint8_t full_run_started = 0;
__nv uint8_t first_run = 1;
#endif

#ifndef RST_TIME
#define RST_TIME 25000
#endif


// Number of samples to discard before recording training set
#define NUM_WARMUP_SAMPLES 3

#define ACCEL_WINDOW_SIZE 3
#define MODEL_SIZE 16
#define SAMPLE_NOISE_FLOOR 10 // TODO: made up value

// Number of classifications to complete in one experiment
#define SAMPLES_TO_COLLECT 128

typedef threeAxis_t_8 accelReading;
typedef accelReading accelWindow[ACCEL_WINDOW_SIZE];

typedef struct {
    COALA_SM(unsigned, meanmag);
    COALA_SM(unsigned, stddevmag);
} features_t;

typedef enum {
    CLASS_STATIONARY,
    CLASS_MOVING,
} class_t;


typedef enum {
    MODE_IDLE = 3,
    MODE_TRAIN_STATIONARY = 2,
    MODE_TRAIN_MOVING = 1,
    MODE_RECOGNIZE = 0, // default
} run_mode_t;

// Tasks.
COALA_TASK(task_init, 3)
COALA_TASK(task_selectMode, 9)
COALA_TASK(task_resetStats, 3)
COALA_TASK(task_sample, 26)
COALA_TASK(task_transform, 8)
COALA_TASK(task_featurize, 30)
COALA_TASK(task_classify, 50)
COALA_TASK(task_stats, 3)
COALA_TASK(task_warmup, 13)
COALA_TASK(task_train, 7)
COALA_TASK(task_idle, 1)

// Task-shared protected variables.
COALA_PV(uint16_t, _v_pinState);
COALA_PV(unsigned, _v_discardedSamplesCount);
COALA_PV(class_t, _v_class);
COALA_PV(unsigned, _v_totalCount);
COALA_PV(unsigned, _v_movingCount);
COALA_PV(unsigned, _v_stationaryCount);
COALA_PV(accelReading, _v_window, ACCEL_WINDOW_SIZE);
COALA_PV(features_t, _v_features);
COALA_PV(unsigned, _v_trainingSetSize);
COALA_PV(unsigned, _v_samplesInWindow);
COALA_PV(run_mode_t, _v_mode);
COALA_PV(unsigned, _v_seed);
COALA_PV(unsigned, _v_count);
COALA_PV(features_t, _v_model_stationary, MODEL_SIZE);
COALA_PV(features_t, _v_model_moving, MODEL_SIZE);

void ACCEL_singleSample_(threeAxis_t_8* result){
    result->x = (RP(_v_seed)*17)%85;
    result->y = (RP(_v_seed)*17*17)%85;
    result->z = (RP(_v_seed)*17*17*17)%85;
    ++WP(_v_seed);
}


void task_init()
{
#if TSK_SIZ || EXECUTION_TIME
    cp_reset();
#endif

#if ENABLE_PRF
    full_run_started = 1;
#endif

    WP(_v_pinState) = MODE_IDLE;

    WP(_v_count) = 0;
    WP(_v_seed) = 1;

    coala_next_task(task_selectMode);

#if TSK_SIZ
    cp_sendRes("task_init \0");
#endif
}


void task_selectMode()
{
    uint16_t pin_state = 1;
    ++WP(_v_count);

    if(RP(_v_count) >= 3) pin_state = 2;
    if(RP(_v_count) >= 5) pin_state = 0;
    if (RP(_v_count) >= 7) {
        
#if ENABLE_PRF
        if (full_run_started) {
#if AUTO_RST
            msp_reseter_halt();
#endif
            PRF_APP_END();
            full_run_started = 0;
#if AUTO_RST
            msp_reseter_resume();
#endif
        }
#endif

#ifdef EXECUTION_TIME
cp_sendRes("ar");
uart_sendHex16(fullpage_fault_counter);
uart_sendStr("\n\r\0");
uart_sendHex16(page_fault_counter);
uart_sendStr("\n\r\0");
#endif
        coala_next_task(task_init);
        return;
    }

    // Don't re-launch training after finishing training
    if ((pin_state == MODE_TRAIN_STATIONARY ||
                pin_state == MODE_TRAIN_MOVING) &&
            pin_state == RP(_v_pinState)) {
        pin_state = MODE_IDLE;
    } else {
        WP(_v_pinState) = pin_state;
    }

    switch(pin_state) {
        case MODE_TRAIN_STATIONARY:
            WP(_v_discardedSamplesCount) = 0;
            WP(_v_mode) = MODE_TRAIN_STATIONARY;
            WP(_v_class) = CLASS_STATIONARY;
            WP(_v_samplesInWindow) = 0;

            coala_next_task(task_warmup);
            break;

        case MODE_TRAIN_MOVING:
            WP(_v_discardedSamplesCount) = 0;
            WP(_v_mode) = MODE_TRAIN_MOVING;
            WP(_v_class) = CLASS_MOVING;
            WP(_v_samplesInWindow) = 0;

            coala_next_task(task_warmup);
            break;

        case MODE_RECOGNIZE:
            WP(_v_mode) = MODE_RECOGNIZE;

            coala_next_task(task_resetStats);
            break;

        default:
            coala_next_task(task_idle);
    }

#if TSK_SIZ
    cp_sendRes("task_selectMode \0");
#endif
}


void task_resetStats()
{
#if TSK_SIZ
    cp_reset();
#endif

    // NOTE: could roll this into selectMode task, but no compelling reason

    // NOTE: not combined into one struct because not all code paths use both
    WP(_v_movingCount) = 0;
    WP(_v_stationaryCount) = 0;
    WP(_v_totalCount) = 0;

    WP(_v_samplesInWindow) = 0;

    coala_next_task(task_sample);

#if TSK_SIZ
    cp_sendRes("task_resetStats \0");
#endif
}


void task_sample()
{
#if TSK_SIZ
    cp_reset();
#endif

    accelReading sample;
    ACCEL_singleSample_(&sample);
    WP(_v_window[RP(_v_samplesInWindow)].x) = sample.x;
    WP(_v_window[RP(_v_samplesInWindow)].y) = sample.y;
    WP(_v_window[RP(_v_samplesInWindow)].z) = sample.z;
    ++WP(_v_samplesInWindow);

    if (RP(_v_samplesInWindow) < ACCEL_WINDOW_SIZE) {
        coala_next_task(task_sample);
    } else {
        WP(_v_samplesInWindow) = 0;
        coala_next_task(task_transform);
    }

#if TSK_SIZ
    cp_sendRes("task_sample \0");
#endif
}


void task_transform()
{
#if TSK_SIZ
    cp_reset();
#endif

    unsigned i;

    for (i = 0; i < ACCEL_WINDOW_SIZE; i++) {
        if (RP(_v_window[i].x) < SAMPLE_NOISE_FLOOR ||
                RP(_v_window[i].y) < SAMPLE_NOISE_FLOOR ||
                RP(_v_window[i].z) < SAMPLE_NOISE_FLOOR) {

            WP(_v_window[i].x) = (RP(_v_window[i].x) > SAMPLE_NOISE_FLOOR)
                ? RP(_v_window[i].x) : 0;
            WP(_v_window[i].y) = (RP(_v_window[i].y) > SAMPLE_NOISE_FLOOR)
                ? RP(_v_window[i].y) : 0;
            WP(_v_window[i].z) = (RP(_v_window[i].z) > SAMPLE_NOISE_FLOOR)
                ? RP(_v_window[i].z) : 0;
        }
    }
    coala_next_task(task_featurize);

#if TSK_SIZ
    cp_sendRes("task_transform \0");
#endif
}


void task_featurize()
{
#if TSK_SIZ
    cp_reset();
#endif

    accelReading mean, stddev;
    mean.x = mean.y = mean.z = 0;
    stddev.x = stddev.y = stddev.z = 0;
    features_t features;

    int i;
    for (i = 0; i < ACCEL_WINDOW_SIZE; i++) {
        mean.x += RP(_v_window[i].x);
        mean.y += RP(_v_window[i].y);
        mean.z += RP(_v_window[i].z);
    }
    mean.x >>= 2;
    mean.y >>= 2;
    mean.z >>= 2;

    accelReading sample;

    for (i = 0; i < ACCEL_WINDOW_SIZE; i++) {
        sample.x = RP(_v_window[i].x);
        sample.y = RP(_v_window[i].y);
        sample.z = RP(_v_window[i].z);

        stddev.x += (sample.x > mean.x) ? (sample.x - mean.x)
            : (mean.x - sample.x);
        stddev.y += (sample.y > mean.y) ? (sample.y - mean.y)
            : (mean.y - sample.y);
        stddev.z += (sample.z > mean.z) ? (sample.z - mean.z)
            : (mean.z - sample.z);
    }
    stddev.x >>= 2;
    stddev.y >>= 2;
    stddev.z >>= 2;

    unsigned meanmag = mean.x*mean.x + mean.y*mean.y + mean.z*mean.z;
    unsigned stddevmag = stddev.x*stddev.x + stddev.y*stddev.y + stddev.z*stddev.z;
    features.meanmag   = sqrt16(meanmag);
    features.stddevmag = sqrt16(stddevmag);

    switch (RP(_v_mode)) {
        case MODE_TRAIN_STATIONARY:
        case MODE_TRAIN_MOVING:
            WP(_v_features.meanmag) = features.meanmag;
            WP(_v_features.stddevmag) = features.stddevmag;
            coala_next_task(task_train);
            break;
        case MODE_RECOGNIZE:
            WP(_v_features.meanmag) = features.meanmag;
            WP(_v_features.stddevmag) = features.stddevmag;
            coala_next_task(task_classify);
            break;
        default:
            // TODO: abort
            break;
    }

#if TSK_SIZ
    cp_sendRes("task_featurize \0");
#endif
}


void task_classify()
{
#if TSK_SIZ
       cp_reset();
#endif

    int move_less_error = 0;
    int stat_less_error = 0;
    int i;

    long int meanmag;
    long int stddevmag;
    meanmag = RP(_v_features.meanmag);
    stddevmag = RP(_v_features.stddevmag);

    features_t ms, mm;

    for (i = 0; i < MODEL_SIZE; ++i) {
        ms.meanmag = RP(_v_model_stationary[i].meanmag);
        ms.stddevmag = RP(_v_model_stationary[i].stddevmag);
        mm.meanmag = RP(_v_model_moving[i].meanmag);
        mm.stddevmag = RP(_v_model_moving[i].stddevmag);

        long int stat_mean_err = (ms.meanmag > meanmag)
            ? (ms.meanmag - meanmag)
            : (meanmag - ms.meanmag);

        long int stat_sd_err = (ms.stddevmag > stddevmag)
            ? (ms.stddevmag - stddevmag)
            : (stddevmag - ms.stddevmag);

        long int move_mean_err = (mm.meanmag > meanmag)
            ? (mm.meanmag - meanmag)
            : (meanmag - mm.meanmag);

        long int move_sd_err = (mm.stddevmag > stddevmag)
            ? (mm.stddevmag - stddevmag)
            : (stddevmag - mm.stddevmag);

        if (move_mean_err < stat_mean_err) {
            move_less_error++;
        } else {
            stat_less_error++;
        }

        if (move_sd_err < stat_sd_err) {
            move_less_error++;
        } else {
            stat_less_error++;
        }
    }

    WP(_v_class) = (move_less_error > stat_less_error) ? CLASS_MOVING : CLASS_STATIONARY;

    coala_next_task(task_stats);

#if TSK_SIZ
    cp_sendRes("task_classify \0");
#endif
}


unsigned resultStationaryPct;
unsigned resultMovingPct;
unsigned sum;

void task_stats()
{
#if TSK_SIZ
    cp_reset();
#endif

    ++WP(_v_totalCount);

    switch (RP(_v_class)) {
        case CLASS_MOVING:
            ++WP(_v_movingCount);
            break;
        case CLASS_STATIONARY:
            ++WP(_v_stationaryCount);
            break;
    }

    if (RP(_v_totalCount) == SAMPLES_TO_COLLECT) {
        resultStationaryPct = RP(_v_stationaryCount) * 100 / RP(_v_totalCount);
        resultMovingPct = RP(_v_movingCount) * 100 / RP(_v_totalCount);
        sum = RP(_v_stationaryCount) + RP(_v_movingCount);
        coala_next_task(task_idle);
    } else {
        coala_next_task(task_sample);
    }

#if TSK_SIZ
    cp_sendRes("task_stats \0");
#endif
}

void task_warmup()
{
#if TSK_SIZ
    cp_reset();
#endif

    threeAxis_t_8 sample;

    if (RP(_v_discardedSamplesCount) < NUM_WARMUP_SAMPLES) {

        ACCEL_singleSample_(&sample);
        ++WP(_v_discardedSamplesCount);
        coala_next_task(task_warmup);
    } else {
        WP(_v_trainingSetSize) = 0;
        coala_next_task(task_sample);
    }

#if TSK_SIZ
    cp_sendRes("task_warmup \0");
#endif
}

void task_train()
{
#if TSK_SIZ
    cp_reset();
#endif

    switch (RP(_v_class)) {
        case CLASS_STATIONARY:
            WP(_v_model_stationary[RP(_v_trainingSetSize)].meanmag) = RP(_v_features.meanmag);
            WP(_v_model_stationary[RP(_v_trainingSetSize)].stddevmag) = RP(_v_features.stddevmag);
            break;
        case CLASS_MOVING:
            WP(_v_model_moving[RP(_v_trainingSetSize)].meanmag) = RP(_v_features.meanmag);
            WP(_v_model_moving[RP(_v_trainingSetSize)].stddevmag) = RP(_v_features.stddevmag);
            break;
    }

    ++WP(_v_trainingSetSize);

    if (RP(_v_trainingSetSize) < MODEL_SIZE) {
        coala_next_task(task_sample);
    } else {
        coala_next_task(task_idle);
    }

#if TSK_SIZ
    cp_sendRes("task_train \0");
#endif
}

void task_idle()
{

#if TSK_SIZ
    cp_reset();
#endif

    coala_next_task(task_selectMode);

#if TSK_SIZ
    cp_sendRes("task_idle \0");
#endif
}


void init()
{
    msp_watchdog_disable();
    msp_gpio_unlock();

#if ENABLE_PRF
    PRF_INIT();
    PRF_POWER();
#endif

    // msp_clock_set_mclk(CLK_8_MHZ);

#if TSK_SIZ|| EXECUTION_TIME
    uart_init();
    cp_init();
#endif

#if LOG_INFO
    uart_init();
#endif

#if AUTO_RST
    msp_reseter_auto_rand(RST_TIME);
#endif

#if ENABLE_PRF
    if (first_run) {
        PRF_APP_BGN();
        first_run = 0;
    }
#endif
}


int main(void)
{
    init();

    coala_init(task_init);

    coala_run();

    return 0;
}
