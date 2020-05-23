/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>


@class InputStickKeyboardKeyModel;
@class InputStickKeyLabels;

@protocol InputStickKeyboardLayoutProtocol <NSObject>

typedef NS_ENUM(NSUInteger, InputStickKeyboardType) {
    KEYBOARD_ISO,
    KEYBOARD_ANSI,
    KEYBOARD_JIS
};

- (NSString *)layoutCode;
- (NSString *)layoutCodeLowercase;
- (NSString *)layoutLanguageNativeName;
- (NSString *)layoutLanguageEnglishName;
- (NSString *)layoutCountryNativeName;
- (NSString *)layoutCountryEnglishName;
- (NSString *)layoutVariant;
- (NSString *)layoutDisplayName;
- (InputStickKeyboardType)keyboardType;

/*!
@brief returns InputStickKeyboardKeyModel which contains information about how to obtain desired character
*/
- (InputStickKeyboardKeyModel *)keyModelForCharacter:(int)character;

/*!
@brief returns NSString containing all characters that can be obtained using this layout
*/
- (NSString *)availableCharactersString;

/*!
@brief returns array containing codes of all characters that can be obtained using this layout
*/
- (NSArray<NSNumber *> *)availableCharactersLUT;

/*!
@brief returns InputStickKeyLabels containing data about all key labels in this layout
*/
- (InputStickKeyLabels *)keyLabels;

@end
