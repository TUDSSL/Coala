#include <msp430.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
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


#define NUM_BUCKETS 128 // must be a power of 2
#define NUM_INSERTS (NUM_BUCKETS / 4) // shoot for 25% occupancy
#define NUM_LOOKUPS NUM_INSERTS
#define MAX_RELOCATIONS 8
#define BUFFER_SIZE 32

typedef uint16_t value_t;
typedef uint16_t hash_t;
typedef uint16_t fingerprint_t;
typedef uint16_t index_t; // bucket index

typedef struct _insert_count {
    unsigned insert_count;
    unsigned inserted_count;
} insert_count_t;

typedef struct _lookup_count {
    unsigned lookup_count;
    unsigned member_count;
} lookup_count_t;

// Tasks.
COALA_TASK(task_init, 50)
COALA_TASK(task_generate_key, 3)
COALA_TASK(task_calc_indexes, 3)
COALA_TASK(task_calc_indexes_index_1, 3)
COALA_TASK(task_calc_indexes_index_2, 4)
COALA_TASK(task_insert, 1)
COALA_TASK(task_add, 5)
COALA_TASK(task_relocate, 5)
COALA_TASK(task_insert_done, 5)
COALA_TASK(task_lookup, 1)
COALA_TASK(task_lookup_search, 4)
COALA_TASK(task_lookup_done, 5)
COALA_TASK(task_print_stats, 1)
COALA_TASK(task_done, 1)

// NOT USED.
COALA_TASK(task_init_array, 1)

// Task-shared protected variables.
COALA_PV(fingerprint_t, _v_filter, NUM_BUCKETS);
COALA_PV(index_t, _v_index);
COALA_PV(value_t, _v_key);
COALA_PV(task_pt, _v_next_task);
COALA_PV(fingerprint_t, _v_fingerprint);
COALA_PV(value_t, _v_index1);
COALA_PV(value_t, _v_index2);
COALA_PV(value_t, _v_relocation_count);
COALA_PV(value_t, _v_insert_count);
COALA_PV(value_t, _v_inserted_count);
COALA_PV(value_t, _v_lookup_count);
COALA_PV(value_t, _v_member_count);
COALA_PV(bool, _v_success);
COALA_PV(bool, _v_member);


static value_t init_key = 0x0001; // seeds the pseudo-random sequence of keys

static hash_t djb_hash(uint8_t* data, unsigned len)
{
    uint16_t hash = 5381;
    unsigned int i;

    for (i = 0; i < len; data++, i++)
        hash = ((hash << 5) + hash) + (*data);

    return hash & 0xFFFF;
}

static index_t hash_to_index(fingerprint_t fp)
{
    hash_t hash = djb_hash((uint8_t *) &fp, sizeof(fingerprint_t));
    return hash & (NUM_BUCKETS - 1); // NUM_BUCKETS must be power of 2
}

static fingerprint_t hash_to_fingerprint(value_t key)
{
    return djb_hash((uint8_t *) &key, sizeof(value_t));
}


void task_init()
{
#if TSK_SIZ || EXECUTION_TIME
    cp_reset();
#endif

#if ENABLE_PRF
    full_run_started = 1;
#endif

    unsigned i;
    for (i = 0; i < NUM_BUCKETS ; ++i) {
        WP(_v_filter[i]) = 0;
    }

    WP(_v_insert_count) = 0;
    WP(_v_lookup_count) = 0;
    WP(_v_inserted_count) = 0;
    WP(_v_member_count) = 0;
    WP(_v_key) = init_key;
    WP(_v_next_task) = task_insert;

    coala_next_task(task_generate_key);

#if TSK_SIZ
    cp_sendRes("task_init \0");
#endif
}


void task_init_array()
{
#if TSK_SIZ
    cp_reset();
#endif

    unsigned i;
    for (i = 0; i < BUFFER_SIZE - 1; ++i) {
        WP(_v_filter[i + RP(_v_index)*(BUFFER_SIZE-1)]) = 0;
    }

    ++WP(_v_index);
    if (RP(_v_index) == NUM_BUCKETS / (BUFFER_SIZE - 1)) {
        coala_next_task(task_generate_key);
    }
    else {
        coala_next_task(task_init_array);
    }

#if TSK_SIZ
    cp_sendRes("task_init_array \0");
#endif
}


void task_generate_key()
{
#if TSK_SIZ
    cp_reset();
#endif

    // Insert pseudo-random integers, for testing.
    // If we use consecutive ints, they hash to consecutive DJB hashes...
    // NOTE: we are not using rand(), to have the sequence available to verify
    // that there are no false negatives (and avoid having to save the values).

    uint16_t __cry;

    __cry = (RP(_v_key) + 1) * 17;
    WP(_v_key) = __cry;

    task_pt next_task = RP(_v_next_task);

    if (next_task == task_insert) {
        coala_next_task(task_insert);
    } else if (next_task == task_lookup) {
        coala_next_task(task_lookup);
    } else {
        while(1); // Debugging purpose
    }

#if TSK_SIZ
   cp_sendRes("task_generate_key \0");
#endif
}


void task_calc_indexes()
{
#if TSK_SIZ
    cp_reset();
#endif

    uint16_t __cry;
    __cry = hash_to_fingerprint(RP(_v_key));
    WP(_v_fingerprint) = __cry;

    coala_next_task(task_calc_indexes_index_1);

#if TSK_SIZ
    cp_sendRes("task_calc_indexes \0");
#endif
}


void task_calc_indexes_index_1()
{
#if TSK_SIZ
    cp_reset();
#endif

    uint16_t __cry;
    __cry = hash_to_index(RP(_v_key));
    WP(_v_index1) = __cry;

    coala_next_task(task_calc_indexes_index_2);

#if TSK_SIZ
    cp_sendRes("task_calc_indexes_index_1 \0");
#endif
}


void task_calc_indexes_index_2()
{
#if TSK_SIZ
    cp_reset();
#endif

    index_t fp_hash = hash_to_index(RP(_v_fingerprint));
    uint16_t __cry;
    __cry = RP(_v_index1) ^ fp_hash;
    WP(_v_index2) = __cry;

    task_pt next_task = RP(_v_next_task);

    if (next_task == task_add) {
        coala_next_task(task_add);
    } else if (next_task == task_lookup_search) {
        coala_next_task(task_lookup_search);
    } else {
        while(1); // Debugging purpose
    }

#if TSK_SIZ
    cp_sendRes("task_calc_indexes_index_2 \0");
#endif
}


// This task is redundant.
// Alpaca never needs this but since Chain code had it, leaving it for fair comparison.
void task_insert()
{
#if TSK_SIZ
    cp_reset();
#endif

    WP(_v_next_task) = task_add;
    coala_next_task(task_calc_indexes);

#if TSK_SIZ
    cp_sendRes("task_insert \0");
#endif
}


void task_add()
{
#if TSK_SIZ
    cp_reset();
#endif

    uint16_t __cry;
    uint16_t __cry_idx = RP(_v_index1);
    uint16_t __cry_idx2 = RP(_v_index2);
    
    if (!RP(_v_filter[__cry_idx])) {
        WP(_v_success) = true;
        __cry = RP(_v_fingerprint);
        WP(_v_filter[__cry_idx]) = __cry;
        coala_next_task(task_insert_done);
    } else {
        if (!RP(_v_filter[__cry_idx2])) {
            WP(_v_success) = true;
            __cry = RP(_v_fingerprint);
            WP(_v_filter[__cry_idx2])  = __cry;
            coala_next_task(task_insert_done);
        } else { // evict one of the two entries
            fingerprint_t fp_victim;
            index_t index_victim;

            if (rand() % 2) {
                index_victim = __cry_idx;
                fp_victim = RP(_v_filter[__cry_idx]);
            } else {
                index_victim = __cry_idx2;
                fp_victim = RP(_v_filter[__cry_idx2]);
            }

            // Evict the victim
            __cry = RP(_v_fingerprint);
            WP(_v_filter[RP(index_victim)])  = __cry;
            WP(_v_index1) = index_victim;
            WP(_v_fingerprint) = fp_victim;
            WP(_v_relocation_count) = 0;

            coala_next_task(task_relocate);
        }
    }

#if TSK_SIZ
    cp_sendRes("task_add \0");
#endif
}


void task_relocate()
{
#if TSK_SIZ
    cp_reset();
#endif

    uint16_t __cry;
    fingerprint_t fp_victim = RP(_v_fingerprint);
    index_t fp_hash_victim = hash_to_index(fp_victim);
    index_t index2_victim = RP(_v_index1) ^ fp_hash_victim;

    if (!RP(_v_filter[index2_victim])) { // slot was free
        WP(_v_success) = true;
        WP(_v_filter[index2_victim]) = fp_victim;
        coala_next_task(task_insert_done);
    } else { // slot was occupied, rellocate the next victim
        if (RP(_v_relocation_count) >= MAX_RELOCATIONS) { // insert failed
            WP(_v_success) = false;
            coala_next_task(task_insert_done);
            return;
        }

        ++WP(_v_relocation_count);
        WP(_v_index1) = index2_victim;
        __cry = RP(_v_filter[index2_victim]);
        WP(_v_fingerprint) = __cry;
        WP(_v_filter[index2_victim]) = fp_victim;
        coala_next_task(task_relocate);
    }

#if TSK_SIZ
    cp_sendRes("task_relocate \0");
#endif
}


void task_insert_done()
{
#if TSK_SIZ
    cp_reset();
#endif

    uint16_t __cry;
    ++WP(_v_insert_count);
    __cry = RP(_v_inserted_count);
    __cry+= RP(_v_success);
    WP(_v_inserted_count) = __cry;

    if (RP(_v_insert_count) < NUM_INSERTS) {
        WP(_v_next_task) = task_insert;
        coala_next_task(task_generate_key);
    } else {
        WP(_v_next_task) = task_lookup;
        WP(_v_key) = init_key;
        coala_next_task(task_generate_key);
    }

#if TSK_SIZ
    cp_sendRes("task_insert_done \0");
#endif
}


void task_lookup()
{
#if TSK_SIZ
    cp_reset();
#endif

    WP(_v_next_task) = task_lookup_search;
    coala_next_task(task_calc_indexes);

#if TSK_SIZ
    cp_sendRes("task_lookup \0");
#endif
}


void task_lookup_search()
{
#if TSK_SIZ
    cp_reset();
#endif

    if (RP(_v_filter[RP(_v_index1)]) == RP(_v_fingerprint)) {
        WP(_v_member) = true;
    } else {
        if (RP(_v_filter[RP(_v_index2)]) == RP(_v_fingerprint)) {
            WP(_v_member) = true;
        } else {
            WP(_v_member) = false;
        }
    }

    coala_next_task(task_lookup_done);

#if TSK_SIZ
    cp_sendRes("task_lookup_search \0");
#endif
}


void task_lookup_done()
{
#if TSK_SIZ
    cp_reset();
#endif

    uint16_t __cry;
    ++WP(_v_lookup_count);
    __cry = RP(_v_member_count) ;
    __cry+= RP(_v_member);
    WP(_v_member_count)  = __cry;

    if (RP(_v_lookup_count) < NUM_LOOKUPS) {
        WP(_v_next_task) = task_lookup;
        coala_next_task(task_generate_key);
    } else {
        coala_next_task(task_print_stats);
    }

#if TSK_SIZ
    cp_sendRes("task_lookup_done \0");
#endif
}


void task_print_stats()
{
    // Print output here

    // unsigned i;
    // for (i = 0; i < NUM_BUCKETS; ++i) {
    //     printf("%04x ", RP(_v_filter[i]));
    //     if (i > 0 && (i + 1) % 8 == 0){
    //         printf("\n");
    //     }
    // }

    __no_operation();

    coala_next_task(task_done);
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
#if AUTO_RST
        msp_reseter_resume();
#endif
    }
#endif

#if EXECUTION_TIME
cp_sendRes("cuckoo");
uart_sendHex16(fullpage_fault_counter);
uart_sendStr("\n\r\0");
uart_sendHex16(page_fault_counter);
uart_sendStr("\n\r\0");
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
