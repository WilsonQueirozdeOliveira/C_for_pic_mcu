/*IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   mcc.c
 * Author: Wilson Queiroz
 * 
 * 
 */

#include "mcc.h"

void CONFIG_mcc(void) {

    /*config IO*/
    TRIS_LED = 0;
    /*config IO*/

    /*config timer1*/
    T1CONbits.TMR1ON = 1;
    TMR1 = preset_TMR1;
    /*config timer1*/
    
   /*config_interrupt*/
    INTCONbits.GIE = 1;
    IPR1bits.TMR1IP = 0;
    PIE1bits.TMR1IE = 1;
    INTCONbits.GIE_GIEH = 1;
    INTCONbits.PEIE_GIEL = 1;    
   /*config_interrupt*/
}