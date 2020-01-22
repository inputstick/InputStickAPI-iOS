/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickBarButtonItem.h
 @brief BarButtonItem that can be used to quickly connect/disconnect to InputStick (most recently used one or used defined device)
 */

#import <UIKit/UIKit.h>
#import "NSNotificationCenter+InputStickConnection.h"

@class InputStickManager;


@interface InputStickBarButtonItem : UIBarButtonItem <InputStickConnectionNotificationObserver>

/*!
 @brief UIBarButtonItem shows InputStick connection state and allows to easily manage connection
 @param inputStickManager instance of InputStickManager
 @return UIBarButtonItem
 @discussion if not connected, button will initiate connection to most recently used InputStick, if connected it will disconnect from InputStick
 */
- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager;


/*! UUID of controlled InputStick or nil to control the most recent device */
@property(nonatomic, copy) NSString *identifier;


@end
