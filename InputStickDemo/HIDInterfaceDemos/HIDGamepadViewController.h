/*
 * InputStickDemo-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header HIDGamepadViewController.h
 @brief InputStick HID Gamepad interface demo. Uses accelerometer to control gamepad X,Y axis
 */

#import <UIKit/UIKit.h>

@class InputStickManager;

@interface HIDGamepadViewController : UIViewController

@property(nonatomic, weak) InputStickManager *inputStickManager;

@end
