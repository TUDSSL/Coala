#ifndef INCLUDE_MSPPRINTF_H
#define INCLUDE_MSPPRINTF_H


#include <mspReseter.h>

int msp_printf(const char *format, ...);

void msp_uart_init();

void msp_uart_init_8mhz();

#define LOG(...) \
	msp_uart_init(); \
	msp_printf(__VA_ARGS__);

#define SAFE_LOG(...) \
	msp_reseter_halt(); \
	msp_uart_init(); \
	msp_printf(__VA_ARGS__); \
	msp_reseter_resume();


#endif /* INCLUDE_MSPPRINTF_H */
