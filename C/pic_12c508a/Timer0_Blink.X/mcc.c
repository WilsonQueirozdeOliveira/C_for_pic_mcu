/* IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   mcc.c
 * Author: Wilson
 *
 *
 */

#include "mcc.h"

void CONFIG_mcc(void) {
    TRIS_LED = 0b11111110;
    OPTION = 0b00000111;
    timer = 0;
}

void blink_LED(void) {
    if ( (unsigned char) timer > 194) {
            LED = (unsigned char) !LED;
            timer = 0;
    }
    return;
}
