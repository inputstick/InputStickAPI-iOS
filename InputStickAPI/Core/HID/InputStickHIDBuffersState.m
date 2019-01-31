/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickHIDBuffersState.h"
#import "InputStickRxPacket.h"


@implementation InputStickHIDBuffersState

- (instancetype)initWithInputStickRxPacket:(InputStickRxPacket *)rxPacket {
    self = [super init];
    if (self) {
        _keyboardReportsSentToHost = rxPacket.bytes[8];
        _mouseReportsSentToHost = rxPacket.bytes[9];
        _consumerReportsSentToHost = rxPacket.bytes[10];
        
        if (rxPacket.bytes[4] == 0) {
            _keyboardBufferEmpty = FALSE;
        } else {
            _keyboardBufferEmpty = TRUE;
        }
        if (rxPacket.bytes[6] == 0) {
            _mouseBufferEmpty = FALSE;
        } else {
            _mouseBufferEmpty = TRUE;
        }
        if (rxPacket.bytes[7] == 0) {
            _consumerBufferEmpty = FALSE;
        } else {
            _consumerBufferEmpty = TRUE;
        }
    }
    return self;
}

@end
