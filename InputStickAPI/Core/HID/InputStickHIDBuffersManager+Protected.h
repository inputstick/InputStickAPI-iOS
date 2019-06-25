/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @brief contains methods/fields used internally by InputStick API
 */

#import <Foundation/Foundation.h>
#import "InputStickHIDBuffersManager.h"

@interface InputStickHIDBuffersManager (Protected)


- (void)updateFirmwareVersion:(NSUInteger)firmwareVersion;

- (void)updateBuffersState:(InputStickHIDBuffersState *)buffersState;


@end
