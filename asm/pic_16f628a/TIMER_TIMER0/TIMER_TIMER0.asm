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

;input
#define	s1	PORTB,RB0

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
movlw	D'0'	;VALUE PRESET TIMER0
movwf	TMR0	;RESET TIMER0

;--execute comands
decfsz	counter1
goto	exit_isr

movlw	D'128'
movwf	counter1

bcf	LED1
bcf	INTCON,T0IE
bsf	LED2

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
	movlw	H'06'	;pullup ON /prescaler assigned to the TIMER0
	movwf	OPTION_REG	;prescaler 1:128
	
	movlw	H'F3'
	movwf	TRISA
	
	bank0
	movlw	H'07'
	movwf	CMCON	;config as digital RA0:RA3 pins
	
	movlw	H'80'	;enable global interrupt
	movwf	INTCON	;desable TMR0 interrupt
	
	movlw	D'0'
	movwf	TMR0
	
	movlw	D'128'
	movwf	counter1
	
	bcf	LED1
	bcf	LED2

loop:
	btfss	s1
	goto	timer_ON
	goto	loop
	
timer_ON
	bsf	LED1
	bsf	INTCON,T0IE
	goto	loop
	
	end
	
;TIME_CYCLE = (1/4MHz)/4 = 1us
;N_BITS - TMR0 * PRE_SCALER * TIME_CYCLE
;256 - 0 * 128 * 1us = 32.768us = 32,768ms

;32,768ms * counter1 = 
;32,768ms * 128 = 4,194304s