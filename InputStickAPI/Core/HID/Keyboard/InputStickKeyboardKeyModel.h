/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickKeyboardKeyModel.h
 @brief represents character that can be typed
 @discussion always use the same keyboard layout as USB host
 */

#import <Foundation/Foundation.h>

@class InputStickHIDReport;
@protocol InputStickKeyboardLayoutProtocol;

@interface InputStickKeyboardKeyModel : NSObject

/*! unicode character equivalent to key label */
@property(nonatomic, readonly) unichar unicodeCode;
/*! key that has to be pressed to obtain this character */
@property(nonatomic) Byte key;
/*! modifier key(s) that has to be pressed together with key to obtain this character  */
@property(nonatomic) Byte modifiers;
/*! "dead key" that has to be pressed (before "key") to obtain this character */
@property(nonatomic) Byte deadkey;
/*! modifier key(s) that has to be pressed together with dead key */
@property(nonatomic) Byte deadkeyModifiers;


/*!
 @brief initializes InputStickKeyboardKeyModel using specified data
 @param key key to be pressed
 @param modifiers modifier keys to be pressed together with key
 @param deadkey dead key to be pressed before key
 @param deadkeyModifiers modifier keys to be pressed together with dead key
 @return InputStickKeyboardKeyModel
 */
- (instancetype)initWithUnicodeCharacter:(unichar)unicodeCharacter key:(Byte)key modifiers:(Byte)modifiers deadkey:(Byte)deadkey deadkeyModifiers:(Byte)deadkeyModifiers;

/*!
 @brief returns instance of InputStickKeyboardKeyModel that will allow to obtain specified character when specified keyboard layout is used by USB host
 @param character character to type
 @param keyboardLayout keyboard layout used by USB host
 @return InputStickKeyboardKeyModel allowing to obtain specified character
 */
+ (InputStickKeyboardKeyModel *)modelForCharacter:(unichar)character withKeyboardLayout:(id <InputStickKeyboardLayoutProtocol>)keyboardLayout;


#pragma mark - Keyboard reports array conversion

/*!
 @brief HID Keyboard Reports required to obtain this character
 @return array of HID Keyboard Reports
 */
- (NSArray<InputStickHIDReport *> *)keyboardReports;

/*!
 @brief number of HID Keyboard Reports required to obtain this character
 @return number of HID Keyboard Reports
 */
- (NSUInteger)numberOfKeyboardReports;

@end
