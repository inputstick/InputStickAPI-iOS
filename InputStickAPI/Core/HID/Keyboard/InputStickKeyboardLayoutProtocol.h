/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import <Foundation/Foundation.h>


@class InputStickKeyboardKeyModel;

@protocol InputStickKeyboardLayoutProtocol <NSObject>

typedef NS_ENUM(NSUInteger, InputStickKeyboardType) {
    KEYBOARD_ISO,
    KEYBOARD_ANSI,
    KEYBOARD_JIS
};

+ (NSString *)layoutCode;
+ (NSString *)layoutCodeLowercase;
+ (NSString *)layoutNativeName;
+ (NSString *)layoutEnglishName;
+ (NSString *)layoutVariant;
+ (NSString *)layoutFullName;
+ (InputStickKeyboardType)keyboardType;

+ (InputStickKeyboardKeyModel *)getKeyModelForCharacter:(int)character;
+ (NSArray<NSNumber *> *)getAvailableCharacters;
+ (NSArray *)getLUT;

@end
