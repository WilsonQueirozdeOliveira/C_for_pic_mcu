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
;--end save context

;interrupt_ISR
btfss	PIR1,TMR1IF
goto	exit_isr
bcf	PIR1,TMR1IF

movlw	h'00'
movwf	TMR1L
	
movlw	h'00'
movwf	TMR1H

;execute comands
comf	PORTB

;end comands
;end interrupt_ISR

;--retrive context
exit_isr:
	swapf	status_temp,W
	movwf	STATUS
	swapf	w_temp,F
	swapf	w_temp,W
retfie

;init			
start:
	bank1
	movlw	H'FF'
	movwf	OPTION_REG
	
	bcf	TRISB,RB7	
	
	bsf	PIE1,TMR1IE
	
	bank0
	bcf	PORTB,RB7
	
	movlw	H'c0'
	movwf	INTCON
	
	movlw	H'01'
	movwf	PIE1
	
	movlw	h'01'
	movwf	T1CON ;enable TIMER1
	
	movlw	h'00'
	movwf	TMR1L
	
	movlw	h'00'
	movwf	TMR1H
	
	movlw	h'07'
	movwf	CMCON ;Comparators Off
	


	goto	$
	
	end
	

;cycle_machine = (1/fosc) = (1/4000000) = 1us

;timer1_overflow = (65536 - TMR1) * 1us * preecaler(T1CKPS)
