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
	movlw	D'10'
	movwf	reg1
	
aux1:
	decfsz	reg1,f
	goto	aux1
	
	movlw	D'245'
	movwf	reg1
	
aux2:
	incfsz	reg1,f
	goto	aux2
	
	movlw	B'11111110'
	movwf	reg2
	
aux3:
	btfsc	reg2,7
	goto	aux4
	goto	aux5
	
aux4:
	rlf	reg2
	goto	aux3

aux5:
	movlw	B'00000001'
	movwf	reg2

aux6:
	btfss	reg2,7
	goto	aux7
	goto	aux8
	
aux7:
	rlf	reg2
	goto	aux6
	
aux8:

	goto	loop
	
	end
	
;	instructions

;decfsz	f,d
;d = f - 1	(skip if (f = 0))
;d = 0 save on (w)
;d = 1 save on (f)

;incfsz	f,d
;d = f + 1	(skip if (f = 0))
;d = 0 save on (w)
;d = 1 save on (f)

;btfsc	f,b
;test bit(b) of register file(f)skip if clear

;btfss	f,d
;test bit(b) of register file(f)skip if set