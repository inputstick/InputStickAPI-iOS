/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>

@class InputStickManager;

@protocol InputStickHIDHandler <NSObject>

@property(nonatomic, readonly) InputStickManager *inputStickManager;

@end
