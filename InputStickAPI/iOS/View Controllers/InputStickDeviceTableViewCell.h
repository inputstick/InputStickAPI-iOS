/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class InputStickPeripheralInfo;
@class InputStickDeviceData;

@interface InputStickDeviceTableViewCell : UITableViewCell

@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *identifierLabel;
@property(nonatomic, strong) UILabel *actionLabel;


- (void)configureWithInputStickPeripheralInfo:(InputStickPeripheralInfo *)peripheralInfo withDatabaseName:(NSString *)dbName;
- (void)configureWithInputStickDeviceData:(InputStickDeviceData *)deviceData withMostRecentlyUsedIdentifier:(NSString *)recentIdentifier;

@end
