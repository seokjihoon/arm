@--------------------------------------------------
@ Use C100 Processor's USB Boot Function (MAX 16KB)
@--------------------------------------------------
	
	.include "C100addr.inc"

	.code	32
	.text
 
	.global __start
__start:

@--------------------------------------------------
@ Watchdog Disable
@--------------------------------------------------
                
	ldr		r0, =WTCON
	ldr		r1, =0x0
	str		r1, [r0]

@--------------------------------------------------
@ GPIO(LED OUTPUT) Test
@--------------------------------------------------

	@ LED Control (GPJ3.0, GPJ3.2)
	ldr		r0, =GPJ3_CON
	ldr		r1, [r0]
	ldr		r2, =(0xF<<8)|(0xF<<0)
	bic		r1, r1, r2
	ldr		r2, =(0x1<<8)|(0x1<<0)
	orr		r1, r1, r2
	str		r1, [r0]

	@ LED: XX (all off)
	ldr		r0, =GPJ3_DAT
	ldr		r1, [r0]
	ldr		r2, =(0x1<<2)|(0x1<<0)
	bic		r1, r2, r1
	str		r1, [r0]

	@ Toggling Loop (무한 루프)

	ldr		r1, =GPJ3_DAT
	ldr		r2, [r1]

	mov		r4, #0
	mov		r3, #20

1:
	eor		r2, r2, #(0x1<<2)|(0x1<<0)
	str		r2, [r1]

	add		r4, r4, #0x90000
	rsb		r0, r4, #0x1000000
	@mov		r0, #0x1000000

2:

	subs	r0, r0, #1
	BGT		2b

	subs	r3, r3, #1
	BGT		1b

	b		.

	@ Padding Byte for over 512 byte (USB loader bug?)

	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			
	.end
