///Programa : PIC16F628A
//Autor : JocsMister
 
#include "mcc.h"

__interrupt  void ISR(void){
    if (INTCONbits.T0IE && INTCONbits.T0IF){
        INTCONbits.T0IF = 0;
        TMR0 = preset_TMR0;
        LED1 = (unsigned char) !LED1;
        LED2 = (unsigned char) !LED2;
        
        unsigned char segundo;
        unsigned char minuto;
        unsigned char hora;
        
        segundo++;
        
        if ((BOTAO == 0)&&(segundo >=3)){
            segundo = 0;
            minuto = 0;
            hora = 0;
            RELE = (unsigned char) !RELE;
            LED4 =  (unsigned char) RELE;
            LED3 =  (unsigned char) !RELE;
        }
        if (segundo >=60){
            minuto++;
            segundo = 0;
        }
        if (minuto>=60){
            hora++;
            minuto = 0;
            RELE = (unsigned char) !RELE;
            LED4 =  (unsigned char) RELE;
            LED3 =  (unsigned char) !RELE;
        }
        if (hora >=60){
            hora = 0;
        }
    }
}
    
void main (void){
    config_mcc();
    while(1){
//        if (BOTAO == 0){
//            LED3 = 1;
//            LED4 = 0;
//
//            RELE=0;
//
//            __delay_ms(3000); 
//
//            LED3 = 0;
//            LED4 = 1;
//
//            RELE = 1;
//            
//            __delay_ms(3000);
//        }
    }
}