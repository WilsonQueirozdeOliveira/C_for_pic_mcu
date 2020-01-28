/*
 * File:   main.c
 * Author: Wilson
 *
 * Created on 10 de Novembro de 2019, 09:46
 */
#include <xc.h>
#include "mcc.h"

int main(void) {
    CONFIG_mcc();
    while (1) {
        blink_LED_ms(100);
    }
    return;
}