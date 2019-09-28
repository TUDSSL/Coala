/******************************************************************************
 * File: partialcommit.c                                                      *
 *                                                                            *
 * Look at partialcommit.h for functions documentation.                       *
 *                                                                            *
 * Note: this is an internal set of functionalities used by Coala's kernel,   *
 *       do not modify or use externally.                                     *
 *                                                                            *
 * Authors: Carlo Delle Donne, Amjad Yousef Majid                             *
 ******************************************************************************/

#include <partialcommit.h>
#include <dataprotect.h>


// Timer's capture-compare register value for scheduling partial execution commit.
__nv uint16_t pe_ccr = 4000;

// Last successful CCR value.
__nv uint16_t succ_pe_ccr = 0;

// Checkpoint-related variables.
__nv uint16_t last_cp_buf;
__nv uint16_t stack_ptr;
__nv uint8_t  restoring;
__nv uint8_t  checkpoint_available = 0;

// Partial-commit-related variables.
__nv uint8_t death_count = 0;

// Defined in scheduler.c
extern uint16_t target_budget;
extern uint8_t commit_flag;

// Defined in dataprotect.c
extern ram_page_metadata_t ram_pages_buf[];


/**
 * Schedule partial execution commit by using a timer interrupt.
 */
void __schedule_partial_execution_commit()
{
    // Enable timer interrupt.
    TB0CCTL0 = CCIE;

    // Set CCR.
    TB0CCR0 = pe_ccr;

    // Total timer divider = 2 * 8 = 16.
    // Every timer tick represents 16 clock cycles.

    // Input divider expansion = 2.
    TB0EX0 = TBIDEX__2;

    // SMCLK, continuous mode, input divider = 8.
    TB0CTL = TBSSEL__SMCLK | MC__UP | ID__8 | TBCLR;

    // Enable general interrupt.
    __bis_SR_register(GIE);
    __no_operation();
}


void __reset_partial_execution()
{
	// Clear death count.
	death_count = 0;

	// Halt and clear the timer.
	TB0CTL &= ~MC__UP;
	TB0CTL |= TBCLR;
}


void __partial_execution_init()
{
	// Initialize checkpoint.
    if (!checkpoint_available) {
        last_cp_buf = CP_BUF_B; // First copy to FRAM will be to CP_BUF_A
        restoring = 0;          // Not just restored
    }

    // Initialize partial execution.
    if (death_count < 2) {
    	if (target_budget == 1) {
    		death_count++;
    	}
    } else {
        if (death_count == 2) {
            death_count++;
        } else {
            if (succ_pe_ccr) {
                pe_ccr = succ_pe_ccr;
                succ_pe_ccr = 0;
            } else {
                pe_ccr = pe_ccr >> 1;
            }
        }
    	__schedule_partial_execution_commit();
    }
}


void __commit_partial_execution()
{
    uint16_t page_idx;

    // Copy dirty pages to shadow buffer.
    for (page_idx = 0; page_idx < RAM_BUF_LEN && ram_pages_buf[page_idx].fram_pg_tag; page_idx++) {
        if (ram_pages_buf[page_idx].is_dirty) {
            __copy_page_to_shadow_buf(ram_pages_buf[page_idx].ram_pg_tag, ram_pages_buf[page_idx].fram_pg_tag);
            ram_pages_buf[page_idx].is_dirty = PAGE_CLEAN;
        }
    }

    // Checkpoint volatile state.
    __checkpoint();
    checkpoint_available = 1;

    // Copy dirty pages from shadow buffer to store buffer.
    commit_flag = COMMITTING;
    __commit_to_store_buf();
    commit_flag = COMMIT_FINISH;
}


/**
 * Timer B0 interrupt service routine.
 */
#if defined(__clang__)
__attribute__((interrupt(22))) // dummy even number in [0, 28]
#elif defined(__GNUC__)
__attribute__((interrupt(TIMER0_B0_VECTOR))) 
#elif defined(__TI_COMPILER_VERSION__) || defined(__IAR_SYSTEMS_ICC__)
#pragma vector = TIMER0_B0_VECTOR
__interrupt
#else
#error Compiler not supported!
#endif
void Timer0_B0_ISR (void)
{
    // Restore general interrupt state.
    // TODO

    // Execute partial execution commit.
    __commit_partial_execution();

    // Clear death count.
    death_count = 0;

    // Increment the capture-compare register value on a successful partial execution commit.
    uint16_t increment = pe_ccr >> 1;
    if (increment > 0xffff - pe_ccr) {
    	pe_ccr = 0xffff;
    } else {
    	pe_ccr += increment;
    }

    // Save successful CCR.
    succ_pe_ccr = pe_ccr;
}

#if defined(__clang__)
__attribute__ ((section("__interrupt_vector_timer0_b0"),aligned(2)))
void (*__vector_timer0_b0)(void) = Timer0_B0_ISR;
#endif
