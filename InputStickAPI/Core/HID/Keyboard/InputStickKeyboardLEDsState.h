/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickKeyboardLEDsState.h
 @brief represents current state of keyboard LEDs set by USB host
 */

#import <Foundation/Foundation.h>

@class InputStickRxPacket;

@interface InputStickKeyboardLEDsState : NSObject

@property(nonatomic, readonly) Byte rawValue;
@property(nonatomic, readonly) BOOL numLockOn;
@property(nonatomic, readonly) BOOL capsLockOn;
@property(nonatomic, readonly) BOOL scrollLockOn;

- (instancetype)initWithInputStickRxPacket:(InputStickRxPacket *)rxPacket;

@end
