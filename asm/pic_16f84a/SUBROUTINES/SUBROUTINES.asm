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
; _XT_OSC = 4MHz
__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF

;register bank select (paginação de memória)minemonicos
#define		bank0	bcf STATUS,RP0	;bank0
#define		bank1	bsf STATUS,RP0	;bank1

;input
#define		button1 	PORTB,RB0
#define		button2 	PORTB,RB2

;output 
#define 	led1		PORTB,RB1
#define 	led2		PORTB,RB3
;reset vector
			org		H'0000'		;origin reset adress 0000h
			goto	start		;avoid interruption
			
;interrupt vector
			org		H'0004'		;interrupt adress
			retfie				;return from interrupition

;init			
start:
			bank1
			movlw	H'ff'		;w = b'11111111'
			movwf	TRISA		;trisa = H'ff' all imput
			movlw 	H'f5'		;w = b'11110101'
			movwf	TRISB		;trisb = H'f5' RB1 RB3 output
			bank0
			movlw	H'f5'
			movwf	PORTB		;RB1 RB3 START CLEAR

;main			
loop:

			call	sub_button1
			call	sub_button2
			goto	loop
			
;subroutines			
sub_button1:
			btfsc	button1
			goto	off_led1
			bsf	led1
			return
			
off_led1:
			bcf	led1
			return
			
sub_button2:
			btfsc	button2
			goto	off_led2
			bsf	led2
			return
			
off_led2:
			bcf	led2
			return
						
			end	;end
			