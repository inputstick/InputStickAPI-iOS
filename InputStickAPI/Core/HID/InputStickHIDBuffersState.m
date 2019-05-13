/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickHIDBuffersState.h"
#import "InputStickRxPacket.h"


@implementation InputStickHIDBuffersState

- (instancetype)initWithInputStickRxPacket:(InputStickRxPacket *)rxPacket {
    self = [super init];
    if (self) {
        Byte *dataBytes = (Byte *)rxPacket.data.bytes;
        _keyboardReportsSentToHost = dataBytes[7];
        _mouseReportsSentToHost = dataBytes[8];
        _consumerReportsSentToHost = dataBytes[9];
        
        if (dataBytes[3] == 0) {
            _keyboardBufferEmpty = FALSE;
        } else {
            _keyboardBufferEmpty = TRUE;
        }
        if (dataBytes[5] == 0) {
            _mouseBufferEmpty = FALSE;
        } else {
            _mouseBufferEmpty = TRUE;
        }
        if (dataBytes[6] == 0) {
            _consumerBufferEmpty = FALSE;
        } else {
            _consumerBufferEmpty = TRUE;
        }
    }
    return self;
}

@end
