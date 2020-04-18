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

;const
v_bouncing	equ	D'250'

;General purpose registers
cblock	H'20'
bouncing		
endc ;H'6F'

;reset vector
org	H'0000'	;origin reset adress 0000h
goto	start	;avoid interruption
			
;interrupt vector
org	H'0004'	;interrupt adress
retfie	;return from interrupition

;init			
start:
	bank0
	movlw	H'07'
	movwf	CMCON ;config as digital RA0:RA3 pins
	bank1
	movlw	H'00'
	movwf	OPTION_REG
	movlw	H'13'
	movwf	TRISA ;config output and input
	movlw	H'FF'
	movwf	TRISB
	bank0
	bsf	led1
	bcf	led2
		
	bank0
	clrf	bouncing

;	goto	$ ;"loop of nop" for interrupt projects

;main			
loop:

	movlw	v_bouncing
	movwf	bouncing
	
test_butt:

	btfsc	s1
	goto	loop
	decfsz	bouncing,f
	goto	test_butt
	
	comf	PORTA
	
	goto	loop
	
	end