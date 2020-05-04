/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickPreferencesHelper.h"
#import "InputStickPreferences.h"
#import "InputStickKeyboardLayoutUtils.h"
#import "InputStickConst.h"

NSString *const InputStickSettingsEnabledValue = @"enabled";
NSString *const InputStickSettingsDisabledValue = @"disabled";

NSString *const InputStickSettingsMouseModeValue = @"mouse";
NSString *const InputStickSettingsTouchScreenModeValue = @"touch";

NSString *const InputStickSettingsInitKey = @"InputStickSettings_InitV1";

NSString *const InputStickSettingsAutoConnectKey = @"InputStickSettings_AutoConnect";

NSString *const InputStickSettingsKeyboardLayoutKey = @"InputStickSettings_KeyboardLayout";
NSString *const InputStickSettingsTypingSpeedKey = @"InputStickSettings_TypingSpeed";

NSString *const InputStickSettingsMouseModeKey = @"InputStickSettings_MouseMode";
NSString *const InputStickSettingsTapToClickKey = @"InputStickSettings_TapToClick";
NSString *const InputStickSettingsTapIntervalKey = @"InputStickSettings_TapInterval";
NSString *const InputStickSettingsMouseSensitivityKey = @"InputStickSettings_MouseSensitivity";
NSString *const InputStickSettingsScrollSensitivityKey = @"InputStickSettings_ScrollSensitivity";
NSString *const InputStickSettingsMousepadRatioKey = @"InputStickSettings_MousepadRatio";


@implementation InputStickPreferencesHelper

+ (NSString *)nameForItem:(InputStickSettingsItem)item {
    switch(item) {
        case InputStickSettingsItemAutoConnect:
            return NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TITLE_AUTO_CONNECT", InputStickStringTable, nil);
            
        case InputStickSettingsItemKeyboardLayout:
            return NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TITLE_KEYBOARD_LAYOUT", InputStickStringTable, nil);
        case InputStickSettingsItemTypingSpeed:
            return NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TITLE_TYPING_SPEED", InputStickStringTable, nil);
            
        case InputStickSettingsItemMouseMode:
            return NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TITLE_MOUSEPAD_MODE", InputStickStringTable, nil);
        case InputStickSettingsItemTapToClick:
            return NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TITLE_TAP_TO_CLICK", InputStickStringTable, nil);
        case InputStickSettingsItemTapInterval:
            return NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TITLE_TAP_INTERVAL", InputStickStringTable, nil);
        case InputStickSettingsItemMouseSensitivity:
            return NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TITLE_MOUSEPAD_SENSITIVITY", InputStickStringTable, nil);
        case InputStickSettingsItemMousepadRatio:
            return NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TITLE_MOUSEPAD_RATIO", InputStickStringTable, nil);
        case InputStickSettingsItemScrollSensitivity:
            return NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_TITLE_SCROLL_SENSITIVITY", InputStickStringTable, nil);
            
        default:
            return NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_INTERNAL", InputStickStringTable, nil);
    }
}

+ (NSString *)keyForItem:(InputStickSettingsItem)item {
    switch(item) {
        case InputStickSettingsItemAutoConnect:
            return InputStickSettingsAutoConnectKey;
            
        case InputStickSettingsItemKeyboardLayout:
            return InputStickSettingsKeyboardLayoutKey;
        case InputStickSettingsItemTypingSpeed:
            return InputStickSettingsTypingSpeedKey;
            
        case InputStickSettingsItemMouseMode:
            return InputStickSettingsMouseModeKey;
        case InputStickSettingsItemTapToClick:
            return InputStickSettingsTapToClickKey;
        case InputStickSettingsItemTapInterval:
            return InputStickSettingsTapIntervalKey;
        case InputStickSettingsItemMouseSensitivity:
            return InputStickSettingsMouseSensitivityKey;
        case InputStickSettingsItemMousepadRatio:
            return InputStickSettingsMousepadRatioKey;
        case InputStickSettingsItemScrollSensitivity:
            return InputStickSettingsScrollSensitivityKey;
            
        default:
            return nil;
    }
}

+ (NSString *)valueForItem:(InputStickSettingsItem)item userDefaults:(NSUserDefaults *)userDefaults {
    NSString *key = [self keyForItem:item];
    if (key != nil) {
        return [userDefaults stringForKey:key];
    } else {
        return nil;
    }
}

+ (NSString *)displayValueForItem:(InputStickSettingsItem)item userDefaults:(NSUserDefaults *)userDefaults {
    NSArray<NSString *> *storeValues = [self storeValuesForItem:item];
    NSArray<NSString *> *displayValues = [self displayValuesForItem:item];
    NSString *value = [self valueForItem:item userDefaults:userDefaults];
    if (value != nil) {
        NSInteger index = [storeValues indexOfObject:value];
        if (index != NSNotFound) {
            return [displayValues objectAtIndex:index];
        }
    }
    return NSLocalizedStringFromTable(@"INPUTSTICK_ERROR_INTERNAL", InputStickStringTable, nil);
}

+ (NSArray<NSString *> *)displayValuesForItem:(InputStickSettingsItem)item {
    switch(item) {
        case InputStickSettingsItemAutoConnect:
            return @[NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_ENABLED", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_DISABLED", InputStickStringTable, nil)];
            
        case InputStickSettingsItemKeyboardLayout:
            return [InputStickKeyboardLayoutUtils fullNamesOfAllKeyboardLayouts];
        case InputStickSettingsItemTypingSpeed:
            return @[NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_TYPING_SPEED_FASTEST", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_TYPING_SPEED_NORMAL", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_TYPING_SPEED_SLOW", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_TYPING_SPEED_SLOWER", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_TYPING_SPEED_SLOWEST", InputStickStringTable, nil)];
            
        case InputStickSettingsItemMouseMode:
            return @[NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_MOUSEPAD_MODE_MOUSE", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_MOUSEPAD_MODE_TOUCH_SCREEN", InputStickStringTable, nil)];
        case InputStickSettingsItemTapToClick:
            return @[NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_ENABLED", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_DISABLED", InputStickStringTable, nil)];
        case InputStickSettingsItemTapInterval:
            return @[NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_TAP_INTERVAL_1000", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_TAP_INTERVAL_500", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_TAP_INTERVAL_250", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_TAP_INTERVAL_150", InputStickStringTable, nil)];
        case InputStickSettingsItemMouseSensitivity:
            case InputStickSettingsItemScrollSensitivity:
            return @[NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_SENSITIVITY_100", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_SENSITIVITY_90", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_SENSITIVITY_80", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_SENSITIVITY_70", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_SENSITIVITY_60", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_SENSITIVITY_50", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_SENSITIVITY_40", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_SENSITIVITY_30", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_SENSITIVITY_20", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_SENSITIVITY_10", InputStickStringTable, nil)];
        case InputStickSettingsItemMousepadRatio:
            return @[NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_MOUSEPAD_RATIO_FILL", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_MOUSEPAD_RATIO_1_1", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_MOUSEPAD_RATIO_5_4", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_MOUSEPAD_RATIO_4_3", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_MOUSEPAD_RATIO_16_10", InputStickStringTable, nil),
                     NSLocalizedStringFromTable(@"INPUTSTICK_SETTINGS_VALUE_MOUSEPAD_RATIO_16_9", InputStickStringTable, nil)];
        default:
            return nil;
    }
}


+ (NSArray<NSString *> *)storeValuesForItem:(InputStickSettingsItem)item {
    switch(item) {
        case InputStickSettingsItemAutoConnect:
            return @[InputStickSettingsEnabledValue, InputStickSettingsDisabledValue];
            
        case InputStickSettingsItemKeyboardLayout:
            return [InputStickKeyboardLayoutUtils codesOfAllKeyboardLayouts];
        case InputStickSettingsItemTypingSpeed:
            return @[@"0", @"1", @"2", @"5", @"10"];
            
        case InputStickSettingsItemMouseMode:
            return @[InputStickSettingsMouseModeValue, InputStickSettingsTouchScreenModeValue];
        case InputStickSettingsItemTapToClick:
            return @[InputStickSettingsEnabledValue, InputStickSettingsDisabledValue];
        case InputStickSettingsItemTapInterval:
            return @[@"1000", @"500", @"250", @"150"];
        case InputStickSettingsItemMouseSensitivity:
        case InputStickSettingsItemScrollSensitivity:
            return @[@"100", @"90", @"80", @"70", @"60", @"50", @"40", @"30", @"20", @"10"];
        case InputStickSettingsItemMousepadRatio:
            return @[@"0", @"1", @"1.25", @"1.33", @"1.6", @"1.78"];
            
        default:
            return nil;
    }
}


@end
