#include <msp430.h>
#include <mspDebugger.h>
#include <mspbase.h>

#ifndef __nv
#define __nv    __attribute__((section(".nv_vars")))
#endif

void uart_init_8mhz()
{

    P2SEL1 |= BIT0 | BIT1;                    // USCI_A0 UART operation
    P2SEL0 &= ~(BIT0 | BIT1);

    UCA0CTLW0 = UCSWRST;
    UCA0CTLW0 |= UCSSEL__SMCLK;   // this clock must be the same as the unified clock
    UCA0BR0 = 4;
    UCA0MCTLW = UCOS16| 0x5500;

    UCA0BR1 = 0;
    UCA0CTL1 &= ~UCSWRST;
}

void uart_init()
{

    P2SEL1 |= BIT0 | BIT1;                    // USCI_A0 UART operation
    P2SEL0 &= ~(BIT0 | BIT1);

    UCA0CTLW0 = UCSWRST;
    UCA0CTLW0 |= UCSSEL__SMCLK;   // this clock must be the same as the unified clock
    UCA0BR0 = 8;
    UCA0MCTLW |= 0xD600;

    UCA0BR1 = 0;
    UCA0CTL1 &= ~UCSWRST;
}

void uart_sendChar(uint8_t c)
{

       while(!(UCA0IFG&UCTXIFG));
       UCA0TXBUF = c;
}

void uart_sendText(uint8_t * c, const uint16_t len)
{
   uint16_t i;
   for(i=0; i < len; i++)
   {
       while(!(UCA0IFG&UCTXIFG));
       UCA0TXBUF = *c;
       c++;
   }

}

void uart_sendStr(uint8_t * c)
{
    /*
     * uart_sendStr assumes that the string is null terminated
     */

    while(*c){
       while(!(UCA0IFG&UCTXIFG));
       UCA0TXBUF = *c;
       __delay_cycles(10);
       c++;
   }


}

void uart_sendByte(uint8_t n)
{
    while(!(UCA0IFG&UCTXIFG));
    UCA0TXBUF = n & 0xff;
}

void uart_sendHex8(uint8_t n)
{

    uart_sendHex_digit( (n>>4) & 0xf );
    __delay_cycles(10);
    uart_sendHex_digit( n & 0xf );
    __delay_cycles(10);

}


void uart_sendHex16(uint16_t n)
{
    // Assuming little endian format
    uart_sendHex8( (n>>8) & 0xff);
    uart_sendHex8(n & 0xff);
}

void uart_sendHex32(uint32_t n)
{
    // Assuming little endian format
    uart_sendHex16( (n>>16) & 0xffff);
    uart_sendHex16(n & 0xffff);
}


void uart_sendHex_digit(uint8_t n)
{
    if( n < 10){
        while(!(UCA0IFG&UCTXIFG));
        UCA0TXBUF = (0x30+n);
    }else if( n == 10){
        while(!(UCA0IFG&UCTXIFG));
        UCA0TXBUF = 'A';
    }else if( n == 11){
        while(!(UCA0IFG&UCTXIFG));
        UCA0TXBUF = 'B';
    }else if( n == 12){
        while(!(UCA0IFG&UCTXIFG));
        UCA0TXBUF = 'C';
    }else if( n == 13){
        while(!(UCA0IFG&UCTXIFG));
        UCA0TXBUF = 'D';
    }else if( n == 14){
        while(!(UCA0IFG&UCTXIFG));
        UCA0TXBUF = 'E';
    }else if( n == 15){
        while(!(UCA0IFG&UCTXIFG));
        UCA0TXBUF = 'F';
    }else{
        while(!(UCA0IFG&UCTXIFG));
        UCA0TXBUF = n & 0xff;
    }
}

