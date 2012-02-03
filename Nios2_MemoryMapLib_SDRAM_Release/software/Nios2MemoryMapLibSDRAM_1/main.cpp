/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include "system.h"
#include "io.h"
#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"
#include "unistd.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>

#include "src/Nios2Arduino.h"
#include "altera_avalon_pio_regs.h"

void analogWrite(int ch,unsigned char value);
void digitalWrite(int port,int value);

extern void arduinoMain(void);

int main()
{
	FILE* fp;
	int data;
	unsigned char ccc;

	analogWrite(0,0x12);
	analogWrite(1,0x34);

#if 0
	fp = fopen(UART_0_NAME,"w+");
	if(fp == NULL){
		printf("Uart open failed\n");
		while(1);
	}

	while(1){
#if 1
		int i;
		int len;
		unsigned char buff[32];

		len = fread(buff,1,1,fp);
		ccc++;
		analogWrite(0,ccc);

	    printf("Received : %d byte(s)\n",len);
	    for(i=0;i<len;i++){
	    	printf("%02X,",buff[i]);
	    }
#endif
	}
#endif
	arduinoMain();

	return 0;
}

void analogWrite(int ch,unsigned char value)
{
	IOWR(PWM_AVALON_0_BASE,ch == 0 ? 0 : 1,value);
}

void digitalWrite(int port,int value)
{
	static unsigned char outdata;
	unsigned char d;

	d = 1 << port;
	if(value){
		outdata |= d;
	} else {
		outdata &= ~d;
	}

	IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE,outdata);
}

