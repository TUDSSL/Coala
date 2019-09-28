/*
 * Reset generator for MSP430
 *
 *  Created on: 18 Aug 2017
 *      Author: Amjad
 */

#ifndef INCLUDE_MSPRESETER_H
#define INCLUDE_MSPRESETER_H


#include <msp430.h>

// extern unsigned __reset;

void msp_reseter_reset();
void msp_reseter_confirm();

/**
 * Reset the MCU after a specified interval.
 *
 * Uses Timer0_A0 ISR.
 *
 * @param interval reset interval, in SMCLK clock cycles
 */
void msp_reseter_auto(unsigned int interval);

/**
 * Reset the MCU after an interval based on the argument and on a random
 * power pattern.
 *
 * Uses Timer0_A0 ISR.
 *
 * @param interval base reset interval, in SMCLK clock cycles
 */
void msp_reseter_auto_rand(unsigned int interval);

/**
 * Calculate reset interval in clock cycles.
 *
 * @param clock_freq        operating clock frequency [MHz]
 * @param hit_to_miss_ratio cache hit-to-miss ratio [%]
 * @param capacitance       capacitance value [µF]
 *
 * Valid values for clock_freq are: 1, 4, 8, 16.
 *
 * Valid values for hit_to_miss_ratio are: 0, 50, 66, 75, 100.
 */
unsigned int calculate_interval(unsigned int clock_freq, unsigned int hit_to_miss_ratio, unsigned int capacitance);

/**
 * Halt the reseter timer to disable the reset functionality
 */
#define msp_reseter_halt() TA0CTL &= ~MC__UP

/**
 * Resume the reseter timer to re-enable the reset functionality
 */
#define msp_reseter_resume() TA0CTL |= MC__UP


#endif /* INCLUDE_MSPRESETER_H */
