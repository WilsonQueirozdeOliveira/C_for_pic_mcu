/*
 * File:   lcd_16x2.h
 * Author: Wilson
 *
 * Created on 10 de Novembro de 2019, 09:46
 */
//define IO
#define RS_LCD  LATDbits.LATD1
#define E_LCD   LATDbits.LATD0
#define RW_LCD  LATDbits.LATD2

#define D7_LCD  LATDbits.LATD7
#define D6_LCD  LATDbits.LATD6
#define D5_LCD  LATDbits.LATD5
#define D4_LCD  LATDbits.LATD4

//initialization instructions
#define step_1 0x03
#define step_2 0x03
#define step_3 0x03
#define step_4 0x02

// Screns initialization
#define screen_refresh_time 5 // ms = screen_refresh_time*100
void screen_1(void);//screen refresh time(blink)

void CONFIG_lcd16x2(void);

void send_instruction_8bit(unsigned char data);
void send_instruction_4bit(unsigned char data);

void send_data_8bit(unsigned char data);
void send_data_char(unsigned char data);

void send_data_un_int(unsigned int data);
//void send_data_un_long_int(unsigned long int data);

void send_data_float(float data);

void start_instruction(void);

void start_data_8_bit(void);

void E_write(void);

///////////////////////////////////////////////////////

void send_str(unsigned char *data);
void escreve_inteiro(unsigned int x);