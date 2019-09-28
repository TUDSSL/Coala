/******************************************************************************
 * File: dataprotect.c                                                        *
 *                                                                            *
 * Look at dataprotect.h for functions documentation.                         *
 *                                                                            *
 * Note: this is an internal set of functionalities used by Coala's kernel,   *
 *       do not modify or use externally.                                     *
 *                                                                            *
 * Authors: Amjad Majid, Carlo Delle Donne                                    *
 ******************************************************************************/

#include <msp430.h>

#include <ctlflags.h>
#include <dataprotect.h>

// This solution works if PAG_SIZE >= 32 (NUM_PRS_PAGS <= 256)

#define SB_COMMITTED 0x10
#define SB_LOCATION  0x01

#define FRAM_ADDR_TO_IDX(fram_addr, pag_size) ((fram_addr - BGN_PRS) >> __LOG2(pag_size))
#define FRAM_IDX_TO_ADDR(idx, pag_size) ((idx << __LOG2(pag_size)) + BGN_PRS)

#if PAG_SIZE == 16
#define __LOG2(pag_size) 4
#elif PAG_SIZE == 32
#define __LOG2(pag_size) 5
#elif PAG_SIZE == 64
#define __LOG2(pag_size) 6
#elif PAG_SIZE == 128
#define __LOG2(pag_size) 7
#elif PAG_SIZE == 256
#define __LOG2(pag_size) 8
#else
#error "Invalid page size!"
#endif

// For the following:
// 0: store buffer is the upper half memory
// 1: store buffer is the lower half memory
__nv uint8_t store_buf[NUM_PRS_PAGS] = {0};

// The following contains indexes of pages written to the shadow buffer
// (similar to __pages_in_shadow_buf)
__nv uint8_t shadow_buf_pages[NUM_PRS_PAGS];

 // Enable incremental commit
__nv uint16_t shadow_buf_pages_count = 0;
__nv uint16_t commit_page_idx = 0;

// RAM pages metadata.
ram_page_metadata_t ram_pages_buf[RAM_BUF_LEN];

uint16_t last_var_pg_tag = 0;
uint16_t last_ram_page_idx = 0;
uint16_t last_ram_pg_tag = 0;

volatile uint16_t swap_index = 0;

__nv uint16_t page_fault_counter = 0;
__nv uint16_t fullpage_fault_counter = 0;

/**
 * Copy page using DMA.
 *
 * @param src_page pointer to source page
 * @param dst_page pointer to destination page
 */
INLINE void __dma_copy_page(uint16_t src_page, uint16_t dst_page);


void __dma_init()
{
    // Block size (in words)
    DMA1SZ = PAG_SIZE_W;

    // Single block, increment addresses
    DMA1CTL = DMADT_1 | DMASRCINCR_3 | DMADSTINCR_3;
}


uint16_t __return_addr_no_check(uint16_t var_fram_addr)
{
    PRF_MEMORY_BGN();

    uint16_t ret;

    uint16_t ram_page_idx = 0;
    uint16_t fram_pg_tag;

    // Get (FRAM) page tag.
    uint16_t var_pg_tag = var_fram_addr & ~(PAG_SIZE - 1);

    // Quick return for repeated queries to the same page.
    // if (var_pg_tag == last_var_pg_tag) {
    //     ret = last_ram_pg_tag + (var_fram_addr & (PAG_SIZE - 1));
    //     PRF_MEMORY_END();
    //     return ret;
    // }

    last_var_pg_tag = var_pg_tag;

    // Search in (SRAM) working buffer.
    while ((fram_pg_tag = ram_pages_buf[ram_page_idx].fram_pg_tag)) {
        // Compare FRAM page tags.
        if (fram_pg_tag == var_pg_tag) {
            // If page found in SRAM, save page index and tag and return.
            last_ram_page_idx = ram_page_idx;
            last_ram_pg_tag = ram_pages_buf[ram_page_idx].ram_pg_tag;
            ret = last_ram_pg_tag + (var_fram_addr & (PAG_SIZE - 1));
            PRF_MEMORY_END();
            return ret;
        }
        ram_page_idx++;
        if (ram_page_idx == RAM_BUF_LEN) break;
    }

    // If page not found in SRAM, pull it from FRAM.
    __swap_page(var_fram_addr, &ram_pages_buf[swap_index]);

    // Save page index and tag.
    last_ram_page_idx = swap_index;
    last_ram_pg_tag = ram_pages_buf[swap_index].ram_pg_tag;

    // Increment swap index.
    swap_index++;
    if (swap_index >= RAM_BUF_LEN) {
        swap_index = 0;
    }

    // Return.
    ret = last_ram_pg_tag + (var_fram_addr & (PAG_SIZE - 1));
    PRF_MEMORY_END();
    return ret;
}


uint16_t __return_addr_wr_no_check(uint16_t var_fram_addr)
{
    PRF_MEMORY_BGN();

    uint16_t ret;

    uint16_t ram_page_idx = 0;
    uint16_t fram_pg_tag;

    // Get (FRAM) page tag.
    uint16_t var_pg_tag = var_fram_addr & ~(PAG_SIZE - 1);

    // Quick return for repeated queries to the same page.
    // if (var_pg_tag == last_var_pg_tag) {
    //     // Mark page as dirty.
    //     ram_pages_buf[last_ram_page_idx].is_dirty = PAGE_DIRTY;
    //     ret = last_ram_pg_tag + (var_fram_addr & (PAG_SIZE - 1));
    //     PRF_MEMORY_END();
    //     return ret;
    // }

    last_var_pg_tag = var_pg_tag;

    // Search in (SRAM) working buffer.
    while ((fram_pg_tag = ram_pages_buf[ram_page_idx].fram_pg_tag)) {
        // Compare FRAM page tags.
        if (fram_pg_tag == var_pg_tag) {
            // If page found in SRAM, mark page as dirty, save index and tag and return.
            ram_pages_buf[ram_page_idx].is_dirty = PAGE_DIRTY;
            last_ram_page_idx = ram_page_idx;
            last_ram_pg_tag = ram_pages_buf[ram_page_idx].ram_pg_tag;
            ret = last_ram_pg_tag + (var_fram_addr & (PAG_SIZE - 1));
            PRF_MEMORY_END();
            return ret;
        }
        ram_page_idx++;
        if (ram_page_idx == RAM_BUF_LEN) break;
    }

    // If page not found in SRAM, pull it from FRAM.
    __swap_page(var_fram_addr, &ram_pages_buf[swap_index]);
    
    // Mark page as dirty.
    ram_pages_buf[swap_index].is_dirty = PAGE_DIRTY;

    // Save page index and tag.
    last_ram_page_idx = swap_index;
    last_ram_pg_tag = ram_pages_buf[swap_index].ram_pg_tag;

    // Increment swap index.
    swap_index++;
    if (swap_index >= RAM_BUF_LEN) {
        swap_index = 0;
    }

    // Return.
    ret = last_ram_pg_tag + (var_fram_addr & (PAG_SIZE - 1));
    PRF_MEMORY_END();
    return ret;
}


void __dma_copy_page(uint16_t src_page, uint16_t dst_page)
{
    // Configure source and destination addresses.
#if defined(__clang__)
    DMA1SAL = src_page;
    DMA1DAL = dst_page;
#else
    __data16_write_addr((unsigned short) &DMA1SA, (unsigned long) (src_page)); // Source
    __data16_write_addr((unsigned short) &DMA1DA, (unsigned long) (dst_page)); // Destination
#endif

    // Enable and trigger the DMA.
    DMA1CTL |= DMAEN | DMAREQ;
}


void __copy_page_to_shadow_buf(uint16_t src_page, uint16_t dst_page)
{
    // Get destination page's FRAM index.
    uint16_t page_idx = FRAM_ADDR_TO_IDX(dst_page, PAG_SIZE);

    // Make dst_page point at the correct memory bank.
    if (!store_buf[page_idx]) {
        dst_page += APP_MEM_SIZE;
    }

    // Copy page using DMA.
    __dma_copy_page(src_page, dst_page);

    // Check if page was already in shadow buffer.
    uint16_t i = 0;
    while (i < shadow_buf_pages_count) {
        if (shadow_buf_pages[i] == page_idx) return;
        i++;
    }

    // Otherwise, keep track of the buffered page.
    shadow_buf_pages_count++;
    shadow_buf_pages[i] = page_idx;
}


void __swap_page(uint16_t var_fram_addr, ram_page_metadata_t* victim)
{
#ifdef PAG_FAULT_CNTR 
    page_fault_counter++;
    if (victim->is_dirty) {
        fullpage_fault_counter++;
        page_fault_counter--;
    }
#endif

    uint16_t page_pt;
    uint16_t page_idx;
    uint16_t i = 0;

    // Search swap-in page in (FRAM) shadow buffer.
    while (i < shadow_buf_pages_count) {
        // Compare FRAM page tags.
        page_idx = shadow_buf_pages[i];
        page_pt = FRAM_IDX_TO_ADDR(page_idx, PAG_SIZE);
        if (page_pt == (var_fram_addr & ~(PAG_SIZE - 1))) {
            // If swap-in page found in shadow buffer...
            // Copy dirty swap-out page to shadow buffer.
            if (victim->is_dirty) {
                __copy_page_to_shadow_buf(victim->ram_pg_tag, victim->fram_pg_tag);
                victim->is_dirty = PAGE_CLEAN;
            }
            // Pull swap-in page from shadow buffer.
            if (!store_buf[page_idx]) {
                __dma_copy_page(page_pt + APP_MEM_SIZE, victim->ram_pg_tag);
            } else {
                __dma_copy_page(page_pt, victim->ram_pg_tag);
            }
            // Stop searching.
            goto PAG_IN_TEMP;
        }
        i++;
    }

    // If swap-in page not found in shadow buffer, pull from store buffer.
    page_pt = var_fram_addr & ~(PAG_SIZE - 1);
    page_idx = FRAM_ADDR_TO_IDX(page_pt, PAG_SIZE);

    // Copy dirty swap-out page to shadow buffer.
    if (victim->is_dirty) {
        __copy_page_to_shadow_buf(victim->ram_pg_tag, victim->fram_pg_tag);
        victim->is_dirty = PAGE_CLEAN;
    }

    // Pull swap-in page from store buffer.
    if (!store_buf[page_idx]) {
        __dma_copy_page(page_pt, victim->ram_pg_tag);
    } else {
        __dma_copy_page(page_pt + APP_MEM_SIZE, victim->ram_pg_tag);
    }

PAG_IN_TEMP:

    // Update FRAM page tag in RAM metadata array.
    victim->fram_pg_tag = page_pt;
}


void __commit_to_store_buf()
{
    // Next page to be committed (resume from last page in case of power failure).
    uint16_t i = commit_page_idx;

    while (i < shadow_buf_pages_count) {
        // Commit page only if not already committed.
        if (!(store_buf[shadow_buf_pages[i]] & SB_COMMITTED)) {
            store_buf[shadow_buf_pages[i]] ^= (SB_COMMITTED | SB_LOCATION);
        }
        // Force the compiler to increment the commit index.
        __asm__ volatile ("ADD.W\t#1, &commit_page_idx\n");
        i++;
    }

    // Clear COMMITTED mark.
    while (i) {
        store_buf[shadow_buf_pages[i - 1]] &= ~SB_COMMITTED;
        i--;
    }

    // Clear non-volatile counters.
    shadow_buf_pages_count = 0;
    commit_page_idx = 0;
}
