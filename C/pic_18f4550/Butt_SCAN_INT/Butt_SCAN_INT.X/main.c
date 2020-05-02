/*IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   main.c
 * Author: wilson
 *
 *
 */

#include "mcc.h"

__interrupt (high_priority) void high_ISR(void){
    if (INTCONbits.TMR0IE && INTCONbits.TMR0IF){
        INTCONbits.TMR0IF = 0;
        TMR0 = preset_TMR0;
        LED_LD9 = (unsigned char) !LED_LD9;
        LED_LD2 = 1;
        LED_LD3 = 1;
        LED_LD4 = 1;
    }
}
__interrupt (low_priority) void low_ISR(void){
    if (PIE1bits.TMR1IE && PIR1bits.TMR1IF){
        PIR1bits.TMR1IF = 0;
        TMR1 = preset_TMR1;
        if (!B1) {
            LED_LD2 = 0;
        }
        if (!B2) {
            LED_LD3 = 0;
        }
        if (!B3) {
            LED_LD4 = 0;
        }
    }
}
void main(void) {
    CONFIG_mcc();
    while(1) {
        
    }
    return;
}