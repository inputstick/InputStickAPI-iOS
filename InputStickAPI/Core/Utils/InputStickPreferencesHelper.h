/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickPreferencesHelper.h
 @brief Helper class for InputStickSettingsTableViewController and InputStickMenuTableViewController
 */

#import <Foundation/Foundation.h>

extern NSString *const InputStickSettingsEnabledValue;
extern NSString *const InputStickSettingsDisabledValue;

extern NSString *const InputStickSettingsMouseModeValue;
extern NSString *const InputStickSettingsTouchScreenModeValue;

extern NSString *const InputStickSettingsInitKey;

extern NSString *const InputStickSettingsAutoConnectKey;

extern NSString *const InputStickSettingsKeyboardLayoutKey;
extern NSString *const InputStickSettingsTypingSpeedKey;

extern NSString *const InputStickSettingsMouseModeKey;
extern NSString *const InputStickSettingsTapToClickKey;
extern NSString *const InputStickSettingsTapIntervalKey;
extern NSString *const InputStickSettingsMouseSensitivityKey;
extern NSString *const InputStickSettingsScrollSensitivityKey;
extern NSString *const InputStickSettingsMousepadRatioKey;


typedef NS_ENUM(NSUInteger, InputStickSettingsItem);


@interface InputStickPreferencesHelper : NSObject

/*!
 @brief human-readable name for settings item
 @param item InputStickSettingsItem
 @return human-readable name for item
 @discussion example: InputStickSettings returns "Mousepad mode"
 */
+ (NSString *)nameForItem:(InputStickSettingsItem)item;

/*!
 @brief NSUserDefaults key for settings item
 @param item InputStickSettingsItem
 @return NSUserDefaults key for item
 @discussion example: InputStickSettings returns "InputStickSettings_MouseMode" (InputStickSettingsMouseModeKey)
 */
+ (NSString *)keyForItem:(InputStickSettingsItem)item;

/*!
 @brief value for settings item loaded from NSUserDefaults
 @param item InputStickSettingsItem
 @return value for item
 @discussion example: InputStickSettings returns "mouse" or "touch" depending on currently stored value
 */
+ (NSString *)valueForItem:(InputStickSettingsItem)item;

/*!
 @brief human-readable value value for settings item loaded from NSUserDefaults
 @param item InputStickSettingsItem
 @return human-readable value for item
 @discussion example: InputStickSettings returns "Mouse" or "Touch-screen" depending on currently stored value
 */
+ (NSString *)displayValueForItem:(InputStickSettingsItem)item;

/*!
 @brief all values for settings item in human-readable form
 @param item InputStickSettingsItem
 @return human-readable values for item
 @discussion contains list of all possible values in human-readable form, example: InputStickSettings returns "Mouse", "Touch-screen"
 */
+ (NSArray<NSString *> *)displayValuesForItem:(InputStickSettingsItem)item;

/*!
 @brief all values for settings item that can be stored in NSUserDefaults
 @param item InputStickSettingsItem
 @return values for item
 @discussion contains list of all possible values that can be stored in NSUserDefaults, example: InputStickSettings returns "mouse", "touch"
 */
+ (NSArray<NSString *> *)storeValuesForItem:(InputStickSettingsItem)item;

@end
