/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSNotificationCenter+InputStickConnection.h"
#import "NSNotificationCenter+InputStickPeripheralScan.h"
#import "InputStickManagerDelegate.h"

@class InputStickManager;

@interface InputStickDeviceSelectionTableViewController : UITableViewController <InputStickManagerDelegate, InputStickConnectionNotificationObserver, InputStickPeripheralScanNotificationObserver>

@property(nonatomic, weak, readonly) InputStickManager *inputStickManager;

- (instancetype)initWithInputStickManager:(InputStickManager *)manager;

@end
