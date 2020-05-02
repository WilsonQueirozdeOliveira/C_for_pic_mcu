/*IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   mcc.c
 * Author: wilson
 *
 * Created on 21 de Abril de 2020, 22:48
 */

#include "mcc.h"

void CONFIG_mcc(void) {

    /*config IO*/
    ADCON0 = 0x00;  // Desliga conversor ADC
    ADCON1 = 0xFF;  // Desliga conversor ADC
    TRIS_LEDs = 0x00;
    PORT_LEDs = 0xFF;
    /*config IO*/

    /*config timer0*/                 
    T0CONbits.TMR0ON = 1;
    T0CONbits.T08BIT = 0;   //16bits
    T0CONbits.T0CS = 0;
    T0CONbits.PSA = 0; // precaler ON
    T0CONbits.T0PS0 = 1;
    T0CONbits.T0PS1 = 0;
    T0CONbits.T0PS2 = 1;
    TMR0 = preset_TMR0;
    /*config timer0*/
   
    /*config timer1*/
    T1CONbits.TMR1ON = 1;
    TMR1 = preset_TMR1;
    /*config timer1*/
    
   /*config_interrupt*/
    RCONbits.IPEN = 1; 
    INTCONbits.GIE = 1;
    INTCONbits.GIE_GIEH = 1;
    INTCONbits.PEIE_GIEL = 1;
    INTCONbits.TMR0IE = 1;
    INTCON2bits.TMR0IP = 1; // TIMER0 high_priority
    PIE1bits.TMR1IE = 1;
    IPR1bits.TMR1IP = 0;    // TIMER1 low_priority
   /*config_interrupt*/
}