//
// Created by Marcin Wieclawski on 12/09/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class CBPeripheral;
@class ISConnectionManager;

@protocol ISDeviceSelectionViewControllerProtocol <NSObject>
@property(nonatomic, weak) ISConnectionManager *connectionManager;
@property(nonatomic, strong) CBPeripheral *selectedPeripheral;

@end
