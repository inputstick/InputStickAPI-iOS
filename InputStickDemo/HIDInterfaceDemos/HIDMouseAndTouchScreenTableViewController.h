/*
 * InputStickDemo-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header HIDMouseAndTouchScreenTableViewController.h
 @brief InputStick HID Mouse interface and Touch-screen interface demo.
 @discussion mouse uses relative screen coordinates while touch-screen uses absolute screen coordinates
 */

#import <UIKit/UIKit.h>

@class InputStickManager;

@interface HIDMouseAndTouchScreenTableViewController : UITableViewController

@property(nonatomic, weak) InputStickManager *inputStickManager;

@end
