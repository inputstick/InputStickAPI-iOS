/*
* InputStickAPI-iOS
* Copyright (c) 2020 Jakub Zawadzki, www.inputstick.com
*/

/*!
@header InputStickKeyLabels.h
@brief allows to get key labels (name/symbol printed on physical keyboard) for each key in current keyboard layout, depending on provided state of modifier keys and keyboard LEDs (NumLock, CapsLock)
@discussion InputStickKeyLabels can be obtained from current KeyboardLayout object. Key label (name/symbol) represents what action will be executed when the key is pressed (example: "Esc", "F1") or what character will be typed (example: "A") when the key is pressed. Character may be affected by current state of modifier keys and keyboard LEDs. Key names are as short as possible, for some keys unicode symbols are used.
*/

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, InputStickKeyLabelType) {
    KEY_LABEL_NOT_DEFINED,  /*! key not defined in current keyboard layout  */
    KEY_LABEL_LAYOUT_DEPENDENT, /*! key is defined in current keyboard layout, labels may be deifferent in other keyboard layouts */
    KEY_LABEL_LAYOUT_INDEPENDENT, /*! key is defined in current keyboard layout, labels are the same in all keyboard layouts, label is not affected by state of modifier keys and keyboard LEDs */
    KEY_LABEL_NUMPAD /*! key is defined in current keyboard layout, labels are the same in all keyboard layouts, label is affected only by state of NumLock LED */
};

@interface InputStickKeyLabels : NSObject


#pragma mark - Object lifecycle

- (instancetype)init;


#pragma mark - Key setup

- (void)setupKey:(Byte)key withCharCodesArray:(NSArray *)charCodeArray;
- (void)setupKey:(Byte)key withLabel:(NSString *)label;
- (void)setupKey:(Byte)key withNumLockOffLabel:(NSString *)numLockOffLabel numLockOnLabel:(NSString *)numLockOnLabel;


#pragma mark - Key labels

/*!
@brief returns default key label
@param keyCode HID keycode
@return key label or nil if key is not defined in current keyboard layout
@discussion key label is a name/symbol printed on physical keyboard
*/
- (NSString *)labelForKey:(Byte)keyCode;

/*!
@brief returns key label assuming provided state of modifier keys
@param keyCode HID keycode
@param modifiers HID modifiers
@return key label or nil if key is not defined in current keyboard layout
@discussion key label is a name/symbol printed on physical keyboard
*/
- (NSString *)labelForKey:(Byte)keyCode withModifiers:(Byte)modifiers;

/*!
@brief returns key label assuming provided state of modifier keys, CapsLock and NumLock
@param keyCode HID keycode
@param modifiers HID modifiers
@param capsLock state of CapsLock
@param numLock state of NumLock
@param defaultIfNotFound if TRUE default label will be returned if there is no label defined for current set of parameters
@return key label or nil if key is not defined in current keyboard layout
@discussion key label is a name/symbol printed on physical keyboard. Examples: KEY_A + 0x00  will return "a", KEY_A+SHIFT will return "A", KEY_A+CAPS_LOCK will return "A", KEY_A+CTRL will return empty string or "a" if defaultIfNotFound is TRUE
*/
- (NSString *)labelForKey:(Byte)keyCode withModifiers:(Byte)modifiers capsLock:(BOOL)capsLock numLock:(BOOL)numLock defaultIfNotFound:(BOOL)defaultIfNotFound;

@end
