/*
 * InputStickDemo-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header HIDKeyboardTableViewController.h
 @brief InputStick HID Keyboard interface demo
 */

#import <UIKit/UIKit.h>
#import "NSNotificationCenter+InputStickStatusUpdate.h"

@class InputStickManager;

@interface HIDKeyboardTableViewController : UITableViewController <InputStickStatusUpdateNotificationObserver>

@property(nonatomic, weak) InputStickManager *inputStickManager;

@end
