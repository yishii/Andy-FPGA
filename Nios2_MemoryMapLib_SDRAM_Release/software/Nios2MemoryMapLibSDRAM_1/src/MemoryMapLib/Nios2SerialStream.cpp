/*
  Serial Stream class
  Author : Yasuhiro ISHII
*/
#include <stdio.h>
#include "system.h"
#include "io.h"
#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"
#include "unistd.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>

//#include "testlibs.h"

#include "CommunicationStream.h"
#include "Nios2SerialStream.h"
#include "BufferedStream.h"

SerialStream::SerialStream(void)
{
    mConnected = false;
    mStreamBuffer = new unsigned char [2560];
    mBufferedStream = new BufferedStream((void*)mStreamBuffer,2560);
}

int SerialStream::isConnected(void)
{
    return(mConnected);
}

int SerialStream::available(void)
{
	int i;
	int len;
	unsigned char buff[128];

	if(mConnected == false){
		printf("connection error\n");
	} else {
		len = fread(buff,1,1,fp);

		if(len > 0){
			for(i=0;i<len;i++){
				if(mBufferedStream->push(buff[i]) == 0){
					printf("OVF\n");
				}
				//printf("Ch:%02Xh size=%d\n",buff[i],mBufferedStream->size());
			}
		}
	}
	return(mBufferedStream->size());
}

unsigned char SerialStream::read(void)
{
    unsigned char ret = 0;

    if(mBufferedStream->size() >= 1){
    	mBufferedStream->pop(ret);
    }

    return(ret);
}

int SerialStream::write(unsigned char* buff,int len)
{
	fwrite(buff,len,1,fp);
}

void SerialStream::flush(void)
{
    mBufferedStream->flush();
}

void SerialStream::setInterface(int* s)
{
	fp = fopen(UART_0_NAME,"w+");
	if(fp != NULL){
		mConnected = true;
	}
}
