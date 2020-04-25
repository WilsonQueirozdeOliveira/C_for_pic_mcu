/* IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   mcc.c
 * Author: Wilson
 *
 * Created on 10 de Novembro de 2019, 09:46
 */

#include <xc.h>
#include "mcc.h"

void CONFIG_mcc(void) {
    TRIS_LED = 0;
}

void blink_LED(void) {
    __delay_ms(50);
    LED = (unsigned char) !LED;
    return;
}
