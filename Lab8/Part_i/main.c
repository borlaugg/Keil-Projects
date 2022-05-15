#include <at89c5131.h>
#include "lcd.h"				//Header file with LCD interfacing functions
#include "MorseCode.h"	//Header file for Morse Code 

sbit LED=P0^7;
sbit p01=P1^1;
sbit p02=P1^2;
sbit p03=P1^3;
sbit p04=P1^4;
sbit p05=P1^5;
int a=0;
/*
Port P0.7 is used for the audio signal output
*/	
//Main function

void main(void)
{
	P0=0x00;	
	//Call initialization functions
	lcd_init();
	// Read input nibble here
	P1=0x0f;
	// Insert Priority Logic
	// Inside each condition, call the functions from MorseCode.h. Fill functions in MorseCode.h
	// Write to LCD using function lcd_write_string() in side the condition as well
	if (P1==0x01)
	{
		lcd_write_string("       a        ");
		morse_a();
	}
	else if (P1==0x02)
	{
		lcd_write_string("       b        ");
		morse_b();
	}
	else if (P1==0x04)
	{
		lcd_write_string("       c        ");
		morse_c();
	}
	else if (P1==0x08)
	{
		lcd_write_string("       d        ");
		morse_d();
	}
	else
	{
		lcd_write_string("       e        ");
		morse_e();
	} 
	while (1)
	{
	}
	
	
}
