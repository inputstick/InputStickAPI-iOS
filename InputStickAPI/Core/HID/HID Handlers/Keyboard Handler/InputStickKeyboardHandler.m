/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickKeyboardHandler.h"
#import "InputStickKeyboardHandler+Protected.h"
#import "InputStickManager.h"
#import "InputStickHIDReport.h"
#import "InputStickHIDTransactionBuffer.h"
#import "InputStickHIDTransaction.h"
#import "InputStickKeyboardLEDsState.h"
#import "InputStickKeyboardKeyModel.h"
#import "InputStickKeyboardLayoutEnUS.h"


@implementation InputStickKeyboardHandler

@synthesize inputStickManager = _inputStickManager;


#pragma mark - Object lifecycle

- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager {
    self = [super init];
    if (self) {
        _inputStickManager = inputStickManager;
        _keyboardLEDsState = [[InputStickKeyboardLEDsState alloc] init];
    }
    return self;
}


#pragma mark - Custom Report

- (InputStickHIDReport *)customReportWithModifiers:(Byte)modifiers key:(Byte)key {
    InputStickHIDReport *report = [InputStickHIDReport shortKeyboardReportWithBytes:(Byte[]) {modifiers, key}];
    return report;
}

- (void)sendCustomReportWithModifiers:(Byte)modifiers key:(Byte)key sendASAP:(BOOL)sendASAP {
    InputStickHIDReport *report = [self customReportWithModifiers:modifiers key:key];
    [self.inputStickManager addKeyboardHIDReport:report sendASAP:sendASAP];   
}

- (void)sendCustomReportWithModifiers:(Byte)modifiers key:(Byte)key multiplier:(NSUInteger)multiplier sendASAP:(BOOL)sendASAP {
    if (multiplier <= 1) {
        [self sendCustomReportWithModifiers:modifiers key:key sendASAP:sendASAP]; //send at last one report even for fastest typing speed (0 multiplier)
    } else {
        InputStickHIDTransaction *transaction = [InputStickHIDTransaction shortKeyboardTransaction];
        for (NSUInteger i = 0; i < multiplier - 1; i++) {
            [transaction addHIDReport:[self customReportWithModifiers:modifiers key:key]];
        }
        [self.inputStickManager addKeyboardHIDTransaction:transaction sendASAP:sendASAP];
    }
}


#pragma mark - Press and release keys

- (void)pressAndReleaseModifiers:(Byte)modifiers withKey:(Byte)key {
    [self pressAndReleaseModifiers:modifiers withKey:key sendASAP:true];
}

- (void)pressAndReleaseModifiers:(Byte)modifiers withKey:(Byte)key sendASAP:(BOOL)sendASAP {
    [self pressAndReleaseModifiers:modifiers withKey:key typingSpeed:1 sendASAP:sendASAP];
}

- (void)pressAndReleaseModifiers:(Byte)modifiers withKey:(Byte)key typingSpeed:(NSUInteger)speed sendASAP:(BOOL)sendASAP {
    InputStickHIDTransaction *transaction = [InputStickHIDTransaction shortKeyboardTransaction];
    if (speed == 0) {
        [transaction addHIDReport:[self customReportWithModifiers:modifiers key:key]];
        [transaction addHIDReport:[self customReportWithModifiers:0x00 key:0x00]];
    } else {
        if (modifiers != 0) {
            for (int i = 0; i < speed; i++) {
                [transaction addHIDReport:[self customReportWithModifiers:modifiers key:0x00]];
            }
        }
        for (int i = 0; i < speed; i++) {
            [transaction addHIDReport:[self customReportWithModifiers:modifiers key:key]];
        }
        for (int i = 0; i < speed; i++) {
            [transaction addHIDReport:[self customReportWithModifiers:0x00 key:0x00]];
        }
    }
    [self.inputStickManager addKeyboardHIDTransaction:transaction sendASAP:sendASAP];
}


#pragma mark - Type text

- (void)typeText:(NSString *)text {
    [self typeText:text withKeyboardLayout:nil];
}

- (void)typeText:(NSString *)text withKeyboardLayout:(id <InputStickKeyboardLayoutProtocol>)keyboardLayout {
    [self typeText:text withKeyboardLayout:keyboardLayout typingSpeed:1];
}

- (void)typeText:(NSString *)text withKeyboardLayout:(id <InputStickKeyboardLayoutProtocol>)keyboardLayout typingSpeed:(NSUInteger)speed {
    [self typeText:text withKeyboardLayout:keyboardLayout modifiers:0 typingSpeed:speed sendASAP:true];
}

- (void)typeText:(NSString *)text withKeyboardLayout:(id <InputStickKeyboardLayoutProtocol>)keyboardLayout modifiers:(Byte)modifiers typingSpeed:(NSUInteger)speed sendASAP:(BOOL)sendASAP {
    if (text == nil) {
        return;
    }
    if (keyboardLayout == nil) {
        keyboardLayout = [[InputStickKeyboardLayoutEnUS alloc] init];
    }
    Byte prevKey = 0;
    for (NSUInteger stringPosition = 0; stringPosition < text.length; ++stringPosition) {
        unichar singleCharacter = [text characterAtIndex:stringPosition];
        
        InputStickKeyboardKeyModel *keyboardKeyModel = [InputStickKeyboardKeyModel modelForCharacter:singleCharacter withKeyboardLayout:keyboardLayout];
        Byte mod;
        if (keyboardKeyModel.deadkey) {
            mod = (keyboardKeyModel.deadkeyModifiers | modifiers);
            if (speed == 0) {
                InputStickHIDTransaction *transaction = [InputStickHIDTransaction shortKeyboardTransaction];
                [transaction addHIDReport:[self customReportWithModifiers:modifiers key:0x00]]; //always release before deadkey!
                [transaction addHIDReport:[self customReportWithModifiers:mod key:keyboardKeyModel.deadkey]];
                [transaction addHIDReport:[self customReportWithModifiers:modifiers key:0x00]]; //always release after deadkey!
                [self.inputStickManager addKeyboardHIDTransaction:transaction sendASAP:false];
            } else {
                [self pressAndReleaseModifiers:mod withKey:keyboardKeyModel.deadkey typingSpeed:speed sendASAP:false];
            }
        }
        mod = (keyboardKeyModel.modifiers | modifiers);
        if (speed == 0) {
            //special case: "Aa", "aa" requires releasing key!
            if (keyboardKeyModel.key == prevKey) {
                [self sendCustomReportWithModifiers:0 key:0 sendASAP:false];
            }
            prevKey = keyboardKeyModel.key;
            
            [self sendCustomReportWithModifiers:mod key:keyboardKeyModel.key sendASAP:false];
        } else {
            [self pressAndReleaseModifiers:mod withKey:keyboardKeyModel.key typingSpeed:speed sendASAP:false];
        }
    }
    
    if (speed == 0) {
        [self sendCustomReportWithModifiers:modifiers key:0 sendASAP:false]; 
    }
    
    if (sendASAP) {
        [self.inputStickManager flushKeyboardBuffer];
    }
}


#pragma mark - Getters

- (BOOL)numLockOn {
    return _keyboardLEDsState.numLockOn;
}

- (BOOL)capsLockOn {
    return _keyboardLEDsState.capsLockOn;
}

- (BOOL)scrollLockOn {
    return _keyboardLEDsState.scrollLockOn;
}


#pragma mark - Protected

- (void)setKeyboardLEDsState:(InputStickKeyboardLEDsState *)ledsState {
    _keyboardLEDsState = ledsState;
}

@end
