#ifndef INCLUDE_MSPBASE_H
#define INCLUDE_MSPBASE_H


#include <msp430.h>
#include <clock.h>
#include <gpio.h>
#include <watchdog.h>
#include <builtins.h>

/**
 * Send the MCU into an infinite loop.
 *
 * To escape, manually modify the program counter as follows:
 * PC <- PC + 2
 */
#define msp_black_hole() __asm__ volatile ("DECD.W\tPC\n")


#endif /* INCLUDE_MSPBASE_H */
