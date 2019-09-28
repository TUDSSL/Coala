/******************************************************************************
 * File: scheduler.h                                                          *
 *                                                                            *
 * Description: TODO                                                          *
 *                                                                            *
 * Note: this is an internal set of functionalities used by Coala's kernel,   *
 *       do not modify or use externally.                                     *
 *                                                                            *
 * Authors: Amjad Majid, Carlo Delle Donne                                    *
 ******************************************************************************/

#ifndef INCLUDE_SCHEDULER_H_
#define INCLUDE_SCHEDULER_H_


/**
 * Infinite loop responsible for running the application according to the
 * selected coalescing algorithm.
 */
void __scheduler();


#endif /* INCLUDE_SCHEDULER_H_ */
