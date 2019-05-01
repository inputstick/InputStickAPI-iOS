/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>

@class InputStickKeyboardLEDsState;

@interface InputStickKeyboardHandler (Protected)

- (void)setKeyboardLEDsState:(InputStickKeyboardLEDsState *)ledsState;

@end

