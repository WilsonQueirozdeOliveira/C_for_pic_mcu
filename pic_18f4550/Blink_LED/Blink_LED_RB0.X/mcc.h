/*
 * File:   mcc.h
 * Author: Wilson
 *
 * Created on 10 de Novembro de 2019, 09:46
 */

#ifndef __MCC_H /* XC_HEADER_TEMPLATE_H */
#define	__MCC_H

#include <xc.h> // include processor files - each processor file is guarded.  
#include <pic18f4550.h>

#define _XTAL_FREQ 48000000

#define TRIS_LED1  TRISBbits.TRISB0
#define LED1       LATBbits.LATB0 //PORTBbits.RB0

void CONFIG_mcc(void);
void delay_ms(char time);
void blink_LED_ms(char time);

#endif	/* XC_HEADER_TEMPLATE_H */

