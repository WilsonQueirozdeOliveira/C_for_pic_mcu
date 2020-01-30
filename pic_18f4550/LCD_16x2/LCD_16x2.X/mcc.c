/*
 * File:   mcc.c
 * Author: Wilson
 *
 * Created on 10 de Novembro de 2019, 09:46
 */

#include <xc.h>
#include "mcc.h"

void CONFIG_mcc(void) {

    /*config IO*/
    TRISD = 0X00;//LCD output
    ADCON0bits.ADON = 0; //OFF ADC converter
    ADCON0 = 0x00;
    ADCON1 = 0x0F;
    /*config IO*/

    /*config timer0*/
    T0CON = 0b10001000;
    INTCONbits.TMR0IE = 1;
    INTCONbits.PEIE = 1;
    INTCONbits.GIE = 1;
    /*config timer0*/
}

