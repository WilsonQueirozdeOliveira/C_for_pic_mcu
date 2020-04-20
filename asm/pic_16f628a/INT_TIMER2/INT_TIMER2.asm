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
__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

;register bank select memory map
#define	bank0	bcf	STATUS,RP0	;bank0
#define	bank1	bsf	STATUS,RP0	;bank1

;output
#define	LED1	PORTA,RA3
#define	LED2	PORTA,RA2

;input
#define	s1	PORTB,RB0
;RB <7:4> EXTERNAL INTERRUPT ON CHANGE STATE

;General purpose registers
cblock	H'20'
w_temp
status_temp
endc

;reset vector
org	H'0000'
goto	start
			
;interrupt vector
org	H'0004'

;--save context
movwf	w_temp
swapf	STATUS,w
bank0
movwf	status_temp

;interrupt_ISR
btfss	PIR1,TMR2IF	;interrupt flag is set?
goto	exit_isr	;NO,exit interrupt
bcf	PIR1,TMR2IF	;YES,clear flag

;execute comands
comf	PORTB

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
	movlw	H'FE'
	movwf	TRISB
	
	movlw	H'7F'
	movwf	OPTION_REG
	
	movlw	H'02'
	movwf	PIE1
	
	movlw	H'65'
	movwf	PR2
	
	bank0
	movlw	H'FE'
	movwf	PORTB
	
	movlw	B'00100101'
	movwf	T2CON	;postscaler 1:5 , timer2_on ,prescaler 1:4 
	
	movlw	H'02'
	movwf	PIR1
	
	movlw	H'C0'
	movwf	INTCON	;enable peripheral interrupt
	


loop:
	bsf	PORTB,RB1
	goto loop
	
	end
	
;time_cycle * PR2 * prescaler * postscaler = overflow_timer2
;   1us   *  101 *   4  * 5  = 2,020ms