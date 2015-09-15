//
// Created by Marcin Wieclawski on 12/09/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class CBPeripheral;

extern NSString *const InputStickDeviceName;

@interface ISDeviceSelectionTableViewCell : UITableViewCell
@property(nonatomic, strong) UILabel *identifierLabel;

- (void)configureWithPeripheral:(CBPeripheral *)peripheral;

@end
