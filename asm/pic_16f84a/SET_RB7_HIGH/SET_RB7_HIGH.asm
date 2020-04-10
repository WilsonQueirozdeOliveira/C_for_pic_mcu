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

;output 
#define 	led1		PORTB,RB7

;reset vector
			org		H'0000'		;origin reset adress 0000h
			goto	start		;avoid interruption
			
;interrupt vector
			org		H'0004'		;interrupt adress
			retfie				;return from interrupition

;main			
start:
			bank1
			movlw	H'ff'		;w = H'ff'
			movwf	TRISA		;trisa = H'ff' all imput
			movlw 	H'7f'		;w = H'7f'
			movwf	TRISB		;trisb = H'7f' RB7 output
			bank0
			movlw	H'ff'
			movwf	PORTB		;all portb to high
			
			goto	$			;infinity loop
			
			end					;fim
			