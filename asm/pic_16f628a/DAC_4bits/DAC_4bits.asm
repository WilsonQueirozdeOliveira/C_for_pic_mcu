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
__config _XT_OSC & _WDT_ON & _PWRTE_ON & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

;register bank select memory map
#define	bank0	bcf	STATUS,RP0	;bank0
#define	bank1	bsf	STATUS,RP0	;bank1

;output/INPUT
#define	LED1	PORTA,RA3
#define	LED2	PORTA,RA2
#define	out	PORTB,RB4
;/
#define	s1	PORTB,RB0
#define	s2	PORTA,RA5

;General purpose registers
cblock	H'20'
w_temp
status_temp
DAC
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
;---check interruption

;---end check interruption

;execute comands

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
	movlw	h'7F'
	movwf	OPTION_REG
	
	movlw	h'FF'
	movwf	TRISA
	
	movlw	h'EF'
	movwf	TRISB
	
	movlw	H'E0'
	movwf	VRCON

	bank0
	movlw	h'EF'
	movwf	PORTB
	
	movlw	h'07'
	movwf	CMCON

loop:
	bank0
	movf	PORTB,W
	bank1
	movwf	VRCON
	
	goto	loop
	
	end

;cycle_machine = (1/fosc) = (1/4000000) = 1us 