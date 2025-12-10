/*///////////////////////////////////////////////////////////

	Author: Joshua Andrews
	Date: 12/07/25

	Code used from the following sources
	https://dev.to/theembeddedrustacean/stm32f4-embedded-rust-at-the-hal-uart-serial-communication-1oc8
	https://www.doulos.com/knowhow/arm-embedded/rust-insights-your-first-steps-into-embedded-rust/
	
	main.rs is an application that intakes a key stream from the user over UART
	in order to wrap and unwrap the key to be displayed ot the user

*////////////////////////////////////////////////////////////

#![deny(unsafe_code)]
#![no_main]
#![no_std]

use panic_halt as _;

use cortex_m_rt::entry;
use stm32f4xx_hal::{pac, 
	prelude::*, 
	gpio::{gpioc::PC13, Output, PushPull},
	serial::{Serial, config::Config}
	};

use cortex_m_semihosting::hprintln;

use aes_kw::Kek;
use hex_literal::hex;

#[allow(clippy::empty_loop)]
#[entry]
fn main() -> ! {
	
	let kek = Kek::from(hex!("000102030405060708090A0B0C0D0E0F"));
	let input_key = hex!("00112233445566778899AABBCCDDEEFF");

	hprintln!("{:?}", input_key);
	let wrapped_key: & mut [u8] = &mut [0u8; 24];

	Kek::wrap(&kek, &input_key, wrapped_key);
	assert_eq!(wrapped_key, hex!("1FA68B0A8112B447AEF34BD8FB5A7B829D3E862371D2CFE5"));

	hprintln!("key wrapped");
	hprintln!("{:?}", wrapped_key);
	
	let unwrapped_key: & mut [u8] = &mut [0u8; 16];
	
	Kek::unwrap(&kek, &wrapped_key, unwrapped_key);
	
	hprintln!("key unwrapped");
	hprintln!("{:?}", unwrapped_key);
	
	assert_eq!(unwrapped_key, input_key);

	
	//This is future work code for attempted peripheral interactions
	/*
	let dp = pac::Peripherals::take().unwrap();
	let rcc = dp.RCC.constrain();
 	let clocks = rcc.cfgr.sysclk(84.mhz()).freeze();
	 // Set up the GPIO pin
	let gpioa = dp.GPIOA.split();
	let gpioc = dp.GPIOC.split();
	let mut led = gpioa.pa5.into_push_pull_output();
	
	let tx_pa2 = gpioa.pa2.into_alternate();
	let rx_pa3 = gpioa.pa3.into_alternate();
	let mut temp = Serial::new(
        dp.USART2,
        (tx_pa2, rx_pa3),
        Config::default().baudrate(115_200.bps()),
        &clocks,
    	);
    	
	// Blink the LED
	loop 
	{
		led.set_high();
		cortex_m::asm::delay(clocks.sysclk().0 / 2); // Delay
		led.set_low();
		cortex_m::asm::delay(clocks.sysclk().0 / 2); // Delay
 	}
 	*/
 	
    	loop 
   	{
       		hprintln!("wrap and unwrap is done");
    	}    
}
