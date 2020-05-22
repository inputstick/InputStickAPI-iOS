/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

/*!
 @header InputStickKeyboardUtils.h
 @brief helper class for Keyboard Layouts.
 @discussion
 Keyboard Layout codes: [language code]-[country/region code]-[optionally: variant code]
 Example: de-CH-mac (macOS-compatible German keyboard layout used in Switzerland)
 
 Keyboard layout group: all keyboard layouts sharing the same language & country/region codes
 Example: de-DE, de-DE-mac, de-DE-linux
 
 Keyboard layout names: english name, native name, display name
 Example: German, Deutsch, German DE macOS
 */

#import <Foundation/Foundation.h>

@protocol InputStickKeyboardLayoutProtocol;

@interface InputStickKeyboardLayoutUtils : NSObject

#pragma mark - Keyboard layouts

/*!
@brief returns array of all available keyboard layouts
@return array of keyboard layouts
*/
+ (NSArray<id <InputStickKeyboardLayoutProtocol>> *)keyboardLayouts;

/*!
@brief returns array of keyboard layouts matching provided keyboard layout code prefix
@param codePrefix keyboard layout code prefix
@return array of keyboard layouts
@discussion prefix example: "de"
*/
+ (NSArray<id <InputStickKeyboardLayoutProtocol>> *)keyboardLayoutsWithCodePrefix:(NSString *)codePrefix;

/*!
@brief returns keyboard layout matching specified keyboard layout code
@return keyboard layout
@discussion keyboard layout code example: "de-DE-mac". If layout is not found, "en-US" keyboard layout is returned
*/
+ (id <InputStickKeyboardLayoutProtocol>)keyboardLayoutWithCode:(NSString *)code;


#pragma mark - Keyboard layout names

/*!
@brief returns array of user-friendly names of all available keyboard layouts
@return array of keyboard layout user-friendly names
@discussion user-friendly name consists of English name, country name and optionally variant of keyboard layout, example: "German DE macOS"
*/
+ (NSArray<NSString *> *)keyboardLayoutDisplayNames;

/*!
@brief returns array of user-friendly names of keyboard layouts matching provided keyboard layout code prefix
@param codePrefix keyboard layout code prefix
@return array of keyboard layout user-friendly names
@discussion user-friendly name consists of English name, country name and optionally variant of keyboard layout, example: "German DE macOS"
*/
+ (NSArray<NSString *> *)keyboardLayoutDisplayNamesWithCodePrefix:(NSString *)codePrefix;


#pragma mark - Keyboard layout codes

/*!
@brief returns array of keyboard layout codes of all available keyboard layouts
@return array of keyboard layout codes
@discussion keyboard layout code example: "de-DE"
*/
+ (NSArray<NSString *> *)keyboardLayoutCodes;

/*!
@brief returns array of keyboard layout codes of keyboard layouts matching provided keyboard layout code prefix
@param codePrefix keyboard layout code prefix
@return array of keyboard layout codes
@discussion keyboard layout code example: "de-DE", prefix example: "de"
*/
+ (NSArray<NSString *> *)keyboardLayoutCodesWithCodePrefix:(NSString *)codePrefix;


#pragma mark - Keyboard layout languages

/*!
@brief returns array of codes of all supported keyboard layout languages
@return array of language codes
@discussion language code example: "de"
*/
+ (NSArray<NSString *> *)keyboardLayoutLanguageCodes;

/*!
@brief returns array of names of all supported keyboard layout languages
@return array of language names
@discussion language name example: "German (Deutsch)"
*/
+ (NSArray<NSString *> *)keyboardLayoutLanguageNames;


#pragma mark - Keyboard layout groups

/*!
@brief returns array of keyboard layout group codes matching provided language code
@param languageCode two letter language code
@return array of keyboard layout group codes
@discussion keyboard layout group code example: "de-DE", language code example: "de"
*/
+ (NSArray<NSString *> *)groupCodesWithLanguageCode:(NSString *)languageCode;

/*!
@brief returns name of keyboard layout group matching provided group code
@param groupCode keyboard layout group code
@return keyboard layout group name
@discussion keyboard layout group name example: "German", group code example: "de"
*/
+ (NSString *)groupNameWithGroupCode:(NSString *)groupCode;

/*!
@brief returns info text for keyboard layout group matching provided group code
@param groupCode keyboard layout group code
@return keyboard layout group info
@discussion group code example: "de". Info text informs user about compatibility of keyboard layouts that are available in specified keyboard layout group
*/
+ (NSString *)groupInfoWithGroupCode:(NSString *)groupCode;

@end
