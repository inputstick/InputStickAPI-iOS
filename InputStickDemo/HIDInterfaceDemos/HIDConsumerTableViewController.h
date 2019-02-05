/*
 * InputStickDemo-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header HIDConsumerTableViewController.h
 @brief InputStick HID Consume Control interface demo (multi-media buttons etc.)
 */

#import <UIKit/UIKit.h>

@class InputStickManager;

@interface HIDConsumerTableViewController : UITableViewController

@property(nonatomic, weak) InputStickManager *inputStickManager;

@end
