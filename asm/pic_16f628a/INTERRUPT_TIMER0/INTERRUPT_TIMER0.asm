;
;	MPLAB IDE v8.92 compiler MPASM	v5.51
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
;TIME_CYCLE = (1/4MHz)/4 = 1us
__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _MCLRE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

;register bank select memory map
#define	bank0	bcf	STATUS,RP0	;bank0
#define	bank1	bsf	STATUS,RP0	;bank1

;General purpose registers
cblock	H'20'
w_temp
status_temp
endc

;reset vector
org	H'0000'	;origin reset adress 0000h
goto	start	;avoid interruption
			
;interrupt vector
org	H'0004'	;interrupt adress
;--save context
movwf	w_temp
swapf	STATUS,w	;swap inverts aaaabbbb -> bbbbaaaa
bank0
movwf	status_temp

;interrupt_ISR
btfss	INTCON,T0IF	;interrupt flag is set?
goto	exit_isr	;NO,exit interrupt
bcf	INTCON,T0IF	;YES,clear flag
movlw	D'10'	;VALUE PRESET TIMER0
movwf	TMR0	;RESET TIMER0
comf	PORTA	;inverts PORTA
;interrupt end

;--retrive context
exit_isr:
	swapf	status_temp,w
	movwf	STATUS
	swapf	w_temp,f
	swapf	w_temp,w
	retfie;return from interrupition

;init			
start:
	bank1
	movlw	H'80'	;pullup off /prescaler assigned to the TIMER0
	movwf	OPTION_REG	;prescaler 1:2
	
	movlw	H'F3'
	movwf	TRISB
	movlw	H'00'
	movwf	TRISA
	bank0
	movlw	H'07'
	movwf	CMCON	;config as digital RA0:RA3 pins
	movlw	H'A0'	;enable global interrupt
	movwf	INTCON	;enable TMR0 interrupt
	
	movlw	D'10'
	movwf	TMR0

	goto	$ ;"loop of nop" for interrupt projects
	;on overflow timer0 T0IF is set -> INTCON= b'00000100'
	;N_BITS - TMR0 * PRE_SCALER * TIME_CYCLE
	;256 - 10 * 2 * 1us = 492us
	
	end