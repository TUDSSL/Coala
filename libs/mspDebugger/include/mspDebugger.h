/*
 * UART debugger for MSP430
 *
 *  Created on: 18 Aug 2017
 *      Author: Amjad
 */

#ifndef INCLUDE_MSPDEBUGGER_H
#define INCLUDE_MSPDEBUGGER_H


#include <stdint.h>

void uart_sendByte(uint8_t n);
void uart_sendChar(uint8_t c);
void uart_sendStr(uint8_t * c);
void uart_sendText(uint8_t * c, const uint16_t len);
void uart_sendHex_digit(uint8_t n);
void uart_sendHex8(uint8_t n);
void uart_sendHex16(uint16_t n);
void uart_sendHex32(uint32_t n);
void uart_init();
void uart_init_8mhz();


#endif /* INCLUDE_MSPDEBUGGER_H */
