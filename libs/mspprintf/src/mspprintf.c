#include <msp430.h>


void msp_uart_init_8mhz()
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


void msp_uart_init()
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


// Tiny printf implementation by oPossum from here:
// http://forum.43oh.com/topic/1289-tiny-printf-c-version/#entry10652

#include <stdlib.h>
#include <stdint.h>
#include <stdarg.h>

#include <mspprintf.h>

#define PUTC(c) msp_io_putchar(c)


static int msp_io_putchar(int c)
{
    uint8_t ch = c;
    while (!(UCA0IFG & UCTXIFG));
    UCA0TXBUF = ch;
    return c;
}


static int msp_io_puts_no_newline(const char *ptr)
{
    unsigned len = 0;
    const char *p = ptr;

    while (*p++ != '\0')
        len++;

    while (len--) {
        while (!(UCA0IFG & UCTXIFG));
        UCA0TXBUF = (uint8_t) *ptr;
        ptr++;
    }
    return len;
}


static int msp_io_puts(const char *ptr)
{
    unsigned len;

    len = msp_io_puts_no_newline(ptr);

    msp_io_putchar('\n');

    return len;
}


static const unsigned long dv[] = {
//  4294967296      // 32 bit unsigned max
    1000000000,     // +0
     100000000,     // +1
      10000000,     // +2
       1000000,     // +3
        100000,     // +4
//       65535      // 16 bit unsigned max     
         10000,     // +5
          1000,     // +6
           100,     // +7
            10,     // +8
             1,     // +9
};


static void msp_xtoa(unsigned long x, const unsigned long *dp)
{
    char c;
    unsigned long d;
    if (x) {
        while (x < *dp) ++dp;
        do {
            d = *dp++;
            c = '0';
            while(x >= d) ++c, x -= d;
            PUTC(c);
        } while (!(d & 1));
    } else {
        PUTC('0');
    }
}


static void msp_puth(unsigned n)
{
    static const char hex[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
    char c = hex[n & 15];
    PUTC(hex[n & 15]);
}


static int msp_puts(const char *str){
    while (*str != 0){
        PUTC(*str++);
    }
    return 0;
}


int msp_printf(const char *format, ...)
{
    char c;
    int i;
    long n;
    int fill_zeros;
    unsigned d;

    va_list a;
    va_start(a, format);
    while((c = *format++)) {
        if(c == '%') {
            fill_zeros = 0;
parse_fmt_char:
            switch(c = *format++) {
                case 's':                       // String
                    msp_io_puts_no_newline(va_arg(a, char*));
                    break;
                case 'c':                       // Char
                    PUTC(va_arg(a, int)); // TODO: 'char' generated a warning
                    break;
                case 'i':                       // 16 bit Integer
                case 'u':                       // 16 bit Unsigned
                    i = va_arg(a, int);
                    if(c == 'i' && i < 0) i = -i, PUTC('-');
                    msp_xtoa((unsigned)i, dv + 5);
                    break;
                case 'l':                       // 32 bit Long
                case 'n':                       // 32 bit uNsigned loNg
                    n = va_arg(a, long);
                    if(c == 'l' &&  n < 0) n = -n, PUTC('-');
                    msp_xtoa((unsigned long)n, dv);
                    break;
                case 'x':                       // 16 bit heXadecimal
                    i = va_arg(a, int);
                    d = i >> 12;
                    if (d > 0 || fill_zeros >= 4)
                        msp_puth(d);
                    d = i >> 8;
                    if (d > 0 || fill_zeros >= 3)
                        msp_puth(d);
                    d = i >> 4;
                    if (d > 0 || fill_zeros >= 2)
                        msp_puth(d);
                    msp_puth(i);
                    break;
                case '0':
                    c = *format++;
                    fill_zeros = c - '0';
                    goto parse_fmt_char;
                case 0: return 0;
                default: goto bad_fmt;
            }
        } else
bad_fmt:    PUTC(c);
    }
    va_end(a);
    return 0; // TODO: return number of chars printed
}


