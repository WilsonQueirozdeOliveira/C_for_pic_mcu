/* IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   mcc.h
 * Author: Wilson
 *
 * 
 */

// PIC12C508A Configuration Bit Settings

// 'C' source line config statements

// CONFIG
#pragma config OSC = IntRC      // Oscillator selection bits (internal RC oscillator)
#pragma config WDT = OFF        // Watchdog timer enable bit (WDT disabled)
#pragma config CP = OFF         // Code protection bit (Code protection off)
#pragma config MCLRE = OFF      // MCLR enable bit (MCLR tied to VDD, (Internally))

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>

#define _XTAL_FREQ 4000000

#define TRIS_LED  TRIS
#define LED GP0
#define timer TMR0

void CONFIG_mcc(void);
void blink_LED(void);

