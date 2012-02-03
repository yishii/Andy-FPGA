/*
  Serial Stream class
  Author : Yasuhiro ISHII
*/

#ifndef _SERIALSTREAM_H_
#define _SERIALSTREAM_H_

//#include "testlibs.h"
#include "CommunicationStream.h"
#include "BufferedStream.h"
//#include "WProgram.h"

class SerialStream : public CommunicationStream
{
private:
    int mConnected;
    int* mHardwareSerial;
    FILE* fp;
    BufferedStream* mBufferedStream;
    unsigned char* mStreamBuffer;

public:
    SerialStream(void);
    int isConnected(void);
    unsigned char read(void);
    int write(unsigned char* ,int );
    void setInterface(int* );
    int available(void);
    void flush(void);
};

#endif /* _SERIALSTREAM_H_ */
