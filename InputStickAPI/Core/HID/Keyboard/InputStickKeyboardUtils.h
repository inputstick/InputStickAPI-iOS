/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickKeyboardUtils.h
 @brief helper class for Keyboard layouts / key labels
 */

#import <Foundation/Foundation.h>

@protocol InputStickKeyboardLayoutProtocol;

@interface InputStickKeyboardUtils : NSObject

#pragma mark - Keyboard layouts

/*!
 @brief keyboard layout for specified keyboard layout code
 @return keyboard layout
 @discussion layout code example: "de-DE", if layout is not found, "en-US" will be returned
 */
+ (id <InputStickKeyboardLayoutProtocol>)keyboardLayoutWithCode:(NSString *)code;

/*!
 @brief English names of all available keyboard layouts
 @return array with keyboard layout names in English
 @discussion name example: "German"
 */
+ (NSArray<NSString *> *)getEnglishNamesOfAllKeyboardLayouts;

/*!
 @brief detailed names of all available keyboard layouts
 @return array with keyboard layout detailed names
 @discussion detailed name consists of English name, name in native language and variant of keyboard layout, example: "German (Deutsch) [DE]"
 */
+ (NSArray<NSString *> *)getFullNamesOfAllKeyboardLayouts;

/*!
 @brief layout codes of all available keyboard layouts
 @return array with keyboard layout codes
 @discussion layout code example: "de-DE"
 */
+ (NSArray<NSString *> *)getCodesOfAllKeyboardLayouts;


#pragma mark - Key labels

+ (NSUInteger)getKeyLabelsLUTIndexForModifiers:(Byte)modifiers;

/*!
 @brief return key label for provided parameters
 @param key key
 @param modifiers pressed modifier keys
 @param lut look-up-table from keyboard layout
 @return key label
 @discussion key label represents character that will be typed when key is pressed
 */
+ (NSString *)getLabelForKey:(Byte)key withModifiers:(Byte)modifiers withKeyLabelsLUT:(NSArray *)lut;

/*!
 @brief array with key labels for all keys and modifier combinations
 @param layout keyboard layout
 @return key label look-up-table
 @discussion key label represents character that will be typed when key is pressed.
 To get labels for "Shift+A" key get object at index 4 (HIDKeycodes.KEY_A) and then object at index 1 (0 = none, 1 = Shift, 2 = Ctrl, 3 = AltGr, 4 = AltGr+Shift)
 */
+ (NSArray *)getKeyLabelsLUTForLayout:(id <InputStickKeyboardLayoutProtocol>)layout;

@end
