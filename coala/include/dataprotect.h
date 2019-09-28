/******************************************************************************
 * File: dataprotect.h                                                        *
 *                                                                            *
 * Description: TODO                                                          *
 *                                                                            *
 * Note: this is an internal set of functionalities used by Coala's kernel,   *
 *       do not modify or use externally.                                     *
 *                                                                            *
 * Authors: Amjad Majid, Carlo Delle Donne                                    *
 ******************************************************************************/

#ifndef INCLUDE_DATAPROTECT_H_
#define INCLUDE_DATAPROTECT_H_


#include <stdint.h>

#include <global.h>

#define PAGE_DIRTY 1
#define PAGE_CLEAN 0

/**
 * Initialize DMA channel 1 for memory operations.
 */
void __dma_init();

/**
 * Return the RAM address of a variable to be read.
 *
 * This function is responsible of handling paging and page faults.
 *
 * @param var_fram_addr FRAM address of the variable to be read
 *
 * @return RAM address of the variable
 */
uint16_t __return_addr_no_check(uint16_t var_fram_addr);

/**
 * Return the RAM address of a variable to be written.
 *
 * This function is responsible of handling paging and page faults.
 *
 * @param var_fram_addr FRAM address of the variable to be written
 *
 * @return RAM address of the variable
 */
uint16_t __return_addr_wr_no_check(uint16_t var_fram_addr);

/**
 * Copy page to shadow buffer (FRAM) using DMA.
 *
 * @param src_page pointer to source page
 * @param dst_page pointer to destination page
 */
void __copy_page_to_shadow_buf(uint16_t src_page, uint16_t dst_page);

/**
 * Swap one page from working buffer (SRAM) to shadow buffer (FRAM) to make
 * room for another page to be copied into working buffer.
 *
 * @param var_fram_addr address in FRAM of the variable whose page has to be
 *                      imported in SRAM
 * @param victim        pointer to SRAM victim page's metadata structure
 */
void __swap_page(uint16_t var_fram_addr, ram_page_metadata_t* victim);

/**
 * Commit dirty pages from shadow buffer (FRAM) to store buffer (FRAM).
 *
 * This represents the second phase of the commit process, and, after a power
 * failure, can be resumed from the last page being committed.
 */
void __commit_to_store_buf();

/**
 * Read and write variables.
 */

// #define __RP__(var) ( (__typeof__(var)*) __return_addr_no_check((uint16_t) &var) )
// #define __WP__(var) ( (__typeof__(var)*) __return_addr_wr_no_check((uint16_t) &var) )

// Defined in dataprotect.c
extern uint16_t last_var_pg_tag;
extern uint16_t last_ram_pg_tag;
extern uint16_t last_ram_page_idx;
extern ram_page_metadata_t ram_pages_buf[];

/**
 * Get SRAM pointer for reading a protected variable.
 *
 * @param var protected variable to be read
 * 
 * @return SRAM pointer to var
 *
 * This macro allows quick pointer retrieval in case of successive accesses
 * to the same page. In case of access to a different page, the function
 * __return_addr_no_check is invoked.
 *
 * Explanation:
 *
 * - get FRAM page tag of the variable to be read
 * - compare the tag with the tag of the last accessed page
 *   - if they match, return (SPT) + (VPO), where
 *     (SPT) SRAM Page Tag of the last accessed page
 *     (VPO) Variable Page Offset in page
 *   - otherwise, call __return_addr_no_check
 */
#define __RP__(var) ( \
	(__typeof__(var)*) ( \
		((((uint16_t) &var) & ~(PAG_SIZE - 1)) == last_var_pg_tag) ? ( \
			last_ram_pg_tag + (((uint16_t) &var) & (PAG_SIZE - 1)) \
		) : __return_addr_no_check((uint16_t) &var) \
	) \
)

/**
 * Get SRAM pointer for writing a protected variable.
 *
 * @param var protected variable to be written
 * 
 * @return SRAM pointer to var
 *
 * This macro allows quick pointer retrieval in case of successive accesses
 * to the same page. In case of access to a different page, the function
 * __return_addr_wr_no_check is invoked.
 *
 * Explanation:
 *
 * - get FRAM page tag of the variable to be written
 * - compare the tag with the tag of the last accessed page
 *   - if they match, mark the SRAM page as DIRTY,
 *     then return (SPT) + (VPO), where
 *     (SPT) SRAM Page Tag of the last accessed page
 *     (VPO) Variable Page Offset in page
 *   - otherwise, call __return_addr_wr_no_check
 */
#define __WP__(var) ( \
	(__typeof__(var)*) ( \
		((((uint16_t) &var) & ~(PAG_SIZE - 1)) == last_var_pg_tag) ? ( \
			(ram_pages_buf[last_ram_page_idx].is_dirty = PAGE_DIRTY) ? ( \
				last_ram_pg_tag + (((uint16_t) &var) & (PAG_SIZE - 1)) \
			) : 0 \
		) : __return_addr_wr_no_check((uint16_t) &var) \
	) \
)


#endif /* INCLUDE_DATAPROTECT_H_ */
