/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import <UIKit/UIKit.h>
#import "NSNotificationCenter+InputStickConnection.h"

@class InputStickManager;

@interface InputStickDeviceManagementTableViewController : UITableViewController

- (instancetype)initWithInputStickManager:(InputStickManager *)manager;

@end
