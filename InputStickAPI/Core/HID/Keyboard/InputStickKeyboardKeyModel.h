/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickKeyboardKeyModel.h
 @brief contains info about key(s) that have to be pressed to obtain (type) unicode character
 @discussion always use the same keyboard layout as USB host
 */

#import <Foundation/Foundation.h>

@class InputStickHIDReport;
@protocol InputStickKeyboardLayoutProtocol;

@interface InputStickKeyboardKeyModel : NSObject

/*! unicode character equivalent to key label */
@property(nonatomic, readonly) unichar unicodeCode;
/*! key that has to be pressed to obtain this character */
@property(nonatomic, readonly) Byte key;
/*! modifier key(s) that has to be pressed together with key to obtain this character  */
@property(nonatomic, readonly) Byte modifiers;
/*! "dead key" that has to be pressed (before "key") to obtain this character */
@property(nonatomic, readonly) Byte deadkey;
/*! modifier key(s) that has to be pressed together with dead key */
@property(nonatomic, readonly) Byte deadkeyModifiers;


/*!
 @brief initializes InputStickKeyboardKeyModel using specified data
 @param key key to be pressed
 @param modifiers modifier keys to be pressed together with key
 @param deadkey dead key to be pressed before key
 @param deadkeyModifiers modifier keys to be pressed together with dead key
 @return InputStickKeyboardKeyModel
 */
- (instancetype)initWithUnicodeCharacter:(unichar)unicodeCharacter key:(Byte)key modifiers:(Byte)modifiers deadkey:(Byte)deadkey deadkeyModifiers:(Byte)deadkeyModifiers;


@end
