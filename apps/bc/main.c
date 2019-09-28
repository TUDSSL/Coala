#include <msp430.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

#include <mspReseter.h>
#include <mspProfiler.h>
#include <mspDebugger.h>
#include <mspbase.h>

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


#define SEED 4L
#define ITER 100
#define CHAR_BIT 8

__nv static char bits[256] =
{
    0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4,  /* 0   - 15  */
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,  /* 16  - 31  */
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,  /* 32  - 47  */
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 48  - 63  */
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,  /* 64  - 79  */
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 80  - 95  */
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 96  - 111 */
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,  /* 112 - 127 */
    1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,  /* 128 - 143 */
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 144 - 159 */
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 160 - 175 */
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,  /* 176 - 191 */
    2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 192 - 207 */
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,  /* 208 - 223 */
    3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,  /* 224 - 239 */
    4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8   /* 240 - 255 */
};

// Tasks.
COALA_TASK(task_init, 6)
COALA_TASK(task_select_func, 5)
COALA_TASK(task_bit_count, 5)
COALA_TASK(task_bitcount, 8)
COALA_TASK(task_ntbl_bitcnt, 6)
COALA_TASK(task_ntbl_bitcount, 6)
COALA_TASK(task_BW_btbl_bitcount, 5)
COALA_TASK(task_AR_btbl_bitcount, 5)
COALA_TASK(task_bit_shifter, 7)
COALA_TASK(task_end, 1)

// Task-shared protected variables.
COALA_PV(unsigned, _v_n_0);
COALA_PV(unsigned, _v_n_1);
COALA_PV(unsigned, _v_n_2);
COALA_PV(unsigned, _v_n_3);
COALA_PV(unsigned, _v_n_4);
COALA_PV(unsigned, _v_n_5);
COALA_PV(unsigned, _v_n_6);
COALA_PV(unsigned, _v_func);
COALA_PV(uint32_t, _v_seed);
COALA_PV(unsigned, _v_iter);


void task_init()
{
#if TSK_SIZ || EXECUTION_TIME
    cp_reset();
#endif

#if ENABLE_PRF
    full_run_started = 1;
#endif

    WP(_v_func) = 0;
    WP(_v_n_0) = 0;
    WP(_v_n_1) = 0;
    WP(_v_n_2) = 0;
    WP(_v_n_3) = 0;
    WP(_v_n_4) = 0;
    WP(_v_n_5) = 0;
    WP(_v_n_6) = 0;

    coala_next_task(task_select_func);

#if TSK_SIZ
    cp_sendRes("task_init \0");
#endif
}


void task_select_func()
{
#if TSK_SIZ
    cp_reset();
#endif

    WP(_v_seed) = (uint32_t) SEED; // for testing, seed is always the same
    WP(_v_iter) = 0;

    if (RP(_v_func) == 0) {
        WP(_v_func)++;
        coala_next_task(task_bit_count);
    }
    else if (RP(_v_func) == 1) {
        WP(_v_func)++;
        coala_next_task(task_bitcount);
    }
    else if (RP(_v_func) == 2) {
        WP(_v_func)++;
        coala_next_task(task_ntbl_bitcnt);
    }
    else if (RP(_v_func) == 3) {
        WP(_v_func)++;
        coala_next_task(task_ntbl_bitcount);
    }
    else if (RP(_v_func) == 4) {
        WP(_v_func)++;
        coala_next_task(task_BW_btbl_bitcount);
    }
    else if (RP(_v_func) == 5) {
        WP(_v_func)++;
        coala_next_task(task_AR_btbl_bitcount);
    }
    else if (RP(_v_func) == 6) {
        WP(_v_func)++;
        coala_next_task(task_bit_shifter);
    }
    else {
        coala_next_task(task_end);
    }

#if TSK_SIZ
    cp_sendRes("task_select_func \0");
#endif
}


void task_bit_count()
{
#if TSK_SIZ
    cp_reset();
#endif

    uint32_t tmp_seed = RP(_v_seed);
    WP(_v_seed) = tmp_seed + 13;
    unsigned temp = 0;

    if (tmp_seed) do
        temp++;
    while (0 != (tmp_seed = tmp_seed & (tmp_seed - 1)));

    WP(_v_n_0) += temp;
    WP(_v_iter)++;

    if (RP(_v_iter) < ITER) {
        coala_next_task(task_bit_count);
    }
    else {
        coala_next_task(task_select_func);
    }

#if TSK_SIZ
    cp_sendRes("task_bit_count \0");
#endif
}


void task_bitcount()
{
#if TSK_SIZ
    cp_reset();
#endif

    uint32_t tmp_seed = RP(_v_seed);
    WP(_v_seed) = tmp_seed + 13;

    tmp_seed = ((tmp_seed & 0xAAAAAAAAL) >>  1) + (tmp_seed & 0x55555555L);
    tmp_seed = ((tmp_seed & 0xCCCCCCCCL) >>  2) + (tmp_seed & 0x33333333L);
    tmp_seed = ((tmp_seed & 0xF0F0F0F0L) >>  4) + (tmp_seed & 0x0F0F0F0FL);
    tmp_seed = ((tmp_seed & 0xFF00FF00L) >>  8) + (tmp_seed & 0x00FF00FFL);
    tmp_seed = ((tmp_seed & 0xFFFF0000L) >> 16) + (tmp_seed & 0x0000FFFFL);
    
    WP(_v_n_1) += (int)tmp_seed;
    WP(_v_iter)++;

    if (RP(_v_iter) < ITER) {
        coala_next_task(task_bitcount);
    }
    else {
        coala_next_task(task_select_func);
    }

#if TSK_SIZ
    cp_sendRes("task_bitcount \0");
#endif
}


int recursive_cnt(uint32_t x)
{
    int cnt = bits[(int)(x & 0x0000000FL)];

    if (0L != (x >>= 4))
        cnt += recursive_cnt(x);

    return cnt;
}

int non_recursive_cnt(uint32_t x)
{
    int cnt = bits[(int)(x & 0x0000000FL)];

    while (0L != (x >>= 4)) {
        cnt += bits[(int)(x & 0x0000000FL)];
    }

    return cnt;
}

void task_ntbl_bitcnt()
{
#if TSK_SIZ
    cp_reset();
#endif

    // TRICK ALERT!
    uint32_t tmp_seed = RP(_v_seed);
    WP(_v_n_2) += non_recursive_cnt(tmp_seed);
    WP(_v_seed) = tmp_seed + 13;
    WP(_v_iter)++;

    if (RP(_v_iter) < ITER) {
        coala_next_task(task_ntbl_bitcnt);
    }
    else {
        coala_next_task(task_select_func);
    }

#if TSK_SIZ
    cp_sendRes("task_ntbl_bitcnt \0");
#endif
}


void task_ntbl_bitcount()
{
#if TSK_SIZ
    cp_reset();
#endif
    // TRICK ALERT!
    uint16_t __cry = RP(_v_seed);

    WP(_v_n_3) +=
        bits[ (int) (__cry & 0x0000000FUL)] +
        bits[ (int)((__cry & 0x000000F0UL) >> 4) ] +
        bits[ (int)((__cry & 0x00000F00UL) >> 8) ] +
        bits[ (int)((__cry & 0x0000F000UL) >> 12)] +
        bits[ (int)((__cry & 0x000F0000UL) >> 16)] +
        bits[ (int)((__cry & 0x00F00000UL) >> 20)] +
        bits[ (int)((__cry & 0x0F000000UL) >> 24)] +
        bits[ (int)((__cry & 0xF0000000UL) >> 28)];

    // TRICK ALERT!
    uint32_t tmp_seed = RP(_v_seed);
    WP(_v_seed) = tmp_seed + 13;
    WP(_v_iter)++;

    if (RP(_v_iter) < ITER) {
        coala_next_task(task_ntbl_bitcount);
    }
    else {
        coala_next_task(task_select_func);
    }

#if TSK_SIZ
    cp_sendRes("task_ntbl_bitcount \0");
#endif
}


void task_BW_btbl_bitcount()
{
#if TSK_SIZ
    cp_reset();
#endif

    union {
        unsigned char ch[4];
        long y;
    } U;

    U.y = RP(_v_seed);

    WP(_v_n_4) += bits[ U.ch[0] ] + bits[ U.ch[1] ] +
        bits[ U.ch[3] ] + bits[ U.ch[2] ];

    // TRICK ALERT!
    uint32_t tmp_seed = RP(_v_seed);
    WP(_v_seed) = tmp_seed + 13;
    WP(_v_iter)++;

    if (RP(_v_iter) < ITER) {
        coala_next_task(task_BW_btbl_bitcount);
    }
    else {
        coala_next_task(task_select_func);
    }

#if TSK_SIZ
    cp_sendRes("task_BW_btbl_bitcount \0");
#endif
}


void task_AR_btbl_bitcount()
{
#if TSK_SIZ
    cp_reset();
#endif

    unsigned char * Ptr = (unsigned char *) &RP(_v_seed);
    int Accu;

    Accu  = bits[ *Ptr++ ];
    Accu += bits[ *Ptr++ ];
    Accu += bits[ *Ptr++ ];
    Accu += bits[ *Ptr ];
    WP(_v_n_5)+= Accu;

    // TRICK ALERT!
    uint32_t tmp_seed = RP(_v_seed);
    WP(_v_seed) = tmp_seed + 13;
    WP(_v_iter)++;

    if (RP(_v_iter) < ITER) {
        coala_next_task(task_AR_btbl_bitcount);
    }
    else {
        coala_next_task(task_select_func);
    }

#if TSK_SIZ
    cp_sendRes("task_AR_btbl_bitcount \0");
#endif
}

void task_bit_shifter()
{
#if TSK_SIZ
    cp_reset();
#endif

    unsigned i, nn;
    uint32_t tmp_seed = RP(_v_seed);

    for (i = nn = 0; tmp_seed && (i < (sizeof(long) * CHAR_BIT)); ++i, tmp_seed >>= 1)
        nn += (unsigned)(tmp_seed & 1L);

    WP(_v_n_6) += nn;

    // TRICK ALERT!
    tmp_seed = RP(_v_seed);
    tmp_seed += 13;
    WP(_v_seed) = tmp_seed;

    WP(_v_iter)++;

    if (RP(_v_iter) < ITER) {
        coala_next_task(task_bit_shifter);
    }
    else {
        coala_next_task(task_select_func);
    }

#if TSK_SIZ
    cp_sendRes("task_bit_shifter \0");
#endif
}

void task_end()
{
#if TSK_SIZ
    cp_reset();
#endif

#if ENABLE_PRF
    if (full_run_started) {
#if AUTO_RST
        msp_reseter_halt();
#endif
        PRF_APP_END();
        full_run_started = 0;
        coala_force_commit();
#if AUTO_RST
        msp_reseter_resume();
#endif
    }
#endif

    coala_next_task(task_init);

#if EXECUTION_TIME
cp_sendRes("bc");
uart_sendHex16(fullpage_fault_counter);
uart_sendStr("\n\r\0");
uart_sendHex16(page_fault_counter);
uart_sendStr("\n\r\0");
#endif

#if TSK_SIZ
    cp_sendRes("task_end \0");
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

#if TSK_SIZ || EXECUTION_TIME
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
