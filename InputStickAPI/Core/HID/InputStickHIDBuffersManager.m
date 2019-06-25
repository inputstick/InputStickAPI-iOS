/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickHIDBuffersManager.h"
#import "InputStickHIDBuffersManager+Protected.h"
#import "InputStickManager.h"
#import "InputStickHIDTransactionBuffer.h"
#import "InputStickHIDTransactionBuffer+Protected.h"
#import "InputStickHIDBuffersState.h"
#import "InputStickPacket.h"
#import "InputStickTxPacket.h"

@interface InputStickHIDBuffersManager () {
    //HID report buffers
    InputStickHIDTransactionBuffer *_keyboardBuffer;
    InputStickHIDTransactionBuffer *_mouseBuffer;
    InputStickHIDTransactionBuffer *_consumerBuffer;
    
    NSUInteger _firmwareVersion;
}

@end


@implementation InputStickHIDBuffersManager

- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager {
    self = [super init];
    if (self) {
        _manager = inputStickManager;
        _keyboardBuffer = [[InputStickHIDTransactionBuffer alloc] initWithInputStickManager:inputStickManager withHIDInterface:InputStickHIDInterfaceKeyboard];
        _mouseBuffer = [[InputStickHIDTransactionBuffer alloc] initWithInputStickManager:inputStickManager withHIDInterface:InputStickHIDInterfaceMouse];
        _consumerBuffer = [[InputStickHIDTransactionBuffer alloc] initWithInputStickManager:inputStickManager withHIDInterface:InputStickHIDInterfaceConsumer];
    }
    return self;
}


#pragma mark - Protected (used internally by API)

- (void)updateFirmwareVersion:(NSUInteger)firmwareVersion {
    _firmwareVersion = firmwareVersion;
    //setup HID buffers depending on HID buffer size available in particular firmware version:
    if (firmwareVersion < 100) {
        [_keyboardBuffer setupWithCapacity:32 maxReportsPerPacket:32];
        [_mouseBuffer setupWithCapacity:32 maxReportsPerPacket:32];
        [_consumerBuffer setupWithCapacity:32 maxReportsPerPacket:32];
    } else {
        [_keyboardBuffer setupWithCapacity:128 maxReportsPerPacket:64];
        [_mouseBuffer setupWithCapacity:64 maxReportsPerPacket:32];
        [_consumerBuffer setupWithCapacity:64 maxReportsPerPacket:32];
    }
}

- (void)updateBuffersState:(InputStickHIDBuffersState *)buffersState {
    [_keyboardBuffer updateWithNumberOfReportsSentToHost:buffersState.keyboardReportsSentToHost isEmpty:buffersState.keyboardBufferEmpty];
    [_mouseBuffer updateWithNumberOfReportsSentToHost:buffersState.mouseReportsSentToHost isEmpty:buffersState.mouseBufferEmpty];
    [_consumerBuffer updateWithNumberOfReportsSentToHost:buffersState.consumerReportsSentToHost isEmpty:buffersState.consumerBufferEmpty];
}


#pragma mark - HID Buffers

- (BOOL)allBuffersEmpty {
    return ([self keyboardBufferEmpty] && [self mouseBufferEmpty] && [self consumerBufferEmpty]);
}

- (void)clearHIDBuffers {
    [_keyboardBuffer clear];
    [_mouseBuffer clear];
    [_consumerBuffer clear];
    if (_firmwareVersion >= 100) {
        if (( !_keyboardBuffer.bufferEmpty) || ( !_mouseBuffer.bufferEmpty) || ( !_consumerBuffer.bufferEmpty)) {
            InputStickTxPacket *packet =  [[InputStickTxPacket alloc] initWithCmd:CmdHIDClear withParam:0x07];
            [_manager sendPacket:packet];
        }
    }
}


#pragma mark - HID Keyboard Buffer

- (BOOL)keyboardBufferEmpty {
    return _keyboardBuffer.bufferEmpty;
}

- (BOOL)keyboardLocalBufferEmpty {
    return _keyboardBuffer.localBufferEmpty;
}

- (void)clearKeyboardBuffer {
    [_keyboardBuffer clear];
    if ((_firmwareVersion >= 100) && ( !_keyboardBuffer.bufferEmpty)) {
        InputStickTxPacket *packet =  [[InputStickTxPacket alloc] initWithCmd:CmdHIDClear withParam:0x01];
        [_manager sendPacket:packet];
    }
}

- (void)clearKeyboardLocalBuffer {
    [_keyboardBuffer clear];
}

- (void)addKeyboardHIDReport:(InputStickHIDReport *)report flush:(BOOL)flush {
    [_keyboardBuffer addHIDReport:report flush:flush];
}

- (void)addKeyboardHIDTransaction:(InputStickHIDTransaction *)transaction flush:(BOOL)flush {
    [_keyboardBuffer addHIDTransaction:transaction flush:flush];
}

- (void)flushKeyboardBuffer {
    [_keyboardBuffer flush];
}


#pragma mark - HID Mouse Buffer

- (BOOL)mouseBufferEmpty {
    return _mouseBuffer.bufferEmpty;
}

- (BOOL)mouseLocalBufferEmpty {
    return _mouseBuffer.localBufferEmpty;
}

- (void)clearMouseBuffer {
    [_mouseBuffer clear];
    if ((_firmwareVersion >= 100) && ( !_mouseBuffer.bufferEmpty)) {
        InputStickTxPacket *packet =  [[InputStickTxPacket alloc] initWithCmd:CmdHIDClear withParam:0x02];
        [_manager sendPacket:packet];
    }
}

- (void)clearMouseLocalBuffer {
    [_mouseBuffer clear];
}

- (void)addMouseHIDReport:(InputStickHIDReport *)report flush:(BOOL)flush {
    [_mouseBuffer addHIDReport:report flush:flush];
}

- (void)addMouseHIDTransaction:(InputStickHIDTransaction *)transaction flush:(BOOL)flush {
    [_mouseBuffer addHIDTransaction:transaction flush:flush];
}

- (void)flushMouseBuffer {
    [_mouseBuffer flush];
}


#pragma mark - HID Consumer Buffer

- (BOOL)consumerBufferEmpty {
    return _consumerBuffer.bufferEmpty;
}

- (BOOL)consumerLocalBufferEmpty {
    return _consumerBuffer.localBufferEmpty;
}

- (void)clearConsumerBuffer {
    [_consumerBuffer clear];
    if ((_firmwareVersion >= 100) && ( !_consumerBuffer.bufferEmpty)) {
        InputStickTxPacket *packet =  [[InputStickTxPacket alloc] initWithCmd:CmdHIDClear withParam:0x04];
        [_manager sendPacket:packet];
    }
}

- (void)clearConsumerLocalBuffer {
    [_consumerBuffer clear];
}

- (void)addConsumerHIDReport:(InputStickHIDReport *)report flush:(BOOL)flush {
    [_consumerBuffer addHIDReport:report flush:flush];
}

- (void)addConsumerHIDTransaction:(InputStickHIDTransaction *)transaction flush:(BOOL)flush {
    [_consumerBuffer addHIDTransaction:transaction flush:flush];
}

- (void)flushConsumerBuffer {
    [_consumerBuffer flush];
}

@end
