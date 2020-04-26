/* IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   main.c
 * Author: wilson
 *
 *
 */

#include "mcc.h"

__interrupt (low_priority) void low_ISR(void){
    if (INTCONbits.TMR0IE && INTCONbits.TMR0IF){
        INTCONbits.TMR0IF = 0;
        TMR0 = preset_TMR0;
        LED = (unsigned char) !LED;
    }
}
void main(void) {
    CONFIG_mcc();
    while(1) {
        
    }
    return;
}