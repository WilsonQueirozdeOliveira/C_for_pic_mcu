/*IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   mcc.c
 * Author: wilson
 *
 * Created on 21 de Abril de 2020, 22:48
 */

#include <xc.h>
#include "mcc.h"

void CONFIG_mcc(void) {

    /*config IO*/
    TRIS_LED = 0;
    /*config IO*/

    /*config timer0*/                 
    T0CONbits.TMR0ON = 1;
    T0CONbits.T08BIT = 0;   //16bits
    T0CONbits.T0CS = 0;
    TMR0 = preset_TMR0;
    /*config timer0*/
    
   /*config_interrupt*/
    INTCONbits.GIE = 1;
    INTCONbits.TMR0IE = 1;
    INTCONbits.GIE_GIEH = 1;
    INTCONbits.PEIE_GIEL = 1; 
    INTCON2bits.TMR0IP = 0;
   /*config_interrupt*/
}