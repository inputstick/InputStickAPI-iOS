/*
 * InputStickDemo-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header PeripheralSelectionTableViewController.h
 @brief shows how to scan for nearby InputStick devices
 */

#import <UIKit/UIKit.h>
#import "NSNotificationCenter+InputStickConnection.h"
#import "NSNotificationCenter+InputStickPeripheralScan.h"

@class InputStickManager;

@interface PeripheralSelectionTableViewController : UITableViewController <InputStickConnectionNotificationObserver, InputStickPeripheralScanNotificationObserver>

@property(nonatomic, weak) InputStickManager *inputStickManager;

@end
