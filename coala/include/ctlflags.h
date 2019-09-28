/******************************************************************************
 * File: ctlflags.h                                                           *
 *                                                                            *
 * Description: control flags to choose coalescing algorithm and              *
 *              enable/disable profiling.                                     *
 *                                                                            *
 * Authors: Amjad Majid, Carlo Delle Donne                                    *
 ******************************************************************************/

#ifndef INCLUDE_CTLFLAGS_H
#define INCLUDE_CTLFLAGS_H


/**
 * Paging control.
 */
#define PAG_FAULT_CNTR 0

/**
 * Scheduling control.
 *
 * Select ONE of the following algorithms.
 */
#define NO_COALESCING 0
#define SLOW_ALG 0
#define FAST_ALG 0
#define FAST_TASK_AWARE_ALG 0
#define VALLEY_ALG 1
#define VALLEY_TASK_AWARE_ALG 0

#if NO_COALESCING + \
	SLOW_ALG + \
	FAST_ALG + \
	FAST_TASK_AWARE_ALG + \
	VALLEY_ALG + \
	VALLEY_TASK_AWARE_ALG != 1
#error "Select one and only one algorithm"
#endif

/**
 * Logging control.
 */
#define COAL_TSK_SIZ_SEND 0
#define NUM_PWR_INTR_MEM_DUMP 0

/**
 * Profiling control.
 */
#define PROFILE_POWER     1
#define PROFILE_APP       1
#define PROFILE_SCHEDULER 0
#define PROFILE_MEMORY    0
#define PROFILE_TASK      0
#define PROFILE_COMMIT    0

#if (PROFILE_SCHEDULER + PROFILE_TASK > 1)
#error "SCHEDULER and TASK profiling use the same GPIO"
#endif

#if (PROFILE_MEMORY + PROFILE_COMMIT > 1)
#error "MEMORY and COMMIT profiling use the same GPIO"
#endif

// For WISP:
// AUX1 - P3.4
// AUX2 - P3.5 (APP)
// AUX3 - P1.4 (POWER)
#define WISP 1

#if PROFILE_APP
#define PRF_APP_BGN()       msp_gpio_spike(3, 5)
#define PRF_APP_END()       msp_gpio_spike(3, 5)
#else
#define PRF_APP_BGN()
#define PRF_APP_END()
#endif

#if PROFILE_SCHEDULER
#define PRF_SCHEDULER_BGN() msp_gpio_set(3, 5)
#define PRF_SCHEDULER_END() msp_gpio_clear(3, 5)
#else
#define PRF_SCHEDULER_BGN()
#define PRF_SCHEDULER_END()
#endif

#if PROFILE_MEMORY
#define PRF_MEMORY_BGN()    msp_gpio_set(3, 6)
#define PRF_MEMORY_END()    msp_gpio_clear(3, 6)
#else
#define PRF_MEMORY_BGN()
#define PRF_MEMORY_END()
#endif

#if PROFILE_TASK
#define PRF_TASK_BGN()      msp_gpio_set(3, 5)
#define PRF_TASK_END()      msp_gpio_clear(3, 5)
#else
#define PRF_TASK_BGN()
#define PRF_TASK_END()
#endif

#if PROFILE_COMMIT
#define PRF_COMMIT()        msp_gpio_spike(3, 6)
#define PRF_COMMIT_BGN()    msp_gpio_set(3, 6)
#define PRF_COMMIT_END()    msp_gpio_clear(3, 6)
#else
#define PRF_COMMIT()
#define PRF_COMMIT_BGN()
#define PRF_COMMIT_END()
#endif

#if PROFILE_POWER
#define PRF_POWER()         msp_gpio_set(1, 4)
#else
#define PRF_POWER()
#endif

#if WISP
#define PRF_INIT() \
    msp_gpio_clear(1, 4); \
    msp_gpio_clear(3, 5); \
    msp_gpio_dir_out(1, 4); \
    msp_gpio_dir_out(3, 5)
#else
#define PRF_INIT() \
    msp_gpio_clear(4, 2); \
    msp_gpio_clear(2, 6); \
    msp_gpio_clear(2, 5); \
    msp_gpio_clear(4, 3); \
    msp_gpio_clear(2, 4); \
    msp_gpio_clear(2, 2); \
    msp_gpio_clear(3, 4); \
    msp_gpio_clear(3, 5); \
    msp_gpio_clear(3, 6); \
    msp_gpio_clear(1, 2); \
    msp_gpio_clear(3, 0); \
    msp_gpio_clear(1, 6); \
    msp_gpio_clear(1, 7); \
    msp_gpio_clear(1, 5); \
    msp_gpio_clear(1, 4); \
    msp_gpio_clear(1, 3); \
    msp_gpio_dir_out(4, 2); \
    msp_gpio_dir_out(2, 6); \
    msp_gpio_dir_out(2, 5); \
    msp_gpio_dir_out(4, 3); \
    msp_gpio_dir_out(2, 4); \
    msp_gpio_dir_out(2, 2); \
    msp_gpio_dir_out(3, 4); \
    msp_gpio_dir_out(3, 5); \
    msp_gpio_dir_out(3, 6); \
    msp_gpio_dir_out(1, 2); \
    msp_gpio_dir_out(3, 0); \
    msp_gpio_dir_out(1, 6); \
    msp_gpio_dir_out(1, 7); \
    msp_gpio_dir_out(1, 5); \
    msp_gpio_dir_out(1, 4); \
    msp_gpio_dir_out(1, 3)
#endif

#endif /* INCLUDE_CTLFLAGS_H */
