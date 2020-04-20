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
btfss	INTCON,T0IF
goto	exit_isr
bcf	INTCON,T0IF

;execute comands
movlw	D'180'
movwf	TMR0
btfss	s1
goto	inc_pwm
btfss	s2
goto	dec_pwm
goto	exit_isr

inc_pwm:
	movlw	D'255'
	xorwf	CCPR1L,W
	btfsc	STATUS,Z
	goto	exit_isr
	incf	CCPR1L,f
	goto	exit_isr
	
dec_pwm:
	movlw	D'0'
	xorwf	CCPR1L,W
	btfsc	STATUS,Z
	goto	exit_isr
	decf	CCPR1L,f
	goto	exit_isr

;end comands
;end interrupt_ISR

;--retrive context
exit_isr:
	swapf	status_temp,W
	movwf	STATUS
	swapf	w_temp,F
	swapf	w_temp,W
	
	retfie;return from interrupition

;init			
start:
	bank1
	movlw	H'F7'
	movwf	TRISB
	
	movlw	H'56'
	movwf	OPTION_REG ;timer0 prescaler 1:128
	
	movlw	H'FF'
	movwf	PR2
	
	bank0
	movlw	h'07'
	movwf	CMCON
	
	movlw	h'06'
	movwf	T2CON 
	
	movlw	H'E0'
	movwf	INTCON
	
	movlw	d'128'
	movwf	CCPR1L ;START 50%
	
	movlw	h'0c'
	movwf	CCP1CON
	
	goto	$
	
	end
	
;PWM
;cycle pwm = (PR2 + 1) * cycle_machine * prescaler of TMR2
;          =    256    *      1us      *      16
;          =  4,096ms