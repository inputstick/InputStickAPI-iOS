/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSNotificationCenter+InputStickConnection.h"
#import "InputStickManagerDelegate.h"

@class InputStickManager;

@interface InputStickDeviceSelectionViewController : UITableViewController <InputStickManagerDelegate, InputStickConnectionNotificationObserver>

@property(nonatomic, weak, readonly) InputStickManager *inputStickManager;

- (instancetype)initWithInputStickManager:(InputStickManager *)manager;

@end
