/*
 * InputStickDemo-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header SoftKeyboardViewController.h
 @brief use system soft keyboard to type text via InputStick
 */

#import <UIKit/UIKit.h>

@class InputStickManager;

@interface SoftKeyboardViewController : UIViewController <UIKeyInput>

@property(nonatomic, weak) InputStickManager *inputStickManager;

@end
