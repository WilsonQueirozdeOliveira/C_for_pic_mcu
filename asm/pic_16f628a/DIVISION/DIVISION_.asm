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

;General purpose registers
cblock	H'20'
A0
B0
C0		
endc

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
	bank0
	
	movlw	D'156'
	movwf	A0
	movlw	D'13'
	movwf	B0
	call	div	;A0/BO = <C0>

	goto	$ ;"loop of nop" for interrupt projects

div:
	clrf	C0

div_loop:
	movf	B0,w
	subwf	A0,f
	btfss	STATUS,C
	return
	incf	C0,f
	goto	div_loop
	
	end