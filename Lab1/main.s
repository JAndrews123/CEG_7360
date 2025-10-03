 /*
 * main.s
 *
 *  Created on: Sep 29, 2025
 *      Author: Joshua Andrews
 *
 */   
	
	
	.syntax unified
    .cpu cortex-m4
    .thumb

    .equ RCC_AHB1_ENR,    0x40023830
    .equ GPIOA_MODER,     0x40020000    //Addresses that are needed for setup
    .equ GPIOA_ODR,       0x40020014

    .equ RCC_AHB1_ENR_GPIOA_EN, 1
    .equ GPIO_MODER_MODER5,   	10        //bitwise shifting and such
    .equ LED_PIN,             	5

    .global blink
    .type blink, %function		 //making my function callable from external sources

flip_led:

    /* Toggle LED (PA5) */
    ldr     r0, =GPIOA_ODR
    ldr     r1, [r0]
    eor     r1, r1, #(1 << LED_PIN) //set the LED pin on or off depending on previous state
    str     r1, [r0]
	mov		pc, lr	//move back to place in main

delay_1dot:
	ldr		r3, =1500000
	ldr		r4, =0          //set compare registers
	
	loop:
	subs	r3, r3, #1
	cmp		r3, r4			//stay in this loop until a subtraction has happened 1500000 times
	bne 	loop
	
	mov		pc, lr //move back to place in main
	
blink:
    
	
    ldr     r0, =RCC_AHB1_ENR
    ldr     r1, [r0]
    orr     r1, r1, 1	//enable the clock for GPIOA
    str     r1, [r0]

    ldr     r0, =GPIOA_MODER
    ldr     r1, [r0]
    orr     r1, r1, #(1 << GPIO_MODER_MODER5) //set pin 5 as an output value
    str     r1, [r0]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    bl		flip_led
	bl		delay_1dot //turn the LED on and loop instructions to wait a "dot"
	
    bl		flip_led
	bl		delay_1dot //turn the LED off and loop instructions to wait a "dot"
	
    bl		flip_led
	bl		delay_1dot
	bl		delay_1dot //turn the LED on and loop instructions 3 times to act as a "line"
	bl		delay_1dot

    bl		flip_led
	bl		delay_1dot            //Morse code for the letter J

    bl		flip_led
	bl		delay_1dot
	bl		delay_1dot
	bl		delay_1dot
	
    bl		flip_led
	bl		delay_1dot
	
    bl		flip_led
	bl		delay_1dot
	bl		delay_1dot
	bl		delay_1dot
	
	bl		flip_led
	bl		delay_1dot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	bl		delay_1dot
	bl		delay_1dot
	bl		delay_1dot  //delay for 3 dots as a new letter signifier

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
    bl		flip_led
	bl		delay_1dot
	bl		delay_1dot 
	bl		delay_1dot

    bl		flip_led
	bl		delay_1dot            //Morse code for the letter O

    bl		flip_led
	bl		delay_1dot
	bl		delay_1dot
	bl		delay_1dot
	
    bl		flip_led
	bl		delay_1dot
	
    bl		flip_led
	bl		delay_1dot
	bl		delay_1dot
	bl		delay_1dot
	
	bl		flip_led
	bl		delay_1dot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	bl		delay_1dot
	bl		delay_1dot
	bl		delay_1dot  //delay for 3 dots as a new letter signifier

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
    bl		flip_led
	bl		delay_1dot

    bl		flip_led
	bl		delay_1dot            

    bl		flip_led
	bl		delay_1dot
	
    bl		flip_led			//Morse code for the letter S
	bl		delay_1dot
	
    bl		flip_led
	bl		delay_1dot
	
	bl		flip_led
	bl		delay_1dot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	bl		delay_1dot
	bl		delay_1dot
	bl		delay_1dot  //delay for 3 dots as a new letter signifier
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
    bl		flip_led
	bl		delay_1dot

    bl		flip_led
	bl		delay_1dot            

    bl		flip_led
	bl		delay_1dot
	
    bl		flip_led
	bl		delay_1dot			//Morse code for the letter H
	
    bl		flip_led
	bl		delay_1dot
	
	bl		flip_led
	bl		delay_1dot
	
    bl		flip_led
	bl		delay_1dot
	
	bl		flip_led
	bl		delay_1dot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	bl		delay_1dot
	bl		delay_1dot
	bl		delay_1dot  //delay for 3 dots as a new letter signifier

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
    bl		flip_led
	bl		delay_1dot

    bl		flip_led
	bl		delay_1dot            

    bl		flip_led
	bl		delay_1dot
	
    bl		flip_led			//Morse code for the letter U
	bl		delay_1dot
	
    bl		flip_led
	bl		delay_1dot
	bl		delay_1dot
	bl		delay_1dot
	
	bl		flip_led
	bl		delay_1dot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	bl		delay_1dot
	bl		delay_1dot
	bl		delay_1dot  //delay for 3 dots as a new letter signifier

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
    bl		flip_led
	bl		delay_1dot

    bl		flip_led
	bl		delay_1dot            

    bl		flip_led			//Morse code for the letter A
	bl		delay_1dot
	bl		delay_1dot
	bl		delay_1dot
	
    bl		flip_led			
	bl		delay_1dot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	bl		delay_1dot
	bl		delay_1dot
	bl		delay_1dot  //delay for 5 dots as a new print of JOSHUA
	bl		delay_1dot
	bl		delay_1dot	
	b		blink
	.end


