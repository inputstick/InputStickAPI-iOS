/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickHIDTransaction.h"
#import "InputStickHIDReport.h"
#import "InputStickPacket.h"


@implementation InputStickHIDTransaction

#pragma mark - Object lifecycle

- (instancetype)initWithCmd:(InputStickCmd)cmd {
    self = [super init];
    if (self) {
        _packetCmd = cmd;
        _reports = [NSMutableArray array];
    }
    return self;
}


#pragma mark - Class Initializers

+ (instancetype)shortKeyboardTransaction {
    //important: uses shortKeyboardReport format: 2B (key+modifier) instead of 8B (key1 + modifier + key2...)
    return [[self alloc] initWithCmd:CmdHIDDataKeyboardShort];
}

+ (instancetype)keyboardTransaction {
    //unless you want more than 1 non-modifier key pressed, use shortKeyboardTransaction!!!
    return [[self alloc] initWithCmd:CmdHIDDataKeyboard];
}

+ (instancetype)mouseTransaction {
    return [[self alloc] initWithCmd:CmdHIDDataMouse];
}

+ (instancetype)consumerTransaction {
    return [[self alloc] initWithCmd:CmdHIDDataConsumer];
}

+ (instancetype)gamepadTransaction {
    return [[self alloc] initWithCmd:CmdHIDDataGamepad];
}

+ (instancetype)touchScreenTransaction {
    return [[self alloc] initWithCmd:CmdHIDDataTouchScreen];
}



- (BOOL)hasNext {
    return ([_reports count] > 0);
}

- (NSUInteger)reportsCount {
    return [_reports count];;
}


- (void)addHIDReport:(InputStickHIDReport *)report {
    [self.reports addObject:report];
}

- (InputStickHIDReport *)pollReport {
    InputStickHIDReport *report = [_reports objectAtIndex:0];
    [_reports removeObjectAtIndex:0];
    return report;
}

- (InputStickHIDTransaction *)splitBy:(NSUInteger)count {
    InputStickHIDTransaction *transaction = [[InputStickHIDTransaction alloc] initWithCmd:_packetCmd];
    InputStickHIDReport *report;
    for (int i = 0; i < count; i++) {
        report = [self pollReport];
        [transaction addHIDReport:report];
    }
    return transaction;
}

@end
