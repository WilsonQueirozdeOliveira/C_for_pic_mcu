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

register1	;adress H'000C'
register2	;adress H'000D'
			
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
	clrf	register1
	clrf	register2

;main			
loop:

	movlw	D'10'	;w = 10
	addlw	D'30'	;w = w + 30 -> w = 10 + 30 = 40

	movlw	H'0A'
	movwf	register1	;registe1 = D'10' = H'0A'

	addwf	register1,w	;w = register1 + w -> w = 10 + 10 = 20

	movwf	register1	;regiter1 = 20
	rlf	register1	;f = register1 << 1 = 40

	rrf	register1	;f = register1 >> 1 = 20

	movlw	D'30'
	movwf	register2

	movfw	register1
	subwf	register2,f	;f = register2 - w
						;register2 = 30 - 20 = 10

	goto	loop

						
	end
	
;	instructions

;	addlw	k
;w = w + k

;	addwf	f,d
;d = w + f
;d = 0 save on (w)
;d = 1 save on (f)
; (w)	addwf	f,w
; (f)	addwf	f,f

;	rlf	f,d
;d = f << 1	-> d = f * 2
;d = 0 save on (w)
;d = 1 save on (f)

;	rrf	f,d
;d = f >> 1	-> d = f / 2
;d = 0 save on (w)
;d = 1 save on (f)

;	sublw	k
;w = k - w

;	subwf	f,d
;d = f - w
;d = 0 save on (w)
;d = 1 save on (f)