#ifndef __NIOS2ARDUINO_H__
#define __NIOS2ARDUINO_H__

void setup(void);
void loop(void);
int millis(void);
void delayMs(int );
void analogWrite(int ch,unsigned char value);
void digitalWrite(int port,int value);

void arduinoMain(void);

#define LOW	0
#define HIGH 1

#endif
