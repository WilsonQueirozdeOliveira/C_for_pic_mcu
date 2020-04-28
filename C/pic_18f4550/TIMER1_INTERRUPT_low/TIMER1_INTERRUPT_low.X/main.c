/*IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   main.c
 * Author: Wilson Queiroz
 * 
 * 
 */

#include "mcc.h"

__interrupt (low_priority) void low_ISR(void){
    if (PIE1bits.TMR1IE && PIR1bits.TMR1IF){
        PIR1bits.TMR1IF = 0;
        TMR1 = preset_TMR1;
        LED = (unsigned char) !LED;
    }
}
void main(void) {
    CONFIG_mcc();
    while(1) {
        
    }
    return;
}