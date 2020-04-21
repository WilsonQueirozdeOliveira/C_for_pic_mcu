;
;	MPLAB IDE v8.92 compiler MPASM	v5.51
;
;	Autor : wilson Tecnologia
;
;	Assembly
;
;	PIC12F675 Clock 4MHz
;
;	PIC16 35 instruction set

list p=12f675

#include <p12f675.inc>

;fuse bits
; _XT_OSC = 4MHz 1us of machine cycle
__config _INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_ON & _MCLRE_OFF & _BOREN_OFF & _CPD_OFF & _CP_OFF

;register bank select memory map
#define	bank0	bcf	STATUS,RP0	;bank0
#define	bank1	bsf	STATUS,RP0	;bank1

;output/INPUT
#define	pot	GPIO,GP0 ;AN0
#define	out	GPIO,GP5


;General purpose registers
cblock	H'20'
w_temp
status_temp
T0
value_adc
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
	movlw	h'11'
	movwf	ANSEL
	
	movlw	h'DF'
	movwf	TRISIO

	bank0
	bcf	out
	
	movlw	h'07'
	movwf	CMCON
	
	movlw	h'01'
	movwf	ADCON0
	
	movlw	h'64'
	movwf	T0

	movlw	h'80'
	movwf	value_adc
	
loop:
	bsf	ADCON0,GO_DONE
	
wait_adc:
	btfsc	ADCON0,GO_DONE
	goto	wait_adc
	
	movf	ADRESH,W
	
	andwf	value_adc,w
	btfsc	STATUS,Z
	goto	out_high
	bcf	 out
	goto continua
	
out_high:
	bsf	out
	
continua:
	movlw	h'64'
	movwf	T0
	
	call	_100us
	call	_100us
	call	_100us
	call	_100us
	call	_100us
	
	goto	loop
	
_100us:
	decfsz	T0,f
	goto	_100us
	return
	
	end