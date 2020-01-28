/*
 * File:   mcc.c
 * Author: Wilson
 *
 * Created on 10 de Novembro de 2019, 09:46
 */

#include <xc.h>
#include "mcc.h"

void CONFIG_mcc(void) {
    ADCON0bits.ADON = 0; //OFF ADC converter
    TRIS_LED1 = 0;
    LED1 = 1;
}

void delay_ms(char time) {
    while (time) {
        __delay_ms(1);
        time--;
    }
}

void blink_LED_ms(char time) {
    delay_ms(time);
    LED1 = 1;
    delay_ms(time);
    LED1 = 0;
    return;
}
