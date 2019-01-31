/*
 * InputStickDemo-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header HIDBuffersTableViewController.h
 @brief shows how to check state of InputStick HID buffers
 @discussion HID buffers store HID reports that represents HID interface actions (pressing keys, moving mouse etc.)
 If HID buffer is not empty, there are HID reports waiting to be retrieved by USB host (this means that InputStick is still typing text etc.)
 Clearing HID buffer allows to cancel actions queued for particular USB interface.
 "Remote HID buffer" refers to InputStick HID buffer (contains reports that were sent to InputStick and are waiting to be retrieved by USB host)
 "Local HID buffer" refers to app HID buffer (containts reports that will be sent to InputStick once there is available free space in Remote buffer)
 */

#import <UIKit/UIKit.h>
#import "NSNotificationCenter+InputStickStatusUpdate.h"

@class InputStickManager;

@interface HIDBuffersTableViewController : UITableViewController <InputStickStatusUpdateNotificationObserver>

@property(nonatomic, weak) InputStickManager *inputStickManager;

@end
