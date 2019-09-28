/*
######################################################O/
# The time measuring utility can time execution up to: 
# 4294 seconds (when the SMCLK is set to 1MHz)
# 268  seconds ( when the SMCLK is set ot 16MHz)
#####################################################
*/

#include <mspProfiler.h>

#define __nv  __attribute__((section(".nv_vars")))
__nv uint16_t overflow = 0;

void msp_profiler_start()
{
    // Initialise timer.
    TB0CTL = TBSSEL__SMCLK | MC__CONTINOUS | TBCLR | TBIE;
    // Enable general interrupts.
    __enable_interrupt();
}


uint32_t msp_profiler_stop()
{
    // Halt timer.
    TB0CTL ^= MC__CONTINOUS;

    // Disable general interrupts.
    __disable_interrupt();

    // Get result.
    uint32_t result = overflow;
    result <<= 16;
    result += TB0R - 10;

    // Reset timer.
    TB0CTL |= TBCLR;
    overflow = 0;

    return result;
}


void cp_init(){
	// uart_init();
	TB0CTL = TBSSEL__SMCLK | MC__CONTINOUS | TBCLR | TBIE;
    __enable_interrupt();
}

uint32_t cp_getRes() {
    /*
     *  cp_getRes() returns the value of timer_b and the number of
     *  timer overflow and then resets it.
     */
	uint16_t currnt_timer = TB0R;
	uint32_t ovrflw = __overflow;     // number of timer overflows
	ovrflw <<=16;                     // shift the overflow to the upper bytes
	ovrflw |= currnt_timer;          // get the current timer
	ovrflw-=10;

	__overflow = 0;                 // reset the overflow counter
	TB0CTL |= TBCLR;                // reset the timer
	return currnt_timer;
}


void  cp_sendRes(uint8_t * resId)
{
    /*
     * cp_sendRes() expects a null terminating string
     * it send the current
     */

    __disable_interrupt();

    // Halt timer_b
   unsigned int x =  TB0R;
   x -=15;

     uart_sendStr(resId);
     uart_sendHex16(__overflow);
     uart_sendHex16(x);
     uart_sendText((uint8_t*) "\n\r", 2);

    __overflow = 0;                 // reset the overflow counter
    __enable_interrupt();
    TB0CTL |=  TBCLR;                // reset the timer

}

unsigned int __overflow = 0;   // This must  be non-volatile



/**
 * Timer B0 interrupt service routine.
 */

#if defined(__clang__)
__attribute__((interrupt(26))) // dummy even number in [0, 28]
#elif defined(__GNUC__)
__attribute__((interrupt(TIMER0_B1_VECTOR))) 
#elif defined(__TI_COMPILER_VERSION__) || defined(__IAR_SYSTEMS_ICC__)
#pragma vector = TIMER0_B1_VECTOR
__interrupt
#else
#error Compiler not supported!
#endif
void TIMER0_B1_ISR (void)
{
    switch(__even_in_range(TB0IV, TB0IV_TBIFG)) {
    case TB0IV_NONE:   break; // No interrupt
    case TB0IV_TBCCR1: break; // CCR1 not used
    case TB0IV_TBCCR2: break; // CCR2 not used
    case TB0IV_TBCCR3: break; // CCR3 not used
    case TB0IV_TBCCR4: break; // CCR4 not used
    case TB0IV_TBCCR5: break; // CCR5 not used
    case TB0IV_TBCCR6: break; // CCR6 not used
    case TB0IV_TBIFG:         // overflow
        // __overflow++;
        overflow++;
        break;
    default: break;
    }
}

#if defined(__clang__)
__attribute__ ((section("__interrupt_vector_timer0_b1"),aligned(2)))
void (*__vector_timer0_b1)(void) = TIMER0_B1_ISR;
#endif
