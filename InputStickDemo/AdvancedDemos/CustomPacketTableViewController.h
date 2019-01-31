/*
 * InputStickDemo-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header CustomPacketTableViewController.h
 @brief shows how to send and receive custom packets
 */

#import <UIKit/UIKit.h>
#import "NSNotificationCenter+InputStickPacket.h"

@class InputStickManager;

@interface CustomPacketTableViewController : UITableViewController <InputStickPacketNotificationObserver>

@property(nonatomic, weak) InputStickManager *inputStickManager;

@end
