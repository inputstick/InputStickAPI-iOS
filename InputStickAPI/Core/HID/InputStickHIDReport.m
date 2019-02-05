/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickHIDReport.h"
#import "InputStickPacket.h"


@interface InputStickHIDReport () {
    NSMutableData *_bytesData;
}

@end


@implementation InputStickHIDReport

#pragma mark - Object lifecycle

- (instancetype)initWithBytes:(Byte *)bytes withLength:(NSUInteger)length withCmd:(InputStickCmd)cmd {
    self = [super init];
    if (self) {
        [self setBytes:bytes withLength:length];
        _packetCmd = cmd;
    }
    return self;
}


#pragma mark - Class Initializers

+ (instancetype)keyboardReportWithBytes:(Byte[8])bytes {
    return [[self alloc] initWithBytes:bytes withLength:8 withCmd:CmdHIDDataKeyboard];
}

+ (instancetype)shortKeyboardReportWithBytes:(Byte[2])bytes {
    return [[self alloc] initWithBytes:bytes withLength:2 withCmd:CmdHIDDataKeyboardShort];
}

+ (instancetype)mouseReportWithBytes:(Byte[4])bytes {
    return [[self alloc] initWithBytes:bytes withLength:4 withCmd:CmdHIDDataMouse];
}

+ (instancetype)consumerReportWithBytes:(Byte[3])bytes {
    return [[self alloc] initWithBytes:bytes withLength:3 withCmd:CmdHIDDataConsumer];
}

+ (instancetype)gamepadReportWithBytes:(Byte[7])bytes {
    return [[self alloc] initWithBytes:bytes withLength:7 withCmd:CmdHIDDataGamepad];
}

+ (instancetype)touchScreenReportWithBytes:(Byte[6])bytes {
    return [[self alloc] initWithBytes:bytes withLength:6 withCmd:CmdHIDDataTouchScreen];
}


#pragma mark - Property Getter and Setter overrides

- (Byte *)bytes {
    return (Byte *)_bytesData.bytes;
}

- (void)setBytes:(Byte *)bytes withLength:(NSUInteger)length {
    _bytesData = [NSMutableData data];
    Byte *bytesTable = (Byte *)_bytesData.bytes;
    for (int i = 0; i < length; ++i) {
        bytesTable[i] = bytes[i];
    }
    _length = length;
}


@end
