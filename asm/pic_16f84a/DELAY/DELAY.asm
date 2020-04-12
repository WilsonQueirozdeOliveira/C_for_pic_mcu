;
;	MPLAB IDE v8.92 compiler MPASM	v5.51
;
;	Date: 09_04_2020
;
;	Autor : wilson 
;
;	Assembly
;
;	PIC16F84a Clock 4MHz
;
;	PIC16 35 instruction set

list p=16f84a	; micro PIC16F84a

;included files
#include <p16f84a.inc>

;fuse bits
; _XT_OSC = 4MHz 1us by cycle
__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF

;register bank select memory map
#define		bank0	bcf STATUS,RP0	;bank0
#define		bank1	bsf STATUS,RP0	;bank1

;input
#define		button1 	PORTB,RB0
#define		button2 	PORTB,RB2

;output 
#define 	led1		PORTB,RB1
#define 	led2		PORTB,RB3

;variable
		cblock H'000C'
			
		time0
		time1
			
		endc

;reset vector
		org		H'0000'		;origin reset adress 0000h
		goto	start		;avoid interruption
			
;interrupt vector
		org		H'0004'		;interrupt adress
		retfie				;return from interrupition

;init			
start:
		bank1
		movlw	H'FF'		;w = b'11111111'
		movwf	TRISA		;trisa = H'ff' all imput
		movlw 	H'F5'		;w = b'11110101'
		movwf	TRISB		;trisb = H'f5' RB1 RB3 output
		bank0
		movlw	H'F5'
		movwf	PORTB		;RB1 RB3 START CLEAR

;main			
loop:
		bsf	led1
		bcf	led2
		call	delay500ms
		bcf	led1
		bsf	led2
		call	delay500ms
			
		goto	loop
			
delay500ms:
		movlw	D'200'
		movwf	time0	;adress H'0C'
			
		;2-call+1-movlw+1-movwf = 4 cycles
		;4 cycles of 1us
			
aux1:
		movlw	D'250'
		movwf	time1	;adress H'0D'
			
		;2 cycles (2 x 250 = 500us negligible)
			
aux2:
		nop	;1 cycle
		nop
		nop
		nop
		nop
		nop
		nop
		decfsz	time1
		goto	aux2
			
		;7nop+1-decfsz+2-goto = 10 cycles
		;250 x 10 cycles = 2500 cycles = 2500us
			
		decfsz	time0
		goto	aux1
			
		;1-decfsz+2-goto
			
		;when skip time0=0
		;200 x 2500 = 500000 us = ~delay500ms///
			
		return	;2 cycles
						
		end	;end
			