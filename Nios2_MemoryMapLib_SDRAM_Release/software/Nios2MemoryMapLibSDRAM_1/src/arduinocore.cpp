//
// Arduino Modoki Core Module
//
// Author : Yasuhiro ISHII,2012
//
#include "Nios2Arduino.h"
#include <unistd.h>
#include <sys/alt_alarm.h>


void arduinoMain(void)
{
	static int loop_counter = 0;
	setup();
	while(1){
		loop();
		loop_counter++;
	}
}

int millis(void)
{
    return (alt_nticks());
}

void delayMs(int x)
{
	usleep( x * 1000 );
}

