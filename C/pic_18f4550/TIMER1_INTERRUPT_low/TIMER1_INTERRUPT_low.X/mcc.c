/*IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   mcc.c
 * Author: wilson
 *
 * 
 */


#include <xc.h>
#include "mcc.h"

void CONFIG_mcc(void) {

    /*config IO*/
    TRISA = 0x00;
    LED = 1;
    /*config IO*/

    /*config timer1*/
    T1CONbits.TMR1ON = 1;
    TMR1 = 0xFFF0;
    
    /*config timer1*/
    
   /*config_interrupt*/
    PIE1bits.TMR1IE = 1;
    RCONbits.IPEN=1;
    INTCONbits.GIE = 1;
    INTCONbits.PEIE = 1;
    INTCONbits.GIE_GIEH = 1;
    INTCONbits.PEIE_GIEL = 1;
    INTCON3bits.INT1IE = 1;
    INTCON3bits.INT1IF = 0;
    INTCON3bits.INT1IP = 0;
   /*config_interrupt*/
}
