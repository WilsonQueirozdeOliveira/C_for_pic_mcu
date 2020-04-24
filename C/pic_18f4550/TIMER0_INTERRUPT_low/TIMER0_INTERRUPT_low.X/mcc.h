/* IDE: MPLAB X v3.65 Compiler XC8(Free Mode) V1.45
 * File:   mcc.h
 * Author: Wilson Queiroz
 * Comments:
 * Revision history: 
 */

#include <xc.h>
#include <pic18f4550.h>

#define _XTAL_FREQ 48000000

#define LED  LATAbits.LA0
#define preset_TMR0 0xFFA0  // <TMR0H:TMR0L>

void CONFIG_mcc(void);

