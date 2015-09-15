//
// Created by Marcin Wieclawski on 06/09/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class ISManager;
@class ISConnectionManager;
@protocol ISDeviceSelectionViewControllerProtocol;

@protocol ISManagerDelegate <NSObject>
- (void)inputStickManager:(ISManager *)inputStickManager presentViewController:(UIViewController *)deviceSelectionViewController;

@optional
- (UIViewController <ISDeviceSelectionViewControllerProtocol> *)selectionViewControllerForConnectionManager:(ISConnectionManager *)connectionManager withInputStickManager:(ISManager *)inputStickManager;

@end
