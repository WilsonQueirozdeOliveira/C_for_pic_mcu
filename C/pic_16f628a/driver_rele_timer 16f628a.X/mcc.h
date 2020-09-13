#ifndef MCC_H
#define	MCC_H

#include <xc.h>

//Define clock Delay
#define _XTAL_FREQ 48000
//configuração FUSES
#pragma config FOSC = INTOSCIO  // Oscillator Selection bits (INTOSC oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF       // Power-up Timer Enable bit (PWRT enabled)
#pragma config MCLRE = OFF      // RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is digital input, MCLR internally tied to VDD)
#pragma config BOREN = OFF      // Brown-out Detect Enable bit (BOD Enabled)
#pragma config LVP = OFF        // Low-Voltage Programming Enable bit (RB4/PGM pin has digital I/O function, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EE Memory Code Protection bit (Data memory code protection off)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)


#define LED1_TRIS  TRISAbits.TRISA0
#define LED2_TRIS  TRISAbits.TRISA1

#define LED3_TRIS  TRISBbits.TRISB5
#define LED4_TRIS  TRISBbits.TRISB4

#define RELE_TRIS  TRISBbits.TRISB3

#define BOTAO_TRIS  TRISAbits.TRISA2

#define LED1       PORTAbits.RA0
#define LED2       PORTAbits.RA1

#define LED3       PORTBbits.RB5
#define LED4       PORTBbits.RB4

#define RELE       PORTBbits.RB3

#define BOTAO   PORTAbits.RA2

#define preset_TMR0 200 //200

void config_mcc (void);

#endif	

