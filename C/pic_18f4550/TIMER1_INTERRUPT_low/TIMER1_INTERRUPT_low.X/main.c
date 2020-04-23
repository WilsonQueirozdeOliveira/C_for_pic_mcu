/*IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   main.c
 * Author: Wilson Queiroz
 * 
 * 
 */


#include <xc.h>
#include "mcc.h"

void interrupt low_priority   LowIsr(void){
    if (PIE1bits.TMR1IE && PIR1bits.TMR1IF){
        PIR1bits.TMR1IF = 0;
        TMR1 = 0xFF00;
        LED = !LED;
    }
}
void main(void) {
    CONFIG_mcc();
    while(1) {
        
    }
    return;
}
