/******************************************************************************
 * File: global.h                                                             *
 *                                                                            *
 * Description: global definitions.                                                          *
 *                                                                            *
 * Note: this is an internal set of functionalities used by Coala's kernel,   *
 *       do not modify or use externally.                                     *
 *                                                                            *
 * Authors: Amjad Majid, Carlo Delle Donne                                    *
 ******************************************************************************/

#ifndef INCLUDE_GLOBAL_H_
#define INCLUDE_GLOBAL_H_


#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

#include <mspbase.h>

/**
 * Prefixes for variables and function declaration.
 */
#define __nv    __attribute__((section(".nv_vars")))
#define __p     __attribute__((section(".p_vars")))
#define __ro_nv __attribute__((section(".ro_nv_vars")))
#define INLINE  __attribute__((always_inline)) inline
// #define __v     __attribute__((section(".ram_vars")))

/**
 * Pages.
 */
#define APP_MEM_SIZE    (8 * 0x0400) // Application memory: 8 KB
//#define PAG_SIZE        0x0100      // 256
//#define PAG_SIZE        0x0080      // 128
//#define PAG_SIZE        0x0040      // 64
#define PAG_SIZE          0x0020      // 32
#define NUM_PRS_PAGS    (APP_MEM_SIZE / PAG_SIZE)
#define PAG_SIZE_W      (PAG_SIZE / 2)

/**
 * FRAM partition.
 * ------------------------------------------------
 * |                                              | 0x4400
 * | Reserved for default sections:               |
 * | rodata, nv_vars, data, text                  |
 * |                                              | 0xB6FF
 * ------------------------------------------------
 * |                                     BGN_CP   | 0xB700
 * | Reserved for checkpoint:                     |
 * | 2 KB (2 times the max stack size)            |
 * |                                              | 0xBEFF
 * ------------------------------------------------
 * |                                     BGN_PRS  | 0xBF00
 * | Reserved for task-shared variables:          |
 * | 16 KB (2 times the app memory)               |
 * |                                              | 0xFEFF
 * ------------------------------------------------
 */
#define BGN_CP          0xB700
#define BGN_PRS         0xBF00

/**
 * RAM partition.
 * ------------------------------------------------
 * |                                     BGN_RAM  | 0x1C00
 * | Reserved for task-shared variables:          |
 * | 1 KB                                         |
 * |                                              | 0x1FFF
 * ------------------------------------------------
 * |                                              | 0x2000
 * | Reserved for default sections:               |
 * | data, bss, noinit, heap                      |
 * |                                              |
 * | /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ |
 * |                                              |
 * | The stack is placed at the bottom:           |
 * | 1 KB max size                                |
 * |                                              | 0x23FF
 * ------------------------------------------------
 */
#define BGN_RAM         0x1C00
#define RAM_SIZE        0x0800
#define END_STK         (BGN_RAM + RAM_SIZE)
#define RAM_BUF_SIZE    0x0400 // 1 KB
#define RAM_BUF_LEN     (RAM_BUF_SIZE / PAG_SIZE)

/**
 * Function pointer.
 */
typedef void (* task_pt)(void);

/**
 * RAM page meta-data.
 */
typedef struct ram_page_metadata_t {
    uint16_t ram_pg_tag;  // address of the page in RAM (fixed)
    uint8_t is_dirty;     // flag to mark a dirty page
    uint16_t fram_pg_tag; // address of a page in FRAM (dynamic)
} ram_page_metadata_t;

/**
 * Coala state codes.
 */
#define INIT_DONE     0xAD
#define COMMITTING    1
#define COMMIT_FINISH 0


#endif /* INCLUDE_GLOBAL_H_ */
