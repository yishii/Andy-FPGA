//
// AndyShield
//
//
//

#include <stdio.h>
#include <stdlib.h>
#include "Nios2Arduino.h"
#include "MemoryMapLib/MemoryMapLib.h"
#include "MemoryMapLib/Nios2SerialStream.h"

MemoryMap mMemoryMap;

SerialStream mSerialStream;
void jobMotor(unsigned char RWOP, unsigned char addr, unsigned char* value);
void controlMotorPower(int motortype, int motoraction, int power);
#define MOTORTYPE_MOTOR_R    0
#define MOTORTYPE_MOTOR_L    1

void setup() {
	printf("%s Entered\n",__FUNCTION__);
	mSerialStream.setInterface(NULL);
	mMemoryMap.setStreamInterface(&mSerialStream);

	mMemoryMap.registerMapAddressJob(0x1b, OPERATION_WRITE, &jobMotor);
	mMemoryMap.registerMapAddressJob(0x1c, OPERATION_WRITE, &jobMotor);
}

void loop() {
	mMemoryMap.poll();
}

void jobMotor(unsigned char RWOP, unsigned char addr, unsigned char* value) {
	struct S_MOTOR_BIT_FIELD {
		unsigned char power :6;
		unsigned char cont :2;
	};

	//printf("%s Entered\n", __FUNCTION__);

	if (RWOP & OPERATION_WRITE) {
		unsigned char cont, power;
		cont = ((struct S_MOTOR_BIT_FIELD*) value)->cont;
		power = ((struct S_MOTOR_BIT_FIELD*) value)->power << 2;
		//printf("%s Line:%d\n", __FUNCTION__, __LINE__);
		controlMotorPower(addr == MEMMAP_ADR_MMPK_Motor_0 ? MOTORTYPE_MOTOR_R
				: MOTORTYPE_MOTOR_L, cont, power);
	}
}

void controlMotorPower(int motortype, int motoraction, int power) {
	int pinno_1;
	int pinno_2;
	int pinno_pwm;

	const unsigned char cont[4][2] = { { LOW, LOW }, // STOP
			{ LOW, HIGH }, // REVERSE
			{ HIGH, LOW }, // FORWARD
			{ HIGH, HIGH } // BRAKE
	};

	//printf("%s Line:%d\n", __FUNCTION__, __LINE__);
	if (motortype == MOTORTYPE_MOTOR_R) {
		pinno_1 = 0;
		pinno_2 = 1;
		pinno_pwm = 0;
	} else {
		pinno_1 = 2;
		pinno_2 = 3;
		pinno_pwm = 1;
	}
	digitalWrite(pinno_1,cont[motoraction][0]);
	digitalWrite(pinno_2,cont[motoraction][1]);
	analogWrite(pinno_pwm, power);
}

