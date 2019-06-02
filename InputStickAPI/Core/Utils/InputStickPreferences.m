/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickPreferences.h"
#import "InputStickPreferencesHelper.h"
#import "InputStickKeyboardUtils.h"
#import "InputStickKeyboardLayoutProtocol.h"


@implementation InputStickPreferences

@synthesize mousepadRatio = _mousepadRatio;


- (instancetype)init {
    return [self initWithSuiteName:nil];
}

- (instancetype)initWithSuiteName:(NSString *)suiteName {
    self = [super init];
    if (self) {
        _suiteName = suiteName;
        _userDefaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
    }
    return self;
}


- (void)setDefaultValues {
    _autoConnect = FALSE;
    
    _keyboardLayout = [InputStickKeyboardUtils keyboardLayoutWithCode:@"en-US"];
    _typingSpeed = 1; //normal typing speed = max typing speed what won't cause missing keys on most of USB hosts
    
    _touchScreenMode = FALSE;
    _tapToClick = TRUE;
    _tapInterval = 500; //500ms
    _mouseSensitivity = 50;
    _scrollSensitivity = 50;
    _mousepadRatio = 0; //fill available area
    
    _touchProximity = 0; //if 0, will be calculated based on size of mousepad area
}

- (void)loadFromUserDefaults {
    //init with default values if used for the very first time
    if ( ![_userDefaults boolForKey:InputStickSettingsInitKey]) {
        [_userDefaults setBool:TRUE forKey:InputStickSettingsInitKey];
        InputStickPreferences *prefs = [[InputStickPreferences alloc] initWithSuiteName:self.suiteName];
        [prefs setDefaultValues];
        [prefs saveToUserDefaults];
    }
    
    [self loadValueForSettingsItem:InputStickSettingsItemAutoConnect];
    
    [self loadValueForSettingsItem:InputStickSettingsItemKeyboardLayout];
    [self loadValueForSettingsItem:InputStickSettingsItemTypingSpeed];
    
    [self loadValueForSettingsItem:InputStickSettingsItemMouseMode];
    [self loadValueForSettingsItem:InputStickSettingsItemTapToClick];
    [self loadValueForSettingsItem:InputStickSettingsItemTapInterval];
    [self loadValueForSettingsItem:InputStickSettingsItemMouseSensitivity];
    [self loadValueForSettingsItem:InputStickSettingsItemMousepadRatio];
    [self loadValueForSettingsItem:InputStickSettingsItemScrollSensitivity];
    
    _touchProximity = 0; //not stored, will be calculated based on size of mousepad
}

- (void)saveToUserDefaults {
    [self saveValueForSettingsItem:InputStickSettingsItemAutoConnect synchronize:FALSE];
    
    [self saveValueForSettingsItem:InputStickSettingsItemKeyboardLayout synchronize:FALSE];
    [self saveValueForSettingsItem:InputStickSettingsItemTypingSpeed synchronize:FALSE];
    
    [self saveValueForSettingsItem:InputStickSettingsItemMouseMode synchronize:FALSE];
    [self saveValueForSettingsItem:InputStickSettingsItemTapToClick synchronize:FALSE];
    [self saveValueForSettingsItem:InputStickSettingsItemTapInterval synchronize:FALSE];
    [self saveValueForSettingsItem:InputStickSettingsItemMouseSensitivity synchronize:FALSE];
    [self saveValueForSettingsItem:InputStickSettingsItemMousepadRatio synchronize:FALSE];
    [self saveValueForSettingsItem:InputStickSettingsItemScrollSensitivity synchronize:FALSE];
    
    [_userDefaults synchronize];
}


- (void)loadValueForSettingsItem:(InputStickSettingsItem)item {
    NSString *tmp;
    switch (item) {
        case InputStickSettingsItemNone:
            break;
        //connection:
        case InputStickSettingsItemAutoConnect:
            tmp = [_userDefaults objectForKey:InputStickSettingsAutoConnectKey];
            _autoConnect = [tmp isEqualToString:InputStickSettingsEnabledValue];
            break;
        //keyboard:
        case InputStickSettingsItemKeyboardLayout:
            tmp = [_userDefaults objectForKey:InputStickSettingsKeyboardLayoutKey];
            _keyboardLayout = [InputStickKeyboardUtils keyboardLayoutWithCode:tmp];
            break;
        case InputStickSettingsItemTypingSpeed:
            tmp = [_userDefaults objectForKey:InputStickSettingsTypingSpeedKey];
            _typingSpeed = [tmp integerValue];
            if (_typingSpeed > 32) {
                _typingSpeed = 32;
            }
            break;
        //mousepad: mouse/touchscreen
        case InputStickSettingsItemMouseMode:
            tmp = [_userDefaults objectForKey:InputStickSettingsMouseModeKey];
            _touchScreenMode = ![tmp isEqualToString:InputStickSettingsMouseModeValue]; //mouse/touch-screen mode (if TRUE)
            break;
        case InputStickSettingsItemTapToClick:
            tmp = [_userDefaults objectForKey:InputStickSettingsTapToClickKey];
            _tapToClick = [tmp isEqualToString:InputStickSettingsEnabledValue]; //tap mousepad to control left mouse button (if TRUE)
            break;
        case InputStickSettingsItemTapInterval:
            tmp = [_userDefaults objectForKey:InputStickSettingsTapIntervalKey];
            _tapInterval = [tmp integerValue];
            if (_tapInterval == 0) {
                _tapInterval = 500;
            }
            break;
        case InputStickSettingsItemMouseSensitivity:
            tmp = [_userDefaults objectForKey:InputStickSettingsMouseSensitivityKey];
            _mouseSensitivity = [tmp integerValue];
            if (_mouseSensitivity == 0) {
                _mouseSensitivity = 50;
            }
            break;
        case InputStickSettingsItemMousepadRatio:
            tmp = [_userDefaults objectForKey:InputStickSettingsMousepadRatioKey];
            _mousepadRatio = [tmp floatValue];
            if ((_mousepadRatio < 0) || (_mousepadRatio > 5)) {
                _mousepadRatio = 0;
            }
            break;
        case InputStickSettingsItemScrollSensitivity:
            tmp = [_userDefaults objectForKey:InputStickSettingsScrollSensitivityKey];
            _scrollSensitivity = [tmp integerValue];
            if (_scrollSensitivity == 0) {
                _scrollSensitivity = 50;
            }
            break;
    }
}

- (void)saveValueForSettingsItem:(InputStickSettingsItem)item synchronize:(BOOL)synchronize {
    switch (item) {
        case InputStickSettingsItemNone:
            break;
            //connection:
        case InputStickSettingsItemAutoConnect:
            if (_autoConnect) {
                [_userDefaults setObject:InputStickSettingsEnabledValue forKey:InputStickSettingsAutoConnectKey];
            } else {
                [_userDefaults setObject:InputStickSettingsDisabledValue forKey:InputStickSettingsAutoConnectKey];
            }
            break;
            //keyboard:
        case InputStickSettingsItemKeyboardLayout:
            [_userDefaults setObject:[[_keyboardLayout class] layoutCode] forKey:InputStickSettingsKeyboardLayoutKey];
            break;
        case InputStickSettingsItemTypingSpeed:
            [_userDefaults setObject:[[NSNumber numberWithInteger:_typingSpeed] stringValue] forKey:InputStickSettingsTypingSpeedKey];
            break;
            //mousepad: mouse/touchscreen
        case InputStickSettingsItemMouseMode:
            if (_touchScreenMode) {
                [_userDefaults setObject:InputStickSettingsTouchScreenModeValue forKey:InputStickSettingsMouseModeKey];
            } else {
                [_userDefaults setObject:InputStickSettingsMouseModeValue forKey:InputStickSettingsMouseModeKey];
            }
            break;
        case InputStickSettingsItemTapToClick:
            if (_tapToClick) {
                [_userDefaults setObject:InputStickSettingsEnabledValue forKey:InputStickSettingsTapToClickKey];
            } else {
                [_userDefaults setObject:InputStickSettingsDisabledValue forKey:InputStickSettingsTapToClickKey];
            }
            break;
        case InputStickSettingsItemTapInterval:
            [_userDefaults setObject:[[NSNumber numberWithInteger:_tapInterval] stringValue] forKey:InputStickSettingsTapIntervalKey];
            break;
        case InputStickSettingsItemMouseSensitivity:
            [_userDefaults setObject:[[NSNumber numberWithInteger:_mouseSensitivity] stringValue] forKey:InputStickSettingsMouseSensitivityKey];
            break;
        case InputStickSettingsItemMousepadRatio:
            [_userDefaults setObject:[[NSNumber numberWithFloat:_mousepadRatio] stringValue] forKey:InputStickSettingsMousepadRatioKey];
            break;
        case InputStickSettingsItemScrollSensitivity:
            [_userDefaults setObject:[[NSNumber numberWithInteger:_scrollSensitivity] stringValue] forKey:InputStickSettingsScrollSensitivityKey];
            break;
    }
    
    if (synchronize) {
        [_userDefaults synchronize];
    }
}


- (float)mousepadRatio {
    if (_touchScreenMode) {
        return _mousepadRatio;
    } else {
        return 0;
    }
}

@end
