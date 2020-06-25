/*
 * InputStickAPI-iOS
 * Copyright (c) 2020 Jakub Zawadzki, www.inputstick.com
 */
 
#import "InputStickKeyboardLayoutRuRUMac.h"
#import "InputStickKeyboardKeyModel.h"
#import "InputStickKeyLabels.h"

//InputStickKeyboardLayoutGenerator v1.00

@interface InputStickKeyboardLayoutRuRUMac () {
    InputStickKeyLabels *_keyLabels;
    NSArray<NSNumber *> *_availableCharactersLUT;
}

@end


@implementation InputStickKeyboardLayoutRuRUMac

- (NSString *)layoutCode {
    return @"ru-RU-mac";
}

- (NSString *)layoutCodeLowercase {
    return @"ru-ru-mac";
}

- (NSString *)layoutLanguageCode {
    return @"ru";
}

- (NSString *)layoutLanguageNativeName {
    return @"Русский";
}

- (NSString *)layoutLanguageEnglishName {
    return @"Russian";
}

- (NSString *)layoutCountryCode {
    return @"RU";
}

- (NSString *)layoutCountryNativeName {
    return @"Россия";
}

- (NSString *)layoutCountryEnglishName {
    return @"Russia";
}

- (NSString *)layoutVariant {
    return @"RU macOS";
}

- (NSString *)layoutDisplayName {
    return @"Russian, RU macOS";
}

- (InputStickKeyboardType)keyboardType {
    return KEYBOARD_ANSI;
}

- (InputStickKeyboardKeyModel *)keyModelForCharacter:(int)character {
    InputStickKeyboardKeyModel *keyboardKeyModel = nil;
    switch (character) {
            case 0: // empty
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:0 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 9: // tab
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:43 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 10: // enter
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:40 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 32: // space
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:44 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 33: // !
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 34: // "
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 35: // #
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 36: // $
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 37: // %
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 38: // &
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 39: // '
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 40: // (
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 41: // )
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 42: // *
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 43: // +
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 44: // ,
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 45: // -
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 46: // .
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 47: // /
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 48: // 0
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 49: // 1
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 50: // 2
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 51: // 3
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 52: // 4
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 53: // 5
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 54: // 6
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 55: // 7
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 56: // 8
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 57: // 9
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 58: // :
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 59: // ;
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 60: // <
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 61: // =
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 62: // >
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 63: // ?
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 64: // @
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 91: // [
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 93: // ]
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 94: // ^
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 95: // _
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 96: // `
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 123: // {
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 124: // |
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 125: // }
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 126: // ~
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 163: // £
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 169: // ©
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 171: // «
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 172: // ¬
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 174: // ®
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 176: // °
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 181: // µ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 182: // ¶
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 187: // »
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 247: // ÷
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 402: // ƒ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 1025: // Ё
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1026: // Ђ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 1027: // Ѓ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 1029: // Ѕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 1032: // Ј
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 1033: // Љ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 1034: // Њ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 1035: // Ћ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 1036: // Ќ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 1038: // Ў
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 1039: // Џ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 1040: // А
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1041: // Б
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1042: // В
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1043: // Г
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1044: // Д
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1045: // Е
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1046: // Ж
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1047: // З
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1048: // И
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1049: // Й
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1050: // К
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1051: // Л
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1052: // М
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1053: // Н
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1054: // О
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1055: // П
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1056: // Р
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1057: // С
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1058: // Т
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1059: // У
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1060: // Ф
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1061: // Х
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1062: // Ц
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1063: // Ч
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1064: // Ш
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1065: // Щ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1066: // Ъ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1067: // Ы
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1068: // Ь
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1069: // Э
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1070: // Ю
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1071: // Я
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1072: // а
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1073: // б
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1074: // в
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1075: // г
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1076: // д
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1077: // е
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1078: // ж
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1079: // з
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1080: // и
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1081: // й
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1082: // к
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1083: // л
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1084: // м
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1085: // н
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1086: // о
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1087: // п
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1088: // р
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1089: // с
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1090: // т
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1091: // у
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1092: // ф
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1093: // х
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1094: // ц
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1095: // ч
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1096: // ш
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1097: // щ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1098: // ъ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1099: // ы
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1100: // ь
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1101: // э
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1102: // ю
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1103: // я
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1105: // ё
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 1106: // ђ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 1107: // ѓ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 1109: // ѕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 1112: // ј
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 1113: // љ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 1114: // њ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 1115: // ћ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 1116: // ќ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 1118: // ў
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 1119: // џ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8211: // –
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8212: // —
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8216: // ‘
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8217: // ’
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8220: // “
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8221: // ”
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8222: // „
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8224: // †
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8226: // •
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8230: // …
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8364: // €
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8381: // ₽
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8470: // №
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 8482: // ™
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8710: // ∆
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8730: // √
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8734: // ∞
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8776: // ≈
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8800: // ≠
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8804: // ≤
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8805: // ≥
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
    }
    return keyboardKeyModel;
}

- (NSString *)availableCharactersString {
    //\t\n !"#$%&'()*+,-./0123456789:;<=>?@[]^_`{|}~£©«¬®°µ¶»÷ƒЁЂЃЅЈЉЊЋЌЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюяёђѓѕјљњћќўџ–—‘’“”„†•…€₽№™∆√∞≈≠≤≥
    return @"\t\n !\"#$%&\'()*+,-./0123456789:;<=>?@[]^_`{|}~\u00A3\u00A9\u00AB\u00AC\u00AE\u00B0\u00B5\u00B6\u00BB\u00F7\u0192\u0401\u0402\u0403\u0405\u0408\u0409\u040A\u040B\u040C\u040E\u040F\u0410\u0411\u0412\u0413\u0414\u0415\u0416\u0417\u0418\u0419\u041A\u041B\u041C\u041D\u041E\u041F\u0420\u0421\u0422\u0423\u0424\u0425\u0426\u0427\u0428\u0429\u042A\u042B\u042C\u042D\u042E\u042F\u0430\u0431\u0432\u0433\u0434\u0435\u0436\u0437\u0438\u0439\u043A\u043B\u043C\u043D\u043E\u043F\u0440\u0441\u0442\u0443\u0444\u0445\u0446\u0447\u0448\u0449\u044A\u044B\u044C\u044D\u044E\u044F\u0451\u0452\u0453\u0455\u0458\u0459\u045A\u045B\u045C\u045E\u045F\u2013\u2014\u2018\u2019\u201C\u201D\u201E\u2020\u2022\u2026\u20AC\u20BD\u2116\u2122\u2206\u221A\u221E\u2248\u2260\u2264\u2265";
}

- (NSArray<NSNumber *> *)availableCharactersLUT {
    if (_availableCharactersLUT == nil) {
        NSMutableArray<NSNumber *> *lut = [NSMutableArray array];
        [lut addObject:[NSNumber numberWithInteger:0]];
        [lut addObject:[NSNumber numberWithInteger:9]];
        [lut addObject:[NSNumber numberWithInteger:10]];
        [lut addObject:[NSNumber numberWithInteger:33]];
        [lut addObject:[NSNumber numberWithInteger:34]];
        [lut addObject:[NSNumber numberWithInteger:35]];
        [lut addObject:[NSNumber numberWithInteger:36]];
        [lut addObject:[NSNumber numberWithInteger:37]];
        [lut addObject:[NSNumber numberWithInteger:38]];
        [lut addObject:[NSNumber numberWithInteger:39]];
        [lut addObject:[NSNumber numberWithInteger:40]];
        [lut addObject:[NSNumber numberWithInteger:41]];
        [lut addObject:[NSNumber numberWithInteger:42]];
        [lut addObject:[NSNumber numberWithInteger:43]];
        [lut addObject:[NSNumber numberWithInteger:44]];
        [lut addObject:[NSNumber numberWithInteger:45]];
        [lut addObject:[NSNumber numberWithInteger:46]];
        [lut addObject:[NSNumber numberWithInteger:47]];
        [lut addObject:[NSNumber numberWithInteger:48]];
        [lut addObject:[NSNumber numberWithInteger:49]];
        [lut addObject:[NSNumber numberWithInteger:50]];
        [lut addObject:[NSNumber numberWithInteger:51]];
        [lut addObject:[NSNumber numberWithInteger:52]];
        [lut addObject:[NSNumber numberWithInteger:53]];
        [lut addObject:[NSNumber numberWithInteger:54]];
        [lut addObject:[NSNumber numberWithInteger:55]];
        [lut addObject:[NSNumber numberWithInteger:56]];
        [lut addObject:[NSNumber numberWithInteger:57]];
        [lut addObject:[NSNumber numberWithInteger:58]];
        [lut addObject:[NSNumber numberWithInteger:59]];
        [lut addObject:[NSNumber numberWithInteger:60]];
        [lut addObject:[NSNumber numberWithInteger:61]];
        [lut addObject:[NSNumber numberWithInteger:62]];
        [lut addObject:[NSNumber numberWithInteger:63]];
        [lut addObject:[NSNumber numberWithInteger:64]];
        [lut addObject:[NSNumber numberWithInteger:91]];
        [lut addObject:[NSNumber numberWithInteger:93]];
        [lut addObject:[NSNumber numberWithInteger:94]];
        [lut addObject:[NSNumber numberWithInteger:95]];
        [lut addObject:[NSNumber numberWithInteger:96]];
        [lut addObject:[NSNumber numberWithInteger:123]];
        [lut addObject:[NSNumber numberWithInteger:124]];
        [lut addObject:[NSNumber numberWithInteger:125]];
        [lut addObject:[NSNumber numberWithInteger:126]];
        [lut addObject:[NSNumber numberWithInteger:163]];
        [lut addObject:[NSNumber numberWithInteger:169]];
        [lut addObject:[NSNumber numberWithInteger:171]];
        [lut addObject:[NSNumber numberWithInteger:172]];
        [lut addObject:[NSNumber numberWithInteger:174]];
        [lut addObject:[NSNumber numberWithInteger:176]];
        [lut addObject:[NSNumber numberWithInteger:181]];
        [lut addObject:[NSNumber numberWithInteger:182]];
        [lut addObject:[NSNumber numberWithInteger:187]];
        [lut addObject:[NSNumber numberWithInteger:247]];
        [lut addObject:[NSNumber numberWithInteger:402]];
        [lut addObject:[NSNumber numberWithInteger:1025]];
        [lut addObject:[NSNumber numberWithInteger:1026]];
        [lut addObject:[NSNumber numberWithInteger:1027]];
        [lut addObject:[NSNumber numberWithInteger:1029]];
        [lut addObject:[NSNumber numberWithInteger:1032]];
        [lut addObject:[NSNumber numberWithInteger:1033]];
        [lut addObject:[NSNumber numberWithInteger:1034]];
        [lut addObject:[NSNumber numberWithInteger:1035]];
        [lut addObject:[NSNumber numberWithInteger:1036]];
        [lut addObject:[NSNumber numberWithInteger:1038]];
        [lut addObject:[NSNumber numberWithInteger:1039]];
        [lut addObject:[NSNumber numberWithInteger:1040]];
        [lut addObject:[NSNumber numberWithInteger:1041]];
        [lut addObject:[NSNumber numberWithInteger:1042]];
        [lut addObject:[NSNumber numberWithInteger:1043]];
        [lut addObject:[NSNumber numberWithInteger:1044]];
        [lut addObject:[NSNumber numberWithInteger:1045]];
        [lut addObject:[NSNumber numberWithInteger:1046]];
        [lut addObject:[NSNumber numberWithInteger:1047]];
        [lut addObject:[NSNumber numberWithInteger:1048]];
        [lut addObject:[NSNumber numberWithInteger:1049]];
        [lut addObject:[NSNumber numberWithInteger:1050]];
        [lut addObject:[NSNumber numberWithInteger:1051]];
        [lut addObject:[NSNumber numberWithInteger:1052]];
        [lut addObject:[NSNumber numberWithInteger:1053]];
        [lut addObject:[NSNumber numberWithInteger:1054]];
        [lut addObject:[NSNumber numberWithInteger:1055]];
        [lut addObject:[NSNumber numberWithInteger:1056]];
        [lut addObject:[NSNumber numberWithInteger:1057]];
        [lut addObject:[NSNumber numberWithInteger:1058]];
        [lut addObject:[NSNumber numberWithInteger:1059]];
        [lut addObject:[NSNumber numberWithInteger:1060]];
        [lut addObject:[NSNumber numberWithInteger:1061]];
        [lut addObject:[NSNumber numberWithInteger:1062]];
        [lut addObject:[NSNumber numberWithInteger:1063]];
        [lut addObject:[NSNumber numberWithInteger:1064]];
        [lut addObject:[NSNumber numberWithInteger:1065]];
        [lut addObject:[NSNumber numberWithInteger:1066]];
        [lut addObject:[NSNumber numberWithInteger:1067]];
        [lut addObject:[NSNumber numberWithInteger:1068]];
        [lut addObject:[NSNumber numberWithInteger:1069]];
        [lut addObject:[NSNumber numberWithInteger:1070]];
        [lut addObject:[NSNumber numberWithInteger:1071]];
        [lut addObject:[NSNumber numberWithInteger:1072]];
        [lut addObject:[NSNumber numberWithInteger:1073]];
        [lut addObject:[NSNumber numberWithInteger:1074]];
        [lut addObject:[NSNumber numberWithInteger:1075]];
        [lut addObject:[NSNumber numberWithInteger:1076]];
        [lut addObject:[NSNumber numberWithInteger:1077]];
        [lut addObject:[NSNumber numberWithInteger:1078]];
        [lut addObject:[NSNumber numberWithInteger:1079]];
        [lut addObject:[NSNumber numberWithInteger:1080]];
        [lut addObject:[NSNumber numberWithInteger:1081]];
        [lut addObject:[NSNumber numberWithInteger:1082]];
        [lut addObject:[NSNumber numberWithInteger:1083]];
        [lut addObject:[NSNumber numberWithInteger:1084]];
        [lut addObject:[NSNumber numberWithInteger:1085]];
        [lut addObject:[NSNumber numberWithInteger:1086]];
        [lut addObject:[NSNumber numberWithInteger:1087]];
        [lut addObject:[NSNumber numberWithInteger:1088]];
        [lut addObject:[NSNumber numberWithInteger:1089]];
        [lut addObject:[NSNumber numberWithInteger:1090]];
        [lut addObject:[NSNumber numberWithInteger:1091]];
        [lut addObject:[NSNumber numberWithInteger:1092]];
        [lut addObject:[NSNumber numberWithInteger:1093]];
        [lut addObject:[NSNumber numberWithInteger:1094]];
        [lut addObject:[NSNumber numberWithInteger:1095]];
        [lut addObject:[NSNumber numberWithInteger:1096]];
        [lut addObject:[NSNumber numberWithInteger:1097]];
        [lut addObject:[NSNumber numberWithInteger:1098]];
        [lut addObject:[NSNumber numberWithInteger:1099]];
        [lut addObject:[NSNumber numberWithInteger:1100]];
        [lut addObject:[NSNumber numberWithInteger:1101]];
        [lut addObject:[NSNumber numberWithInteger:1102]];
        [lut addObject:[NSNumber numberWithInteger:1103]];
        [lut addObject:[NSNumber numberWithInteger:1105]];
        [lut addObject:[NSNumber numberWithInteger:1106]];
        [lut addObject:[NSNumber numberWithInteger:1107]];
        [lut addObject:[NSNumber numberWithInteger:1109]];
        [lut addObject:[NSNumber numberWithInteger:1112]];
        [lut addObject:[NSNumber numberWithInteger:1113]];
        [lut addObject:[NSNumber numberWithInteger:1114]];
        [lut addObject:[NSNumber numberWithInteger:1115]];
        [lut addObject:[NSNumber numberWithInteger:1116]];
        [lut addObject:[NSNumber numberWithInteger:1118]];
        [lut addObject:[NSNumber numberWithInteger:1119]];
        [lut addObject:[NSNumber numberWithInteger:8211]];
        [lut addObject:[NSNumber numberWithInteger:8212]];
        [lut addObject:[NSNumber numberWithInteger:8216]];
        [lut addObject:[NSNumber numberWithInteger:8217]];
        [lut addObject:[NSNumber numberWithInteger:8220]];
        [lut addObject:[NSNumber numberWithInteger:8221]];
        [lut addObject:[NSNumber numberWithInteger:8222]];
        [lut addObject:[NSNumber numberWithInteger:8224]];
        [lut addObject:[NSNumber numberWithInteger:8226]];
        [lut addObject:[NSNumber numberWithInteger:8230]];
        [lut addObject:[NSNumber numberWithInteger:8364]];
        [lut addObject:[NSNumber numberWithInteger:8381]];
        [lut addObject:[NSNumber numberWithInteger:8470]];
        [lut addObject:[NSNumber numberWithInteger:8482]];
        [lut addObject:[NSNumber numberWithInteger:8710]];
        [lut addObject:[NSNumber numberWithInteger:8730]];
        [lut addObject:[NSNumber numberWithInteger:8734]];
        [lut addObject:[NSNumber numberWithInteger:8776]];
        [lut addObject:[NSNumber numberWithInteger:8800]];
        [lut addObject:[NSNumber numberWithInteger:8804]];
        [lut addObject:[NSNumber numberWithInteger:8805]];
        _availableCharactersLUT = lut;
    }
    return _availableCharactersLUT;
}

- (InputStickKeyLabels *)keyLabels {
    if (_keyLabels == nil) {
        _keyLabels = [[InputStickKeyLabels alloc] init];
        [_keyLabels setupKey:0x04 withCharCodesArray:@[@0x00, @0x0444, @0x0424, @0x0192, @0x0192, @0x0424, @0x0424, @0x0192, @0x0192]];
        [_keyLabels setupKey:0x05 withCharCodesArray:@[@0x00, @0x0438, @0x0418, @0x0438, @0x0418, @0x0418, @0x0418, @0x0438, @0x0418]];
        [_keyLabels setupKey:0x06 withCharCodesArray:@[@0x00, @0x0441, @0x0421, @0x2260, @0x2260, @0x0421, @0x0421, @0x2260, @0x2260]];
        [_keyLabels setupKey:0x07 withCharCodesArray:@[@0x00, @0x0432, @0x0412, @0x045B, @0x040B, @0x0412, @0x0412, @0x045B, @0x040B]];
        [_keyLabels setupKey:0x08 withCharCodesArray:@[@0x00, @0x0443, @0x0423, @0x045C, @0x040C, @0x0423, @0x0423, @0x045C, @0x040C]];
        [_keyLabels setupKey:0x09 withCharCodesArray:@[@0x00, @0x0430, @0x0410, @0x00F7, @0x00F7, @0x0410, @0x0410, @0x00F7, @0x00F7]];
        [_keyLabels setupKey:0x0A withCharCodesArray:@[@0x00, @0x043F, @0x041F, @0x00A9, @0x00A9, @0x041F, @0x041F, @0x00A9, @0x00A9]];
        [_keyLabels setupKey:0x0B withCharCodesArray:@[@0x00, @0x0440, @0x0420, @0x20BD, @0x20BD, @0x0420, @0x0420, @0x20BD, @0x20BD]];
        [_keyLabels setupKey:0x0C withCharCodesArray:@[@0x00, @0x0448, @0x0428, @0x0455, @0x0405, @0x0428, @0x0428, @0x0455, @0x0405]];
        [_keyLabels setupKey:0x0D withCharCodesArray:@[@0x00, @0x043E, @0x041E, @0x00B0, @0x2022, @0x041E, @0x041E, @0x00B0, @0x2022]];
        [_keyLabels setupKey:0x0E withCharCodesArray:@[@0x00, @0x043B, @0x041B, @0x0459, @0x0409, @0x041B, @0x041B, @0x0459, @0x0409]];
        [_keyLabels setupKey:0x0F withCharCodesArray:@[@0x00, @0x0434, @0x0414, @0x2206, @0x2206, @0x0414, @0x0414, @0x2206, @0x2206]];
        [_keyLabels setupKey:0x10 withCharCodesArray:@[@0x00, @0x044C, @0x042C, @0x007E, @0x007E, @0x042C, @0x042C, @0x007E, @0x007E]];
        [_keyLabels setupKey:0x11 withCharCodesArray:@[@0x00, @0x0442, @0x0422, @0x2122, @0x2122, @0x0422, @0x0422, @0x2122, @0x2122]];
        [_keyLabels setupKey:0x12 withCharCodesArray:@[@0x00, @0x0449, @0x0429, @0x045E, @0x040E, @0x0429, @0x0429, @0x045E, @0x040E]];
        [_keyLabels setupKey:0x13 withCharCodesArray:@[@0x00, @0x0437, @0x0417, @0x2018, @0x2019, @0x0417, @0x0417, @0x2018, @0x2019]];
        [_keyLabels setupKey:0x14 withCharCodesArray:@[@0x00, @0x0439, @0x0419, @0x0458, @0x0408, @0x0419, @0x0419, @0x0458, @0x0408]];
        [_keyLabels setupKey:0x15 withCharCodesArray:@[@0x00, @0x043A, @0x041A, @0x00AE, @0x00AE, @0x041A, @0x041A, @0x00AE, @0x00AE]];
        [_keyLabels setupKey:0x16 withCharCodesArray:@[@0x00, @0x044B, @0x042B, @0x044B, @0x042B, @0x042B, @0x042B, @0x044B, @0x042B]];
        [_keyLabels setupKey:0x17 withCharCodesArray:@[@0x00, @0x0435, @0x0415, @0x2020, @0x2020, @0x0415, @0x0415, @0x2020, @0x2020]];
        [_keyLabels setupKey:0x18 withCharCodesArray:@[@0x00, @0x0433, @0x0413, @0x0453, @0x0403, @0x0413, @0x0413, @0x0453, @0x0403]];
        [_keyLabels setupKey:0x19 withCharCodesArray:@[@0x00, @0x043C, @0x041C, @0x00B5, @0x00B5, @0x041C, @0x041C, @0x00B5, @0x00B5]];
        [_keyLabels setupKey:0x1A withCharCodesArray:@[@0x00, @0x0446, @0x0426, @0x045F, @0x040F, @0x0426, @0x0426, @0x045F, @0x040F]];
        [_keyLabels setupKey:0x1B withCharCodesArray:@[@0x00, @0x0447, @0x0427, @0x2248, @0x2248, @0x0427, @0x0427, @0x2248, @0x2248]];
        [_keyLabels setupKey:0x1C withCharCodesArray:@[@0x00, @0x043D, @0x041D, @0x045A, @0x040A, @0x041D, @0x041D, @0x045A, @0x040A]];
        [_keyLabels setupKey:0x1D withCharCodesArray:@[@0x00, @0x044F, @0x042F, @0x0452, @0x0402, @0x042F, @0x042F, @0x0452, @0x0402]];
        [_keyLabels setupKey:0x1E withCharCodesArray:@[@0x00, @0x0031, @0x0021, @0x0021, @0x007C, @0x0031, @0x0021, @0x0021, @0x007C]];
        [_keyLabels setupKey:0x1F withCharCodesArray:@[@0x00, @0x0032, @0x0022, @0x0040, @0x0022, @0x0032, @0x0022, @0x0040, @0x0022]];
        [_keyLabels setupKey:0x20 withCharCodesArray:@[@0x00, @0x0033, @0x2116, @0x0023, @0x00A3, @0x0033, @0x2116, @0x0023, @0x00A3]];
        [_keyLabels setupKey:0x21 withCharCodesArray:@[@0x00, @0x0034, @0x0025, @0x0024, @0x20AC, @0x0034, @0x0025, @0x0024, @0x20AC]];
        [_keyLabels setupKey:0x22 withCharCodesArray:@[@0x00, @0x0035, @0x003A, @0x0025, @0x221E, @0x0035, @0x003A, @0x0025, @0x221E]];
        [_keyLabels setupKey:0x23 withCharCodesArray:@[@0x00, @0x0036, @0x002C, @0x005E, @0x00AC, @0x0036, @0x002C, @0x005E, @0x00AC]];
        [_keyLabels setupKey:0x24 withCharCodesArray:@[@0x00, @0x0037, @0x002E, @0x0026, @0x00B6, @0x0037, @0x002E, @0x0026, @0x00B6]];
        [_keyLabels setupKey:0x25 withCharCodesArray:@[@0x00, @0x0038, @0x003B, @0x002A, @0x221A, @0x0038, @0x003B, @0x002A, @0x221A]];
        [_keyLabels setupKey:0x26 withCharCodesArray:@[@0x00, @0x0039, @0x0028, @0x007B, @0x0027, @0x0039, @0x0028, @0x007B, @0x0027]];
        [_keyLabels setupKey:0x27 withCharCodesArray:@[@0x00, @0x0030, @0x0029, @0x007D, @0x0060, @0x0030, @0x0029, @0x007D, @0x0060]];
        [_keyLabels setupKey:0x2D withCharCodesArray:@[@0x00, @0x002D, @0x005F, @0x2013, @0x2014, @0x002D, @0x005F, @0x2013, @0x2014]];
        [_keyLabels setupKey:0x2E withCharCodesArray:@[@0x00, @0x003D, @0x002B, @0x00BB, @0x00AB, @0x003D, @0x002B, @0x00BB, @0x00AB]];
        [_keyLabels setupKey:0x2F withCharCodesArray:@[@0x00, @0x0445, @0x0425, @0x201C, @0x201D, @0x0425, @0x0425, @0x201C, @0x201D]];
        [_keyLabels setupKey:0x30 withCharCodesArray:@[@0x00, @0x044A, @0x042A, @0x044A, @0x042A, @0x042A, @0x042A, @0x044A, @0x042A]];
        [_keyLabels setupKey:0x31 withCharCodesArray:@[@0x00, @0x0451, @0x0401, @0x0451, @0x0401, @0x0401, @0x0401, @0x0451, @0x0401]];
        [_keyLabels setupKey:0x33 withCharCodesArray:@[@0x00, @0x0436, @0x0416, @0x2026, @0x2026, @0x0416, @0x0416, @0x2026, @0x2026]];
        [_keyLabels setupKey:0x34 withCharCodesArray:@[@0x00, @0x044D, @0x042D, @0x044D, @0x042D, @0x042D, @0x042D, @0x044D, @0x042D]];
        [_keyLabels setupKey:0x35 withCharCodesArray:@[@0x00, @0x005D, @0x005B, @0x005D, @0x005B, @0x005D, @0x005B, @0x005D, @0x005B]];
        [_keyLabels setupKey:0x36 withCharCodesArray:@[@0x00, @0x0431, @0x0411, @0x2264, @0x003C, @0x0411, @0x0411, @0x2264, @0x003C]];
        [_keyLabels setupKey:0x37 withCharCodesArray:@[@0x00, @0x044E, @0x042E, @0x2265, @0x003E, @0x042E, @0x042E, @0x2265, @0x003E]];
        [_keyLabels setupKey:0x38 withCharCodesArray:@[@0x00, @0x002F, @0x003F, @0x201C, @0x201E, @0x002F, @0x003F, @0x201C, @0x201E]];
    }
    return _keyLabels;
}

@end
