.syntax unified
.cpu cortex-m3
.thumb

.global vtable
.global reset_handler

.type vtable, %object
vtable:
	.word _estack
	.word reset_handler
.size vtable, .-vtable

.type reset_handler, %function
reset_handler:
	LDR 	r0, =_estack
	MOV 	sp, r0

	@ Enable RCC->APB2ENR IOPC EN bit
	LDR	r1, =0x40021018
	LDR	r2, [r1]
	ORR     r2, r2, (1<<4)
	STR	r2, [r1]
	
	@ Configure PC13 as General Purpose Output Push-Pull
	LDR	r1, =0x40011004
	LDR	r2, [r1]
	ORR	r2, r2, (1<<20)
	ORR	r2, r2, (1<<21)
	AND	r2, r2, ~(1<<22)
	AND	r2, r2, ~(1<<23)
	STR	r2, [r1]

	MOVS	r0, #0
	
	main_loop:

		@ Toggles 13th bit of GPIOC->ODR register
		LDR r1, =0x4001100C
		LDR	r2, [r1]
		EOR	r2, r2, (1<<13)
		STR r2, [r1]
		
		@ Delays according to r3 register value
		LDR	r3, =2000000
		BL	delay		

		ADDS r0, r0, #1
		B	main_loop
	delay:
		delayLoop:
			subs r3, #1
			bne delayLoop
			bx lr
.size reset_handler, .-reset_handler




