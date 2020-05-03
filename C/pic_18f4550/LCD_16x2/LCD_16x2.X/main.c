/* IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   main.c
 * Author: Wilson
 * 
 * For CPU Fatec
 */

#include "mcc.h"

__interrupt (low_priority) void low_ISR(void) {
    if (INTCONbits.T0IE && INTCONbits.TMR0IF) {
        INTCONbits.TMR0IF = 0;
        TMR0 = preset_TMR0;
        LED = 1;
        screen_1(); 
    }
}

void main(void) {
    /*Initializations systems*/
    CONFIG_mcc();
    CONFIG_lcd16x2();
    /*Variables*/
    while (1) {
        LED = 0;
    }
    return;
}