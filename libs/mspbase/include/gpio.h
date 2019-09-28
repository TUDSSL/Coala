#ifndef INCLUDE_MSPBASE_GPIO_H
#define INCLUDE_MSPBASE_GPIO_H


/**
 * Internal macros
 */
#define __gpio_dir_in(port, pin)  P ## port ## DIR &= ~BIT ## pin
#define __gpio_dir_out(port, pin) P ## port ## DIR |= BIT ## pin
#define __gpio_set(port, pin)     P ## port ## OUT |= BIT ## pin
#define __gpio_clear(port, pin)   P ## port ## OUT &= ~BIT ## pin
#define __gpio_toggle(port, pin)  P ## port ## OUT ^= BIT ## pin

/**
 * Disable the GPIO power-on default high-impedance mode to activate
 * previously configured port settings.
 */
#define msp_gpio_unlock() \
	PM5CTL0 &= ~LOCKLPM5

/**
 * Set GPIO pin as input.
 *
 * @param port port number
 * @param pin  pin number
 */
#define msp_gpio_dir_in(port, pin) \
	__gpio_dir_in(port, pin)

/**
 * Set GPIO pin as output.
 *
 * @param port port number
 * @param pin  pin number
 */
#define msp_gpio_dir_out(port, pin) \
	__gpio_dir_out(port, pin)

/**
 * Set GPIO pin's output state.
 *
 * @param port port number
 * @param pin  pin number
 */
#define msp_gpio_set(port, pin) \
	__gpio_set(port, pin)

/**
 * Clear GPIO pin's output state.
 *
 * @param port port number
 * @param pin  pin number
 */
#define msp_gpio_clear(port, pin) \
	__gpio_clear(port, pin)

/**
 * Toggle GPIO pin's output state.
 *
 * @param port port number
 * @param pin  pin number
 */
#define msp_gpio_toggle(port, pin) \
	__gpio_toggle(port, pin)

/**
 * Produce a spike on a GPIO pin, by setting and then clearing
 * the pin's output state.
 *
 * @param port port number
 * @param pin  pin number
 */
#define msp_gpio_spike(port, pin) \
	__gpio_set(port, pin); \
	__gpio_clear(port, pin)

// #define DEBUG_PORT 1
// #define DEBUG_PIN  0
// void test()
// {
// 	msp_gpio_spike(DEBUG_PORT, DEBUG_PIN);
// }


#endif /* INCLUDE_MSPBASE_GPIO_H */
