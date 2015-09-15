//
// Created by Marcin Wieclawski on 06/09/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "ISDeviceSelectionViewControllerProtocol.h"
#import "NSNotificationCenter+Connection.h"

@class ISConnectionManager;
@class MBProgressHUD;

@interface ISDeviceSelectionViewController : UITableViewController <ISDeviceSelectionViewControllerProtocol, ConnectionNotificationObserver>

@property(nonatomic, strong) MBProgressHUD *progressHUD;

- (instancetype)initWithConnectionManager:(ISConnectionManager *)connectionManager;

@end
