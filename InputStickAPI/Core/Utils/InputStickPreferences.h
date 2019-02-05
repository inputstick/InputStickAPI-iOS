/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickPreferences.h
 @brief InputStick-related settings that can be managed the app via InputStickSettingsTableViewController
 */

#import <Foundation/Foundation.h>

@protocol InputStickKeyboardLayoutProtocol;


typedef NS_ENUM(NSUInteger, InputStickSettingsItem) {
    InputStickSettingsItemNone,
    InputStickSettingsItemAutoConnect,
    InputStickSettingsItemKeyboardLayout,
    InputStickSettingsItemTypingSpeed,
    InputStickSettingsItemMouseMode,
    InputStickSettingsItemTapToClick,
    InputStickSettingsItemTapInterval,
    InputStickSettingsItemMouseSensitivity,
    InputStickSettingsItemMousepadRatio,
    InputStickSettingsItemScrollSensitivity,
};


@interface InputStickPreferences : NSObject

//general preferences
/*! TRUE if auto-connect is enabled */
@property (nonatomic) BOOL autoConnect;

//keyboard
/*! keyboard layout used for typing NSStrings */
@property(nonatomic, strong) id <InputStickKeyboardLayoutProtocol> keyboardLayout;
/*! keyboard typing speed, see InputStickKeyboardHandler for details */
@property (nonatomic) NSUInteger typingSpeed;

//mousepad (mouse/touchscreen)
/*! TRUE if pressing mousepad area controls left mouse button */
@property (nonatomic) BOOL tapToClick;
/*! TRUE if mousepad area uses touch-screen interface (instead of mouse interface) */
@property (nonatomic) BOOL touchScreenMode;
/*! square of max distance (in px) between two mousepad clicks to be still considered as the same point (if mousepad area is used to control left mouse button). Example: 100 if max distance is 10 */
@property (nonatomic) NSUInteger touchProximity; //value is not stored in NSUserDefaults! will be calculated based on size of mousepad
/*! sensitivity of mousepad area */
@property (nonatomic) NSUInteger mouseSensitivity;
/*! sensitivity of mouse scroll wheel */
@property (nonatomic) NSUInteger scrollSensitivity;
/*! max time (in ms) between two mousepad click events to be considered as consecutiveevents (example 2 consecutive clicks pressed left mouse button) */
@property (nonatomic) NSUInteger tapInterval;
/*! aspect ratio of mousepad area */
@property (nonatomic) float mousepadRatio;


/*!
 @brief sets all properties to default values for all fields
 */
- (void)setDefaultValues;

/*!
 @brief loads all properties from NSUserDefaults
 */
- (void)loadFromUserDefaults;

/*!
 @brief saves all properties from NSUserDefaults
 */
- (void)saveToUserDefaults;

/*!
 @brief loads specified settings item from NSUserDefaults
 @param item InputStickSettingsItem
 */
- (void)loadValueForSettingsItem:(InputStickSettingsItem)item;

/*!
 @brief loads specified settings item to NSUserDefaults
 @param item InputStickSettingsItem
 @param synchronize if TRUE, NSUserDefaults synchronize will be called
 */
- (void)saveValueForSettingsItem:(InputStickSettingsItem)item synchronize:(BOOL)synchronize;

@end
