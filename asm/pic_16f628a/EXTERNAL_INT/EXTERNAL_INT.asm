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
counter2
tempo1
tempo2
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
btfss	INTCON,INTF	;interrupt flag is set?
goto	exit_isr	;NO,exit interrupt
bcf	INTCON,INTF	;YES,clear flag

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
	movlw	H'FD'
	movwf	TRISB
	
	movlw	H'40'
	movwf	OPTION_REG	;RN0/INT external interrupt
	bank0
	movlw	H'90'
	movwf	INTCON
	bcf	PORTB,RB1

	goto $
	
	end