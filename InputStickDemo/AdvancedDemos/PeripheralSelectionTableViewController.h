/*
 * InputStickDemo-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header PeripheralSelectionTableViewController.h
 @brief shows how to scan for nearby InputStick devices
 */

#import <UIKit/UIKit.h>
#import "NSNotificationCenter+InputStickConnection.h"

@class InputStickManager;

@interface PeripheralSelectionTableViewController : UITableViewController <InputStickConnectionNotificationObserver>

@property(nonatomic, weak) InputStickManager *inputStickManager;

@end
