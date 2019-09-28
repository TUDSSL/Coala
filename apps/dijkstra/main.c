#include <msp430.h>
#include <stdint.h>
#include <stdio.h>

#include <mspReseter.h>
#include <mspProfiler.h>
#include <mspDebugger.h>
#include <mspbase.h>
#include <mspprintf.h>

#include <coala.h>

// Only for profiling, removable otherwise
#include <ctlflags.h>

// Profiling flags.
#if ENABLE_PRF
__nv uint8_t full_run_started = 0;
__nv uint8_t first_run = 1;
#endif

#ifndef RST_TIME
#define RST_TIME 25000
#endif


#define N_NODES   25
#define Q_SIZE    4 * N_NODES

#define INFINITY  0xFFFF
#define UNDEFINED 0xFFFF

typedef struct {
	COALA_SM(uint16_t, dist);
	COALA_SM(uint16_t, prev);
} node_t;

typedef struct {
	COALA_SM(uint16_t, node);
	COALA_SM(uint16_t, dist);
	COALA_SM(uint16_t, prev);
} queue_t;

#include "data.h"

// Tasks.
COALA_TASK(task_init, 3)
COALA_TASK(task_init_list, 16)
COALA_TASK(task_select_nearest_node, 5)
COALA_TASK(task_find_shorter_path, 3)
COALA_TASK(task_done, 1)

// Task-shared protected variables.
COALA_PV(queue_t, queue, Q_SIZE); // largest size?
COALA_PV(uint16_t, deq_idx);
COALA_PV(uint16_t, enq_idx);
COALA_PV(uint16_t, node_idx);
COALA_PV(uint16_t, src_node);
COALA_PV(queue_t, nearest_node);
COALA_PV(node_t, node_list, N_NODES);


void task_init()
{
#if ENABLE_PRF
    full_run_started = 1;
#endif
	
    WP(deq_idx) = 0;
    WP(enq_idx) = 0;

    // Enqueue.
	WP(queue[0].node) = RP(src_node);
	WP(queue[0].dist) = 0;
	WP(queue[0].prev) = UNDEFINED;
	++WP(enq_idx);
	// LOG("E: %u, D: %u\n", RP(enq_idx), RP(deq_idx));

	coala_next_task(task_init_list);
}


void task_init_list()
{
    uint16_t i, sn;

    for (i = 0; i < N_NODES; i++) {
    	WP(node_list[i].dist) = INFINITY;
    	WP(node_list[i].prev) = UNDEFINED;
    }

    sn = RP(src_node);
    WP(node_list[sn].dist) = 0;
    WP(node_list[sn].prev) = UNDEFINED;

    sn++;
    // Test nodes 0, 1, 2, 3.
    if (sn < 4) {
    	WP(src_node) = sn;
    } else {
    	WP(src_node) = 0;
    }

    coala_next_task(task_select_nearest_node);
}


void task_select_nearest_node()
{
	uint16_t i = RP(deq_idx);

	if (RP(enq_idx) != i) {
		
		// Dequeue nearest node.
		WP(nearest_node.node) = RP(queue[i].node);
		WP(nearest_node.dist) = RP(queue[i].dist);
		WP(nearest_node.prev) = RP(queue[i].prev);
		i++;
		if (i < Q_SIZE) {
			WP(deq_idx) = i;
		} else {
			WP(deq_idx) = 0;
		}
		// LOG("E: %u, D: %u\n", RP(enq_idx), RP(deq_idx));

		WP(node_idx) = 0;
		coala_next_task(task_find_shorter_path);
	} else {
		coala_next_task(task_done);
	}
}


void task_find_shorter_path()
{
	uint16_t cost, node, dist, nearest_dist, i;

	node = RP(nearest_node.node);
	i = RP(node_idx);
	cost = adj_matrix[node][i];

	if (cost != INFINITY) {
		nearest_dist = RP(nearest_node.dist);
		dist = RP(node_list[i].dist);
		if (dist == INFINITY || dist > (cost + nearest_dist)) {
			WP(node_list[i].dist) = nearest_dist + cost;
			WP(node_list[i].prev) = node;

			// Enqueue.
			uint16_t j = RP(enq_idx);
			if (j == (RP(deq_idx) - 1)) {
				LOG("QUEUE IS FULL!");
			}
		    WP(queue[j].node) = i;
		    WP(queue[j].dist) = nearest_dist + cost;
		    WP(queue[j].prev) = node;
			j++;
			if (j < Q_SIZE) {
				WP(enq_idx) = j;
			} else {
				WP(enq_idx) = 0;
			}
		    // LOG("E: %u, D: %u\n", RP(enq_idx), RP(deq_idx));
		}
	}

	if (++WP(node_idx) < N_NODES) {
		coala_next_task(task_find_shorter_path);
	} else {
		coala_next_task(task_select_nearest_node);
	}
}


void task_done()
{
    __no_operation();

#if ENABLE_PRF
    if (full_run_started) {
#if AUTO_RST
        msp_reseter_halt();
#endif
		// Print shortest path from src_node to dst_node
		// (print backwards to avoid recursion).
        // uint16_t dst_node = 5;
        // LOG("(%u)", dst_node);
        // uint16_t p = RP(node_list[dst_node].prev);
        // while (p != UNDEFINED) {
        // 	LOG(" <- (%u)", p);
        // 	__delay_cycles(1000);
        // 	p = RP(node_list[p].prev);
        // }
        // LOG("\n");

        PRF_APP_END();
        full_run_started = 0;
#if AUTO_RST
        msp_reseter_resume();
#endif
    }
#endif

    coala_next_task(task_init);
}


void init()
{
    msp_watchdog_disable();
    msp_gpio_unlock();

#if ENABLE_PRF
    PRF_INIT();
    PRF_POWER();
#endif

    // msp_clock_set_mclk(CLK_8_MHZ);

#if TSK_SIZ
    uart_init();
    cp_init();
#endif

#if LOG_INFO
    uart_init();
#endif

#if AUTO_RST
    msp_reseter_auto_rand(RST_TIME);
#endif

#if ENABLE_PRF
    if (first_run) {
        PRF_APP_BGN();
        first_run = 0;
    }
#endif
}


int main(void)
{
    init();

    coala_init(task_init);

    coala_run();

    return 0;
}

