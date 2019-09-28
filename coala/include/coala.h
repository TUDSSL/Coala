/******************************************************************************
 * File: coala.h                                                              *
 *                                                                            *
 * Description: Coala's main API. Available user functions (macros):          *
 *       WP              : write a protected variable                         *
 *       RP              : read a protected variable                          *
 *       COALA_PV        : define a new protected variable                    *
 *       COALA_SM        : align a struct member (more info above prototype)  *
 *       COALA_TASK      : define a new task                                  *
 *       coala_next_task : mark the next task to be executed                  *
 *       coala_init      : initialize Coala's internal state                  *
 *       coala_run       : run the application using Coala                    *
 *                                                                            *
 * Authors: Carlo Delle Donne, Amjad Majid                                    *
 ******************************************************************************/

#ifndef INCLUDE_COALA_H_
#define INCLUDE_COALA_H_

#include <stdint.h>

#include <global.h>
#include <dataprotect.h>

//Paging related debugging variables
extern uint16_t fullpage_fault_counter;
extern uint16_t page_fault_counter;


// Defined in scheduler.c
extern task_pt next_real_task_addr;
extern uint8_t next_real_task_time_wgt;

/**
 * Write a protected variable.
 */
#define WP(VAR) ( *__WP__(VAR) )

/**
 * Read a protected variable.
 */
#define RP(VAR) ( *__RP__(VAR) )

/**
 * Define a new protected variable.
 *
 * @param type protected variable's type
 * @param name protected variable's name
 *
 * @param size [optional] a third optional parameter defining the array size
 * 
 */
#define COALA_PV(type, name, ...) \
    __COALA_PV(type, name, ##__VA_ARGS__, 3, 2)

/**
 * Align a member inside a struct.
 * 
 * NOTE: must use for all struct types used for protected variables, to ensure
 *       the correct memory alignment.
 */
#define COALA_SM(type, name, ...) \
    __COALA_SM(type, name, ##__VA_ARGS__, 3, 2)

/**
 * Define a new task.
 *
 * @param name task's function name
 * @param tw   task's time weight
 */
#define COALA_TASK(name, tw) \
    __nv uint8_t __##name##_TW__ = tw; \
    void name();

/**
 * Mark the next task to be executed at the end of the current one.
 *
 * @param next_task next task's function name
 */
#define coala_next_task(next_task) \
    next_real_task_time_wgt = __translate_task_to_tw(next_task); \
    next_real_task_addr = next_task

/**
 * Initialize Coala's internal state.
 *
 * @param origin_task origin task's function name
 */
#define coala_init(origin_task) \
    __coala_init(origin_task, __translate_task_to_tw(origin_task))

/**
 * Run the application using Coala.
 */
#define coala_run() \
    __coala_run()

/**
 * Force commit to the FRAM at the end of a static task.
 *
 * Helper function used for debugging purposes
 */
#define coala_force_commit() \
    __coala_force_commit()

/**
 * Internal macros and functions.
 */

#define __COALA_PV(type, name, size, n, ...) \
    __COALA_PV##n(type, name, size)

#define __COALA_PV2(type, name, ...) \
    __p type name __attribute__ ((aligned __P2_ALIGNMENT((sizeof(type)))))

#define __COALA_PV3(type, name, size) \
    __p type name[size] __attribute__ ((aligned __P2_ALIGNMENT((sizeof(type)))))

#define __COALA_SM(type, name, size, n, ...) \
    __COALA_SM##n(type, name, size)

#define __COALA_SM2(type, name, ...) \
    type name __attribute__ ((aligned __P2_ALIGNMENT((sizeof(type)))));

#define __COALA_SM3(type, name, size) \
    type name[size] __attribute__ ((aligned __P2_ALIGNMENT((sizeof(type)))));

#define __P2_ALIGNMENT(n) \
    (n == 1 ? 1 : n == 2 ? 2 : n <= 4 ? 4 : 8)

#define __translate_task_to_tw(task) __ ## task ## _ ## TW ## __

void __coala_init(task_pt origin_task_pt, uint8_t origin_task_time_wgt);
void __coala_run();
void __coala_force_commit();


#endif /* INCLUDE_COALA_H_ */
