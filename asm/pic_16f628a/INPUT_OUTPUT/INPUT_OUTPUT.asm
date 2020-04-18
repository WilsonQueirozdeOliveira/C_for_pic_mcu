;
;	MPLAB IDE v8.92 compiler MPASM	v5.51
;
;	Date: 09_04_2020
;
;	Autor : wilson Tecnologia
;
;	Assembly
;
;	PIC16F628a Clock 4MHz
;
;	PIC16 35 instruction set

list p=16f628a

#include <p16f628a.inc>

;fuse bits
; _XT_OSC = 4MHz 1us of machine cycle
__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _MCLRE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

;register bank select memory map
#define	bank0	bcf	STATUS,RP0	;bank0
#define	bank1	bsf	STATUS,RP0	;bank1

;input
#define	S1	PORTB,RB0

;output 
#define	led1	PORTA,RA3
#define	led2	PORTA,RA2

;variable(General purpose registers)
cblock	H'20'

reg1
reg2
			
endc ;H'6F'

;reset vector
org	H'0000'	;origin reset adress 0000h
goto	start	;avoid interruption
			
;interrupt vector
org	H'0004'	;interrupt adress
retfie	;return from interrupition

;init			
start:
	bank0
	movlw	H'07'
	movwf	CMCON ;config as digital RA0:RA3 pins
	bank1
	movlw	H'13'
	movwf	TRISA ;config output and input
	movlw	H'FF'
	movwf	TRISB
	bank0
	bcf	led1
	bcf	led2
		
	bank0
	clrf	reg1	;register1
	clrf	reg2	;register2

;	goto	$ ;"loop of nop" for interrupt projects

;main			
loop:

	goto	loop
	
	end