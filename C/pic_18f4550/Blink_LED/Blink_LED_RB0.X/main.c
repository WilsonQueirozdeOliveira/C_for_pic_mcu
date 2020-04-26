/* IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   main.c
 * Author: Wilson
 *
 * 
 */

#include "mcc.h"

void main(void) {
    CONFIG_mcc();
    while (1) {
        blink_LED();
    }
    return;
}