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

;input
#define	s1	PORTB,RB0

;output
#define	led1	PORTA,RA3
#define	led2	PORTA,RA2
#define	saida1	PORTB,RB1
#define	saida	PORTB,RB4

;const
mask_RB1	equ	B'00000010'
mask_RB4	equ	B'00010000'

;General purpose registers
cblock	H'20'
T0
T1
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
	movlw	H'00'
	movwf	TRISB
	bank0
	movlw	H'07'
	movwf	CMCON ;config as digital RA0:RA3 pins
	clrf	PORTB

;	goto	$ ;"loop of nop" for interrupt projects

loop:
	movlw	mask_RB1
	xorwf	PORTB,f
	call	_500ms
	movlw	mask_RB4
	xorwf	PORTB,f
	call	_500ms
	
	goto	loop
	
_500ms:
	movlw	D'200'
	movwf	T0
	
aux1:
	movlw	D'250'
	movwf	T1
	
aux2:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	decfsz	T1
	goto aux2
	
	return
	
	end