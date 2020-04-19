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
w_temp
status_temp
endc

;reset vector
org	H'0000'	;origin reset adress 0000h
goto	start	;avoid interruption
			
;interrupt vector
org	H'0004'	;interrupt adress

;--save context
movwf	w_temp
swapf	STATUS,w	;swap inverts aaaabbbb -> bbbbaaaa
bank0
movwf	status_temp

;interrupt



;interrupt end

;--retrive context
exit_ISR:
	swapf	status_temp,w
	movwf	STATUS
	swapf	w_temp,f
	swapf	w_temp,w
	retfie;return from interrupition

;init			
start:
	bank1
	movlw	H'00'
	movwf	OPTION_REG
	movlw	H'00'
	movwf	TRISB
	bank0
	movlw	H'07'
	movwf	CMCON ;config as digital RA0:RA3 pins
	movlw	H'00'
	movwf	INTCON

loop:
	movlw	H'01'
	xorwf	PORTB,f
	goto	H'0004'	;simulation not used normally
	goto	loop
;	goto	$ ;"loop of nop" for interrupt projects
	
	end