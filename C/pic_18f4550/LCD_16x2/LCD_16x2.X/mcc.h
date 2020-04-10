/* IDE: MPLAB X v3.65/ and /XC8 C Compiler (Free Mode) V1.45
 * File:   mcc.h
 * Author: Wilson
 * 
 * Created on 10 de Novembro de 2019, 09:46
 */

#ifndef __MCC_H /* XC_HEADER_TEMPLATE_H */
#define	__MCC_H

#include <xc.h> // include processor files - each processor file is guarded.  
#include <pic18f4550.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "lcd_16x2.h"
#include "map_lcd_16x2.h"


#define _XTAL_FREQ 48000000

// TRISD is output for lcd
//#define TRIS_LED1  TRISBbits.TRISB0
//#define LED1       LATBbits.LATB0 //PORTBbits.RB0

void CONFIG_mcc(void);

#endif	/* XC_HEADER_TEMPLATE_H */

