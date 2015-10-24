/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import "ISKeyboardHandler.h"
#import "ISKeyboardLedsState.h"
#import "ISManager.h"
#import "ISBluetoothBuffer.h"
#import "ISKeyboardReport.h"
#import "ISKeyboardKeyModel.h"
#import "ISKeyboardLayoutEnUs.h"


@interface ISKeyboardHandler ()
@property(nonatomic, strong) ISKeyboardLedsState *keyboardLedsState;
@end

@implementation ISKeyboardHandler

#pragma mark - Object lifecycle

- (instancetype)initWithInputStickManager:(ISManager *)inputStickManager {
    self = [super init];
    if (self) {
        _inputStickManager = inputStickManager;
        [[NSNotificationCenter defaultCenter] registerForDeviceStatusNotificationsWithObserver:self];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] unregisterFromDeviceStatusNotificationsWithObserver:self];
}

#pragma mark - Custom Report

- (void)sendCustomReportWithModifier:(Byte)modifier key:(Byte)key sendASAP:(BOOL)sendASAP {
    ISKeyboardReport *keyboardReport = [[ISKeyboardReport alloc] initWithShortReportBytes:(Byte[]) {modifier, key}];
    [self.inputStickManager.blueToothBuffer addKeyboardReportToQueue:keyboardReport
                                                            sendASAP:sendASAP];
}

#pragma mark - Press and release

- (void)pressKeyAndReleaseWithModifier:(Byte)modifier key:(Byte)key multiplier:(NSInteger)multiplier sendASAP:(BOOL)sendASAP {
    if (multiplier < 1) {
        multiplier = 1;
    }

    for (int i = 0; i < multiplier; i++) {
        [self sendCustomReportWithModifier:modifier key:0 sendASAP:false];
    }
    for (int i = 0; i < multiplier; i++) {
        [self sendCustomReportWithModifier:modifier key:key sendASAP:false];
    }
    for (int i = 0; i < multiplier - 1; i++) {
        [self sendCustomReportWithModifier:0x00 key:0x00 sendASAP:false];
    }
    [self sendCustomReportWithModifier:0x00 key:0x00 sendASAP:sendASAP];
}

#pragma mark - Type string

- (void)sendText:(NSString *)text {
    [self sendText:text withKeyboardLayout:nil multiplier:1];
}

- (void)sendText:(NSString *)text withKeyboardLayout:(id <ISKeyboardLayoutProtocol>)keyboardLayout {
    [self sendText:text withKeyboardLayout:keyboardLayout multiplier:1];
}

- (void)sendText:(NSString *)text withKeyboardLayout:(id <ISKeyboardLayoutProtocol>)keyboardLayout multiplier:(NSInteger)multiplier {
    if (text == nil) {
        return;
    }
    if (keyboardLayout == nil) {
        keyboardLayout = [[ISKeyboardLayoutEnUS alloc] init];
    }
    for (NSUInteger stringPosition = 0; stringPosition < text.length; ++stringPosition) {
        unichar singleCharacter = [text characterAtIndex:stringPosition];
        if (singleCharacter == '\n') {
            // Enter
            [self pressKeyAndReleaseWithModifier:0x00 key:0x28
                                      multiplier:multiplier sendASAP:false];
        } else if (singleCharacter == '\t') {
            // TAB
            [self pressKeyAndReleaseWithModifier:0x00 key:0x2B
                                      multiplier:multiplier sendASAP:false];
        } else {
            ISKeyboardKeyModel *keyboardKeyModel = [ISKeyboardKeyModel modelForCharacter:singleCharacter
                                                                      withKeyboardLayout:keyboardLayout];
            if (keyboardKeyModel.deadkey) {
                [self pressKeyAndReleaseWithModifier:0x00 key:keyboardKeyModel.deadkey
                                          multiplier:multiplier sendASAP:false];
            }
            [self pressKeyAndReleaseWithModifier:keyboardKeyModel.modifier key:keyboardKeyModel.key
                                      multiplier:multiplier sendASAP:false];
        }
    }
    [self.inputStickManager.blueToothBuffer sendKeyboard];
}

- (void)didUpdateKeyboardLedsNotification:(NSNotification *)notification {
    ISKeyboardLedsState *keyboardLedsState = notification.userInfo[@"keyboardLedsState"];
    self.keyboardLedsState = keyboardLedsState;
}

#pragma mark - Getters

- (BOOL)numLockOn {
    return self.keyboardLedsState.numLockOn;
}

- (BOOL)capsLockOn {
    return self.keyboardLedsState.capsLockOn;
}

- (BOOL)scrollLockOn {
    return self.keyboardLedsState.scrollLockOn;
}

@end
