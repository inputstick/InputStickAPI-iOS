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
 @param identifier UUID of controlled InputStick or nil to use most recent device
 @param allowClick if TRUE user can connect/disconnect by pressing the button
 @return UIBarButtonItem
 @discussion if allowClick is TRUE: if not connected, button will initiate connection to InputStick, if connected it will disconnect from InputStick
 Provide identifier if you want to use this button to manage connection to particular InputStick or use nil to use most recently used InputStick
 */
- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager withIdentifier:(NSString *)identifier allowClick:(BOOL)allowClick;

/*!
 @brief UIBarButtonItem shows InputStick connection state and allows to easily manage connection
 @param inputStickManager instance of InputStickManager
 @param allowClick if TRUE user can connect/disconnect by pressing the button
 @return UIBarButtonItem
 @discussion if allowClick is TRUE: if not connected, button will initiate connection to most recently used InputStick, if connected it will disconnect from InputStick
 */
- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager allowClick:(BOOL)allowClick;

/*!
 @brief UIBarButtonItem shows InputStick connection state and allows to easily manage connection
 @param inputStickManager instance of InputStickManager
 @return UIBarButtonItem
 @discussion if not connected, button will initiate connection to most recently used InputStick, if connected it will disconnect from InputStick
 */
- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager;

@end
