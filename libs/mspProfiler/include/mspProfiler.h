/*
 * Code profiler for MSP430
 *
 *  Created on: 18 Aug 2017
 *      Author: Amjad
 */

#ifndef INCLUDE_MSPPROFILER_H
#define INCLUDE_MSPPROFILER_H


#include <msp430.h>
#include <mspDebugger.h>
#include <stdint.h>

/**
 * Start the timer for profiling.
 */
void msp_profiler_start();

/**
 * Stop the timer and get profiling result.
 */
uint32_t msp_profiler_stop();

#define  cp_reset()  TB0CTL |= TBCLR

void cp_init();
uint32_t cp_getRes();
void cp_sendRes(uint8_t * resId);

extern unsigned int __overflow;   // This must  be non-volatile


#endif /* INCLUDE_MSPPROFILER_H */
