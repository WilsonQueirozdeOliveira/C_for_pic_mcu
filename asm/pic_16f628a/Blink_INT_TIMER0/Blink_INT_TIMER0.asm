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
__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _MCLRE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

;register bank select memory map
#define	bank0	bcf	STATUS,RP0	;bank0
#define	bank1	bsf	STATUS,RP0	;bank1

;output
#define	LED1	PORTA,RA3
#define	LED2	PORTA,RA2

;General purpose registers
cblock	H'20'
w_temp
status_temp
counter1
endc

;reset vector
org	H'0000'
goto	start
			
;interrupt vector
org	H'0004'
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

;--execute comands
decfsz	counter1
goto	exit_isr
movlw	D'18'
movwf	counter1
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
	movlw	H'86'	;pullup off /prescaler assigned to the TIMER0
	movwf	OPTION_REG	;prescaler 1:128
	
	movlw	H'F3'
	movwf	TRISA
	
	bank0
	movlw	H'07'
	movwf	CMCON	;config as digital RA0:RA3 pins
	
	movlw	H'A0'	;enable global interrupt
	movwf	INTCON	;enable TMR0 interrupt
	
	movlw	D'10'
	movwf	TMR0
	
	movlw	D'18'
	movwf	counter1
	
	bcf	LED1
	bsf	LED2

	goto	$
	
	end
	
;TIME_CYCLE = (1/4MHz)/4 = 1us
;N_BITS - TMR0 * PRE_SCALER * TIME_CYCLE
;256 - 10 * 128 * 1us = 31.488us = 31,488ms

;31,488ms * counter1 = 
;31,488ms * 18 = 566,784ms