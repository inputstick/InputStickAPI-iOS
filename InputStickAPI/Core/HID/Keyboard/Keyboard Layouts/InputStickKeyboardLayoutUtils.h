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

@interface InputStickKeyboardLayoutUtils : NSObject

#pragma mark - Keyboard layouts

/*!
@brief returns array with all available keyboard layouts
@return all available keyboard layouts
*/
+ (NSArray<id <InputStickKeyboardLayoutProtocol>> *)allAvailableKeyboardLayouts;

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
+ (NSArray<NSString *> *)englishNamesOfAllKeyboardLayouts;

/*!
 @brief detailed names of all available keyboard layouts
 @return array with keyboard layout detailed names
 @discussion detailed name consists of English name, name in native language and variant of keyboard layout, example: "German (Deutsch) [DE macOS]"
 */
+ (NSArray<NSString *> *)fullNamesOfAllKeyboardLayouts;

/*!
@brief detailed names of keyboard layouts matching provided language code
@return array with keyboard layout detailed names
@discussion detailed name consists of English name, name in native language and variant of keyboard layout, example: "German (Deutsch) [DE macOS]"
*/
+ (NSArray<NSString *> *)fullNamesOfKeyboardLayoutsWithLanguageCode:(NSString *)languageCode;

/*!
 @brief layout codes of all available keyboard layouts
 @return array with keyboard layout codes
 @discussion layout code example: "de-DE"
 */
+ (NSArray<NSString *> *)codesOfAllKeyboardLayouts;

/*!
@brief layout codes of keyboard layouts matching provided language code
@param languageCode layout language code
@return array with keyboard layout codes
@discussion layout code example: "de-DE"
*/
+ (NSArray<NSString *> *)codesOfKeyboardLayoutsWithLanguageCode:(NSString *)languageCode;

/*!
@brief names of all supported keyboard languages
@return array with language names
@discussion language name example: "German (Deutsch)"
*/
+ (NSArray<NSString *> *)namesOfAllKeyboardLanguages;

/*!
@brief codes of all supported keyboard languages
@return array with language codes
@discussion language code example: "de"
*/
+ (NSArray<NSString *> *)codesOfAllKeyboardLanguages;

@end
