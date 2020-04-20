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

;input
#define	s1	PORTB,RB0
#define	s2	PORTA,RA5

;output
#define	LED1	PORTA,RA3
#define	LED2	PORTA,RA2

;General purpose registers
cblock	H'20'
endc

;reset vector
org	H'0000'
goto	start
			
;interrupt vector
org	H'0004'
retfie

;init			
start:
	bank1
	movlw	H'f7'
	movwf	TRISB
	
	movlw	H'56'
	movwf	OPTION_REG ;timer0 prescaler 1:128
	
	movlw	H'31'
	movwf	PR2
	
	bank0
	movlw	h'07'
	movwf	CMCON
	
	movlw	h'06'
	movwf	T2CON 
	
	movlw	H'E0'
	movwf	INTCON
	
	movlw	b'00010110'
	movwf	CCPR1L ;START 50%
	
	movlw	b'00101100'
	movwf	CCP1CON
	
	goto	$
	
	end
	

;cycle_machine = (1/fosc) = (1/4000000) = 1us

;cycle_pwm = (PR2 + 1) * cycle_machine * prescaler of TMR2
;cycle_pwm =  (49+1)   *    1us     *      16
;cycle_pwm =  800us

;PWM_frequency = (1/800us) = 1250Hz

;ocilation_cycle	= (1/fosc) =
;ocilation_cycle	= (1/4000000) = 250us

;duty_time = (CCPR1L:CCP1CON<5:4>)* ocilation_cycle * prescaler of TMR2
;duty_time = (CCPR1L:CCP1CON<5:4>)* 312us * 16

; 10bits
;   CCPR1L CCP1CON,5 CCP1COM,4
; 00000000    0         0
;
;cycle_pwm = 800us
;duty 45% = 360us = duty_time

;(CCPR1L:CCP1CON<5:4>) = (duty_time)/(ocilation_cycle*prescaler of TMR2)
;(CCPR1L:CCP1CON<5:4>) = (360us)/( 250us * 16 )
;(CCPR1L:CCP1CON<5:4>) = 90 = b'00010110-10'(10bits)