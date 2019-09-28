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

#define NIL 0 // like NULL, but for indexes, not real pointers

#define DICT_SIZE         512
#define BLOCK_SIZE         64

#define NUM_LETTERS_IN_SAMPLE        2
#define LETTER_MASK             0x00FF
#define LETTER_SIZE_BITS             8
#define NUM_LETTERS (LETTER_MASK + 1)


typedef uint16_t index_t;
typedef uint16_t letter_t;
typedef uint16_t sample_t;

// NOTE: can't use pointers, since need to ChSync, etc
typedef struct _node_t {
    COALA_SM(letter_t, letter); // 'letter' of the alphabet
    COALA_SM(index_t, sibling); // this node is a member of the parent's children list
    COALA_SM(index_t, child);   // link-list of children
} node_t;

// Tasks.
COALA_TASK(task_init, 1)
COALA_TASK(task_init_dict, 3)
COALA_TASK(task_sample, 1)
COALA_TASK(task_measure_temp, 1)
COALA_TASK(task_letterize, 5)
COALA_TASK(task_compress, 2)
COALA_TASK(task_find_sibling, 3)
COALA_TASK(task_add_node, 3)
COALA_TASK(task_add_insert, 5)
COALA_TASK(task_append_compressed, 2)
COALA_TASK(task_print, 3)
COALA_TASK(task_done, 1)


COALA_PV(node_t, _v_compressed_data, BLOCK_SIZE);
COALA_PV(letter_t, _v_letter);
COALA_PV(unsigned, _v_letter_idx);
COALA_PV(sample_t, _v_prev_sample);
COALA_PV(index_t, _v_out_len);
COALA_PV(index_t, _v_node_count);
COALA_PV(sample_t, _v_sample);
COALA_PV(index_t, _v_sample_count);
COALA_PV(index_t, _v_sibling);
COALA_PV(index_t, _v_child);
COALA_PV(index_t, _v_parent);
COALA_PV(index_t, _v_parent_next);
COALA_PV(node_t, _v_parent_node);
COALA_PV(node_t, _v_sibling_node);
COALA_PV(index_t, _v_symbol);
COALA_PV(node_t, _v_dict, DICT_SIZE);


static sample_t acquire_sample(letter_t prev_sample)
{
    letter_t sample = (prev_sample + 1) & 0x03;
    return sample;
}


void task_init()
{
#if TSK_SIZ
    cp_reset();
#endif

#if ENABLE_PRF
    full_run_started = 1;
#endif

    WP(_v_parent_next) = 0;
    WP(_v_out_len) = 0;
    WP(_v_letter) = 0;
    WP(_v_prev_sample) = 0;
    WP(_v_letter_idx) = 0;
    WP(_v_sample_count) = 1;

    coala_next_task(task_init_dict);

#if TSK_SIZ
    cp_sendRes("task_init \0");
#endif
}


void task_init_dict()
{
#if TSK_SIZ
    cp_reset();
#endif

    uint16_t i = RP(_v_letter);

    WP(_v_dict[i].letter) = i ;
    WP(_v_dict[i].sibling) =  NIL;
    WP(_v_dict[i].child) = NIL;
    WP(_v_letter)++;
    if (i < NUM_LETTERS) {
        coala_next_task(task_init_dict);
    } else {
        WP(_v_node_count) =  NUM_LETTERS;
        coala_next_task(task_sample);
    }


#if TSK_SIZ
    cp_sendRes("task_init_dict \0");
#endif
}


void task_sample()
{
#if TSK_SIZ
    cp_reset();
#endif

    unsigned next_letter_idx = RP(_v_letter_idx) + 1;
    if (next_letter_idx == NUM_LETTERS_IN_SAMPLE)
        next_letter_idx = 0;

    if (RP(_v_letter_idx) == 0) {
        WP(_v_letter_idx) = next_letter_idx;
        coala_next_task(task_measure_temp);
    } else {
        WP(_v_letter_idx) = next_letter_idx;
        coala_next_task(task_letterize);
    }

#if TSK_SIZ
    cp_sendRes("task_sample \0");
#endif
}


void task_measure_temp()
{
#if TSK_SIZ
    cp_reset();
#endif

    sample_t prev_sample;
    prev_sample = RP(_v_prev_sample);

    sample_t sample = acquire_sample(prev_sample);
    prev_sample = sample;
    WP(_v_prev_sample) = prev_sample;
    WP(_v_sample) = sample;
    coala_next_task(task_letterize);

#if TSK_SIZ
    cp_sendRes("task_measure_temp \0");
#endif
}


void task_letterize()
{
#if TSK_SIZ
    cp_reset();
#endif

    unsigned letter_idx = RP(_v_letter_idx);
    if (letter_idx == 0)
        letter_idx = NUM_LETTERS_IN_SAMPLE;
    else
        letter_idx--;

    unsigned letter_shift = LETTER_SIZE_BITS * letter_idx;
    letter_t letter = (RP(_v_sample) & (LETTER_MASK << letter_shift)) >> letter_shift;

    WP(_v_letter) = letter;
    coala_next_task(task_compress);

#if TSK_SIZ
    cp_sendRes("task_letterize \0");
#endif
}


void task_compress()
{
#if TSK_SIZ
    cp_reset();
#endif

    // pointer into the dictionary tree; starts at a root's child
    index_t parent = RP(_v_parent_next);

    uint16_t __cry;

    __cry = RP(_v_dict[parent].child);
    WP(_v_sibling) = __cry ;
    __cry = RP(_v_dict[parent].letter);
    WP(_v_parent_node.letter) =  __cry;
    __cry = RP(_v_dict[parent].sibling);
    WP(_v_parent_node.sibling) = __cry;
    __cry = RP(_v_dict[parent].child);
    WP(_v_parent_node.child) = __cry;
    WP(_v_parent) = parent;
    __cry = RP(_v_dict[parent].child);
    WP(_v_child) = __cry;
    (WP(_v_sample_count))++;

    coala_next_task(task_find_sibling);

#if TSK_SIZ
    cp_sendRes("task_compress \0");
#endif
}


void task_find_sibling()
{
#if TSK_SIZ
    cp_reset();
#endif

    if (RP(_v_sibling) != NIL) {
        int i = RP(_v_sibling);

        uint16_t __cry = RP(_v_letter);
        if (RP(_v_dict[i].letter) == __cry ) { // found

            __cry = RP(_v_sibling);
            WP(_v_parent_next) = __cry;

            coala_next_task(task_letterize);
            return;
        } else { // continue traversing the siblings
            if(RP(_v_dict[i].sibling) != 0){
                __cry = RP(_v_dict[i].sibling);
                WP(_v_sibling) = __cry;
                coala_next_task(task_find_sibling);
                return;
            }
        }

    }

    index_t starting_node_idx = (index_t)RP(_v_letter);
    WP(_v_parent_next) = starting_node_idx;

    if (RP(_v_child) == NIL) {
        coala_next_task(task_add_insert);
    }
    else {
        coala_next_task(task_add_node);
    }

#if TSK_SIZ
    cp_sendRes("task_find_sibling \0");
#endif
}


void task_add_node()
{
#if TSK_SIZ
    cp_reset();
#endif

    int i = RP(_v_sibling);


    if (RP(_v_dict[i].sibling) != NIL) {
        index_t next_sibling = RP(_v_dict[i].sibling);
        WP(_v_sibling) = next_sibling;
        coala_next_task(task_add_node);

    } else { // found last sibling in the list

        uint16_t __cry;

        __cry = RP(_v_dict[i].letter);
        WP(_v_sibling_node.letter) = __cry;
        __cry = RP(_v_dict[i].sibling);
        WP(_v_sibling_node.sibling) = __cry;
        __cry = RP(_v_dict[i].child);
        WP(_v_sibling_node.child) = __cry;

        coala_next_task(task_add_insert);
    }

#if TSK_SIZ
    cp_sendRes("task_add_node \0");
#endif
}


void task_add_insert()
{
#if TSK_SIZ
    cp_reset();
#endif

    if (RP(_v_node_count) == DICT_SIZE) { // wipe the table if full
        while (1);
    }

    index_t child = RP(_v_node_count);
    uint16_t __cry;
    if (RP(_v_parent_node.child) == NIL) { // the only child

        int i = RP(_v_parent);

        __cry = RP(_v_parent_node.letter);
        WP(_v_dict[i].letter) = __cry;
        __cry  = RP(_v_parent_node.sibling);
        WP(_v_dict[i].sibling) = __cry;
        __cry = child;
        WP(_v_dict[i].child) = __cry;

    } else { // a sibling

        index_t last_sibling = RP(_v_sibling);

        __cry = RP(_v_sibling_node.letter);
        WP(_v_dict[last_sibling].letter) = __cry;
        __cry = child;
        WP(_v_dict[last_sibling].sibling) = __cry;
        __cry  = RP(_v_sibling_node.child);
        WP(_v_dict[last_sibling].child) = __cry;
    }
    __cry = RP(_v_letter);
    WP(_v_dict[child].letter) = __cry;
    WP(_v_dict[child].sibling) = NIL;
    WP(_v_dict[child].child) = NIL;
    __cry = RP(_v_parent);
    WP(_v_symbol) = __cry;
    (WP(_v_node_count))++;

    coala_next_task(task_append_compressed);

#if TSK_SIZ
    cp_sendRes("task_add_insert \0");
#endif
}


void task_append_compressed()
{
#if TSK_SIZ
    cp_reset();
#endif

    uint16_t __cry;
    int i = RP(_v_out_len);
    __cry = RP(_v_symbol);
    WP(_v_compressed_data[i].letter) = __cry;

    if ( (++(WP(_v_out_len))) == BLOCK_SIZE) {
        coala_next_task(task_print);
    } else {
        coala_next_task(task_sample);
    }

#if TSK_SIZ
    cp_sendRes("task_append_compressed \0");
#endif
}


void task_print()
{
#if TSK_SIZ
    cp_reset();
#endif

    // unsigned i;

    // for (i = 0; i < BLOCK_SIZE; ++i) {
    //     index_t index = RP(_v_compressed_data[i].letter);
    //     printf("%u, ", index);
    // }
    // printf("\n");

    coala_next_task(task_done);

#if TSK_SIZ
    cp_sendRes("task_print \0");
#endif
}


void task_done()
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

#if TSK_SIZ
    cp_sendRes("task_done \0");
#endif
}


void init()
{
    msp_watchdog_disable();
    msp_gpio_unlock();

#if ENABLE_PRF
    PRF_INIT();
#endif

    // msp_clock_set_mclk(CLK_8_MHZ);

#if TSK_SIZ
    uart_init();
    cp_init();
#endif

#if LOG_INFO
    uart_init();
#endif

#if AUTO_RST
    PRF_POWER();
    msp_reseter_auto_rand(RST_TIME);
#endif
}


int main(void)
{
    init();

    coala_init(task_init);

#if ENABLE_PRF
    if (first_run) {
        PRF_APP_BGN();
        first_run = 0;
    }
#endif

    coala_run();

    return 0;
}
