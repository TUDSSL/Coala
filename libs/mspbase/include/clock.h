#ifndef INCLUDE_MSPBASE_CLOCK_H
#define INCLUDE_MSPBASE_CLOCK_H


#define CLK_1_MHZ DCOFSEL_0
#define CLK_4_MHZ DCOFSEL_3
#define CLK_8_MHZ DCOFSEL_6

#define msp_clock_set_mclk(freq, div) \
    CSCTL0  = CSKEY; \
    CSCTL1  = freq; \
    CSCTL2 &= ~(SELM0|SELM1|SELM2); \
    CSCTL2 |= SELM__DCOCLK; \
    CSCTL3 &= ~(DIVM0|DIVM1|DIVM2); \
    CSCTL3 |= DIVM__1; \
    CSCTL0  = 0


#endif /* INCLUDE_MSPBASE_CLOCK_H */
