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
timer
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
btfss	PIR1,TMR1IF
goto	exit_isr
bcf	PIR1,TMR1IF
;---end check interruption

movlw	h'3c'
movwf	TMR1L
	
movlw	h'b0'
movwf	TMR1H

;execute comands
; -- 200 ms --
	incf		counter,F
	
	movlw		H'05'	
	xorwf		counter,W
	
	btfss		STATUS,Z
	goto		exit_isr
	clrf		counter
	
; -- 1 segundo --
	incf		timer,F	

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
	movlw		H'10'
	movwf		TRISB
	bsf			PIE1,TMR1IE
	bank0					
	bcf			PORTB,7	
	movlw		H'C0'	
	movwf		INTCON	
	movlw		H'21'	
	movwf		T1CON	
	movlw		H'3C'	
	movwf		TMR1H	
	movlw		H'B0'	
	movwf		TMR1L	
	clrf		counter	
	clrf		timer
	
loop:

	call		atualiza
	goto		loop

converte:							

	movf		timer,W		
	andlw		H'0F'		

	addwf		PCL,F		
				;'EDC.BAFG'	
	retlw		B'11101110'			;Retorna s�mbolo '0'
	retlw		B'00101000'			;Retorna s�mbolo '1'
	retlw		B'11001101'			;Retorna s�mbolo '2'
	retlw		B'01101101'			;Retorna s�mbolo '3'
	retlw		B'00101011'			;Retorna s�mbolo '4'
	retlw		B'01100111'			;Retorna s�mbolo '5'
	retlw		B'11100111'			;Retorna s�mbolo '6'
	retlw		B'00101100'			;Retorna s�mbolo '7'
	retlw		B'11101111'			;Retorna s�mbolo '8'
	retlw		B'01101111'			;Retorna s�mbolo '9'
	retlw		B'10101111'			;Retorna s�mbolo 'A'
	retlw		B'11100011'			;Retorna s�mbolo 'b'
	retlw		B'11000110'			;Retorna s�mbolo 'C'
	retlw		B'11101001'			;Retorna s�mbolo 'd'
	retlw		B'11000111'			;Retorna s�mbolo 'E'
	retlw		B'10000111'			;Retorna s�mbolo 'F'

atualiza:									

	call		converte			
	movwf		PORTB				
	return							

	end
	

;cycle_machine = (1/fosc) = (1/4000000) = 1us

;timer1_overflow = (65536 - TMR1) * 1us * preecaler(T1CKPS)

; 1kHz = 1/1000 = 1ms period
;inverts output 500us

;125kHz = 1/125000 = 8ms
;inverts output 4ms

; time_overflow timer1 need to be equal or less than
; the smallest ocillatos time period/2

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

; For more precision 
; get the number of instruction
; used for save context, check interruption
; and reset timer preset
;	total 11 instructions
; New preset = (500 - 12)-65536 = 65048 = h'FE18'
;NEW PRESET = h'FE18' 