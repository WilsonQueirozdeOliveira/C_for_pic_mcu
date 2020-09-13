/*
 * File:   mcc.c
 * Author: wilso
 *
 * Created on 12 de Setembro de 2020, 12:22
 */


#include "mcc.h"

void config_mcc ()
    {
    LED1_TRIS = 0;
    LED2_TRIS = 0;
    
    LED3_TRIS = 0;
    LED4_TRIS = 0;
    
    RELE_TRIS = 0;
    
    BOTAO_TRIS = 1;
    
    CMCON = 0x07; //Comparators Off
    
    //CLOCK
    PCONbits.OSCF = 0;
    
    // interrupt
    INTCONbits.GIE = 1;
    INTCONbits.T0IE = 1;
    
    // time 0
    OPTION_REG = 0b11010111;
    
    }
