/******************************************************************************
 * File: coala.c                                                              *
 *                                                                            *
 * Look at coala.h for functions documentation.                               *
 *                                                                            *
 * Description: Coala's main API.                                             *
 *                                                                            *
 * Authors: Carlo Delle Donne, Amjad Majid                                    *
 ******************************************************************************/

#include <coala.h>
#include <scheduler.h>
#include <partialcommit.h>


__nv uint8_t init_done = 0;

// Defined in scheduler.c
extern uint16_t target_budget;
extern uint16_t current_budget;
extern task_pt coalesced_task_addr;
extern uint8_t coalesced_task_time_wgt;


void __coala_init(task_pt origin_task_pt, uint8_t origin_task_time_wgt)
{
#if ENABLE_PARTIAL_COMMIT
	__partial_execution_init();
#endif
	__dma_init();
    if (init_done != INIT_DONE) {
        coalesced_task_addr = origin_task_pt;
        coalesced_task_time_wgt = origin_task_time_wgt;
        init_done = INIT_DONE;
    }
}


void __coala_run()
{
	__scheduler();
}


void __coala_force_commit()
{
    current_budget = target_budget;
}
