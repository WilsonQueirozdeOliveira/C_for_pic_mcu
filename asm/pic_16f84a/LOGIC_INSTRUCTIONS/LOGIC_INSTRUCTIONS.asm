;
;	MPLAB IDE v8.92 compiler MPASM	v5.51
;
;	Date: 09_04_2020
;
;	Autor : wilson 
;
;	Assembly
;
;	PIC16F84a Clock 4MHz
;
;	PIC16 35 instruction set

list p=16f84a	; micro PIC16F84a

;included files
#include <p16f84a.inc>

;fuse bits
; _XT_OSC = 4MHz 1us by cycle
__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF

;register bank select memory map
#define		bank0	bcf	STATUS,RP0	;bank0
#define		bank1	bsf	STATUS,RP0	;bank1

;input
#define		button1	PORTB,RB0
#define		button2	PORTB,RB2

;output 
#define 	led1	PORTB,RB1
#define 	led2	PORTB,RB3

;variable(General purpose registers)
cblock	H'000C'

reg1	;adress H'000C'
reg2	;adress H'000D'
			
endc	;H'004F'

;reset vector
	org	H'0000'	;origin reset adress 0000h
	goto	start		;avoid interruption
			
;interrupt vector
	org	H'0004'	;interrupt adress
	retfie	;return from interrupition

;init			
start:
	bank1
	movlw	H'FF'
	movwf	TRISA
	movlw 	H'FF'
	movwf	TRISB
	bank0
	clrf	reg1	;register1
	clrf	reg2	;register2

;main			
loop:

	movlw	B'11110000'
	andlw	B'10100001'	;w = w and B'11110000' = 10100000
	
	xorwf	reg1,f	;reg1 = w xor reg1 = 10100000
	
	andwf	reg1,f	;regr1 = w and reg1 = 10100000
	
	comf	reg1,f	;reg1 = 01011111
	
	iorlw	B'11111111'	; w = 11111111
	
	xorlw	B'11111110'	;w = 00000001
	
	xorwf	reg1,w	;w = 01011110

	goto	loop
	
	end
	
;	instructions

;andlw	k
;w = w AND K

;	andwf	f,d
;d = w AND f
;d = 0 save on (w)
;d = 1 save on (f)
; (w)	addwf	f,w
; (f)	addwf	f,f

;comf	f,d
;d = NOT f
;d = 0 save on (w)
;d = 1 save on (f)

;iorlw	k
;w = w OR k

;iorwf	f,d
;d = w OR f
;d = 0 save on (w)
;d = 1 save on (f)

;xorlw	k
;w = w XOR k
;change flag Z STATUS

;xorwf	f,d
;d = w XOR
;d = 0 save on (w)
;d = 1 save on (f)
;change flag Z STATUS