/******************************************************************************
 * File: scheduler.c                                                          *
 *                                                                            *
 * Look at scheduler.h for functions documentation.                           *
 *                                                                            *
 * Note: this is an internal set of functionalities used by Coala's kernel,   *
 *       do not modify or use externally.                                     *
 *                                                                            *
 * Authors: Amjad Majid, Carlo Delle Donne                                    *
 ******************************************************************************/

#include <msp430.h>
#include <stdint.h>
#include <mspprintf.h>
#include <mspProfiler.h>
#include <mspReseter.h>

#include <scheduler.h>
#include <global.h>
#include <dataprotect.h>
#include <ctlflags.h>
#include <partialcommit.h>

#define pwr_int_count    (*(uint16_t*)(0x1990))
#define pwr_int_overflow (*(uint16_t*)(0x1992))

#define MAX_TARGET_SIZE 0x0400 // Max 1024 coalesced tasks

// MIN_TARGET's benefits are really app-dependant
#if FAST_TASK_AWARE_ALG || VALLEY_TASK_AWARE_ALG
#define MIN_TARGET 16
#else
#define MIN_TARGET 2
#endif

// Commit phase.
__nv uint8_t commit_flag = COMMIT_FINISH;

// Task function pointers.
task_pt real_task_addr;
task_pt next_real_task_addr;
__nv task_pt coalesced_task_addr;
__nv task_pt next_coalesced_task_addr;

// Coalescing.
// Refactoring:
// target_size          -> target_budget
// coalesced_task_count -> current_budget
// total_task_count     -> history
// last_task_count      -> previous_history
// decrease_target_size -> decrease_target
__nv uint16_t target_budget = 1;
uint16_t current_budget = 0;
__nv uint16_t history = 10; // TODO: why exactly this value?
uint16_t previous_history;
uint8_t decrease_target = 1;

// Time weight.
uint8_t real_task_time_wgt;
uint8_t next_real_task_time_wgt;
__nv uint8_t coalesced_task_time_wgt;
__nv uint8_t next_coalesced_task_time_wgt;

// Defined in dataprotect.c
extern ram_page_metadata_t ram_pages_buf[];
extern uint16_t shadow_buf_pages_count;

// Defined in partialcommit.c
extern uint8_t checkpoint_available;
extern uint8_t death_count;


INLINE void reboot_prologue();
INLINE void recall_persistent_state();
INLINE void initialize_sram_buffer();
INLINE void recall_coalescing_state();
INLINE void static_task_epilogue();
INLINE void save_volatile_state();
INLINE void commit_to_shadow();
INLINE void commit_to_store();
INLINE void update_target_budget();


void __scheduler()
{
#if NUM_PWR_INTR_MEM_DUMP
    pwr_int_count++;
    if (pwr_int_count == 0) {
        pwr_int_overflow++;
    }
#endif

    PRF_SCHEDULER_BGN();

    // Update target budget and history after a power failure.
    reboot_prologue();

    // Resume from commit phase 2 if power failed during that phase.
    if (commit_flag == COMMITTING) {
#if ENABLE_PARTIAL_COMMIT
        __reset_partial_execution();
#endif
        recall_persistent_state();
        commit_to_store();
        commit_flag = COMMIT_FINISH;
    }

    // Reset FRAM shadow buffer state.
    shadow_buf_pages_count = 0;

    // Initialize SRAM working buffer.
    initialize_sram_buffer();

    // Recall last coalesced task's address (and weight).
    recall_coalescing_state();

    // Restore checkpoint if available.
    if (checkpoint_available) {
        __restore();
    }

    // Run.
    while (1) {

        // When a coalesced task starts, no previous checkpoint is valid any longer.
        checkpoint_available = 0;

        // Reset current budget.
        current_budget = 0;

        // Coalesce tasks.
        while (current_budget < target_budget) {
            
            // Execute.
            PRF_SCHEDULER_END();
            PRF_TASK_BGN();
            ((task_pt) (real_task_addr))();
            PRF_TASK_END();
            PRF_SCHEDULER_BGN();
            
            // Update next task's address (and weight), current budget and history.
            static_task_epilogue();
        }

        // Save address (and weight) of the next task from which coalesce.
        save_volatile_state();

        PRF_COMMIT_BGN();

        // Commit to FRAM shadow buffer (phase 1).
        commit_to_shadow();

        // Commit to FRAM store buffer (phase 2).
        commit_flag = COMMITTING;

        // Log Coalesced Task Size
        msp_printf(target_budget);

        PRF_COMMIT_END();

#if ENABLE_PARTIAL_COMMIT
        __reset_partial_execution();
#endif
        recall_persistent_state();
        commit_to_store();
        commit_flag = COMMIT_FINISH;

        // Update target budget on a successful completion of a coalesced task.
        update_target_budget();
    }
}


void reboot_prologue()
{
    // Update target budget and history.
#if SLOW_ALG
    if (target_budget > 1) {
        target_budget--;
    }
#elif !NO_COALESCING
    target_budget = (history >> 1) + 1;
#else // NO_COALESCING
    // With no coalescing, target is always 1.
#endif

    // Save previous history.
#if VALLEY_ALG || VALLEY_TASK_AWARE_ALG
    previous_history = history;
#endif

    history = 0;
}


void recall_persistent_state()
{
    coalesced_task_addr = next_coalesced_task_addr;
#if FAST_TASK_AWARE_ALG || VALLEY_TASK_AWARE_ALG
    coalesced_task_time_wgt = next_coalesced_task_time_wgt;
#endif
}


void initialize_sram_buffer()
{
    uint16_t page_idx;
    uint16_t page_addr = BGN_RAM;
    for (page_idx = 0; page_idx < RAM_BUF_LEN; page_idx++) {
        ram_pages_buf[page_idx].ram_pg_tag = page_addr;
        page_addr += PAG_SIZE;
    }
}


void recall_coalescing_state()
{
    real_task_addr = coalesced_task_addr;
#if FAST_TASK_AWARE_ALG || VALLEY_TASK_AWARE_ALG
    real_task_time_wgt = coalesced_task_time_wgt;
#endif
}


void static_task_epilogue()
{
#if FAST_TASK_AWARE_ALG || VALLEY_TASK_AWARE_ALG
    uint16_t curr_task_time_wgt = real_task_time_wgt;
#endif

    // Virtual (volatile) progressing.
    real_task_addr = next_real_task_addr;
#if FAST_TASK_AWARE_ALG || VALLEY_TASK_AWARE_ALG
    real_task_time_wgt = next_real_task_time_wgt;
#endif

    // Update current budget and history.
#if NO_COALESCING || SLOW_ALG || FAST_ALG || VALLEY_ALG
    current_budget++;
    history++;
#else
    current_budget += curr_task_time_wgt;
    history += curr_task_time_wgt;
#endif
}


void save_volatile_state()
{
    next_coalesced_task_addr = real_task_addr;
#if FAST_TASK_AWARE_ALG || VALLEY_TASK_AWARE_ALG
    next_coalesced_task_time_wgt = real_task_time_wgt;
#endif
}


void commit_to_shadow()
{
    // Copy dirty pages to shadow buffer.
    uint16_t page_idx;
    for (page_idx = 0; page_idx < RAM_BUF_LEN && ram_pages_buf[page_idx].fram_pg_tag; page_idx++) {
        if (ram_pages_buf[page_idx].is_dirty) {
            __copy_page_to_shadow_buf(ram_pages_buf[page_idx].ram_pg_tag, ram_pages_buf[page_idx].fram_pg_tag);
            ram_pages_buf[page_idx].is_dirty = PAGE_CLEAN;
        }
    }
}


void commit_to_store()
{
    __commit_to_store_buf();
}


void update_target_budget()
{
    // Recompute target budget value.
#if SLOW_ALG
    target_budget++;
#elif FAST_ALG || FAST_TASK_AWARE_ALG
    target_budget = ((history >> 1) + 1);
#elif VALLEY_ALG || VALLEY_TASK_AWARE_ALG
    // if (decrease_target) {
    //     if (target_budget > 1) {
    //         target_budget = target_budget >> 1;
    //     } else {
    //         decrease_target = 0;
    //         target_budget = target_budget << 1;
    //     }
    // } else {
    //     if (target_budget < previous_history) {
    //         target_budget = target_budget << 1;
    //     } else {
    //         decrease_target = 1;
    //         target_budget = target_budget >> 1;
    //     }
    // }
    if (target_budget > MIN_TARGET) {
        target_budget = target_budget >> 1;
        if (target_budget < MIN_TARGET) {
            target_budget = MIN_TARGET;
        }
    }
#else // NO_COALESCING
    // With no coalescing, target is always 1.
#endif

    // Bound target budget.
    if (target_budget > MAX_TARGET_SIZE) {
        target_budget = MAX_TARGET_SIZE;
    }
}
