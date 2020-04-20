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
counter
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

movlw	b'00001100'
movwf	TMR1L
	
movlw	b'11111110'
movwf	TMR1H

;execute comands

;ocillators
;---500us---1kHz ocillator
movlw	h'40'	;RB6 MASK
xorwf	PORTB	;change RB6 state


;---125kHz ocillator 8*500us = 4ms
incf	counter,f; counter++

movlw	h'08'; ( counter = 8 ? )
xorwf	counter,w;counter xor w = 0?

btfss	STATUS,Z;ULA = 0 -> Z = 0
goto	exit_isr
clrf	counter

;---4ms---125kHz ocillator 8
movlw	h'80'
movwf	PORTB
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
	
	movlw	b'00001100'
	movwf	TMR1L
	
	movlw	b'11111110'
	movwf	TMR1H
	
	movlw	h'01'
	movwf	T1CON ;enable TIMER1
	
	movlw	h'07'
	movwf	CMCON ;Comparators Off
	
	goto	$
	
	end
	

;cycle_machine = (1/fosc) = (1/4000000) = 1us

;timer1_overflow = (65536 - TMR1) * 1us * preecaler(T1CKPS)

; 1kHz = 1/1000 = 1ms period
;inverts output 500us

;125kHz = 1/125000 = 8ms
;inverts output 4ms

;time_overflow timer1 need to be equal or less than ->
; -> the smallest ocillatos time period/2

;this case 500us of overflow timer1
; 1kHz need inverts output 500us -> 1 overflow
; 125kHz need inverts output 4ms -> 8 overflow

; init timer1
; timer1_overflow = (65536 - TMR1) * 1us * preecaler(T1CKPS)
;-We need 500us = (65536 - TMR1) * 1us * 1
; TMR1 = (65536 - 500US)/ 1us * 1
; TMR1 = 65036 (b'111111000001100' 16bits)(h'FE0C' 16bits)
; TMR1 = <TMR1H:TMR1L>
; <TMR1H:TMR1L> = <b'11111110':b'00001100'>
; <TMR1H:TMR1L> = <h'FE':h'0C'>