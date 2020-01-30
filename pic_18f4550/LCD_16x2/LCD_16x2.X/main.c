/*
 * File:   main.c
 * Author: Wilson
 *
 * Created on 10 de Novembro de 2019, 09:46
 */

#include <xc.h>
#include "mcc.h"

void interrupt isr() {

    if (INTCONbits.T0IE && INTCONbits.TMR0IF) {
        INTCONbits.TMR0IF = 0;
        TMR0L = 0x1B;
        TMR0H = 0xD1;

        screen_1();
    }
}

int main(void) {

    //Initializations systems
    CONFIG_mcc();
    CONFIG_lcd16x2();

    //Variables

    while (1) {

    }
    return;
}