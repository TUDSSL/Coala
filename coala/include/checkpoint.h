/*
 *   Created on: 11 Jan 2018
 *       Author: Martijn van der Marel, Amjad Yousef Majid
 * Contributors: Carlo Delle Donne
 */

#ifndef INCLUDE_DMACP_H_
#define INCLUDE_DMACP_H_


#include <msp430.h>
#include <stdint.h>

#include <global.h>

// TODO: checkpoint region in memory is unprotected, thus it could overwrite,
//       or be overwritten by, other regions. It could be placed after PRS.

#define MAX_STK_SIZE 0x0400 // max 1 KB for stack, since the remainder of SRAM is for pages
#define BGN_CP       (BGN_PRS - 2 * MAX_STK_SIZE)
#define CP_BUF_A     BGN_CP
#define CP_BUF_B     CP_BUF_A + MAX_STK_SIZE

extern uint16_t __last_cp_buf;
extern uint16_t __stack_ptr;
extern uint8_t  __restoring;


/**
 * Move data with DMA using channel 1.
 *
 * @param src source address
 * @param dst destination address
 * @param len block length, in bytes
 */
#define __dma_move(src, dst, len) { \
	__data16_write_addr((unsigned short) &DMA0SA, (unsigned long) src); \
	__data16_write_addr((unsigned short) &DMA0DA, (unsigned long) dst); \
	DMA0SZ = len >> 1; \
	DMA0CTL = DMADT_1 | DMASRCINCR_3 | DMADSTINCR_3; \
	DMA0CTL |= DMAEN | DMAREQ; \
}


/**
 * Pop MCU registers from stack.
 *
 * Steps:
 * -> recall SP from persistent storage (__stack_ptr)
 * -> at this point, SP = x - 28
 * -> pop R15 to R4 (SP = x - 4)
 * -> pop SR (SP = x - 2)
 * -> set __restoring flag
 * -> pop PC (SP = x, as before checkpointing)
 * -> next instruction will be "NOP" in __registers_to_stack()
 */
#define __stack_to_registers() { \
	asm volatile ("MOV %0, R1" ::"m"(__stack_ptr)); \
	asm volatile ("POP R15"); \
	asm volatile ("POP R14"); \
	asm volatile ("POP R13"); \
	asm volatile ("POP R12"); \
	asm volatile ("POP R11"); \
	asm volatile ("POP R10"); \
	asm volatile ("POP R9"); \
	asm volatile ("POP R8"); \
	asm volatile ("POP R7"); \
	asm volatile ("POP R6"); \
	asm volatile ("POP R5"); \
	asm volatile ("POP R4"); \
	asm volatile ("POP R2"); \
	asm volatile ("MOV #0x01, &__restoring"); \
	asm volatile ("POP R0"); \
}


/**
 * Push MCU registers onto stack for checkpointing.
 *
 * Steps:
 * -> at the beginning, SP = x
 * -> push PC (SP = x - 2)
 * -> land on NOP when called after a __restore()
 * -> if function was called after a __restore()
 *    -> return
 * -> else
 *    -> push SR (SP = x - 4)
 *    -> push R4 to R15 (SP = x - 28)
 *    -> persistently save SP (= x - 28) to __stack_ptr
 *    -> restore SP to initial value (SP = x)
 */
#define __registers_to_stack() { \
	asm volatile ("PUSH R0"); \
	asm ("NOP"); \
	if (__restoring != 1) { \
		asm volatile ("PUSH R2"); \
		asm volatile ("PUSH R4"); \
		asm volatile ("PUSH R5"); \
		asm volatile ("PUSH R6"); \
		asm volatile ("PUSH R7"); \
		asm volatile ("PUSH R8"); \
		asm volatile ("PUSH R9"); \
		asm volatile ("PUSH R10"); \
		asm volatile ("PUSH R11"); \
		asm volatile ("PUSH R12"); \
		asm volatile ("PUSH R13"); \
		asm volatile ("PUSH R14"); \
		asm volatile ("PUSH R15"); \
		asm volatile ("MOV R1, %0 " : "=m"(__stack_ptr)); \
		asm volatile ("ADD #0x1C, R1"); \
	} \
}


/**
 * Get opposite checkpoint buffer.
 */
#define __opposite_cp_buf(loc) (((loc) == (CP_BUF_B)) ? (CP_BUF_A) : (CP_BUF_B))


/**
 * Checkpoint volatile state.
 *
 * Steps:
 * -> push registers onto stack
 * -> if function was called after a __restore()
 *    -> clear __restoring flag and return
 * -> else
 *    -> copy stack (with registers) to non-volatile memory
 *    -> toggle __last_cp_buf
 */
#define __checkpoint() { \
	__registers_to_stack(); \
	if (__restoring != 1) { \
		uint16_t src, dst, len; \
		src = (__stack_ptr - 2); \
		dst = __opposite_cp_buf(__last_cp_buf); \
		len = (0x2402 - __stack_ptr); \
		__dma_move(src, dst, len) \
		__last_cp_buf = dst; \
	} else { \
		__restoring = 0; \
	} \
}


/**
 * Restore checkpointed volatile state.
 *
 * Steps:
 * -> copy stack (with registers) from non-volatile memory
 * -> pop registers from stack
 */
#define __restore() { \
	uint16_t dst, len; \
	dst = (__stack_ptr - 2); \
	len = (0x2402 - __stack_ptr); \
	__dma_move(__last_cp_buf, dst, len); \
	__stack_to_registers(); \
}


#endif /* INCLUDE_DMACP_H_ */
