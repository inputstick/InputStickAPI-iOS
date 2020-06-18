/*
 * InputStickAPI-iOS
 * Copyright (c) 2020 Jakub Zawadzki, www.inputstick.com
 */
 
#import "InputStickKeyboardLayoutRuRU.h"
#import "InputStickKeyboardKeyModel.h"
#import "InputStickKeyLabels.h"

//InputStickKeyboardLayoutGenerator v1.00

@interface InputStickKeyboardLayoutRuRU () {
    InputStickKeyLabels *_keyLabels;
    NSArray<NSNumber *> *_availableCharactersLUT;
}

@end


@implementation InputStickKeyboardLayoutRuRU

- (NSString *)layoutCode {
    return @"ru-RU";
}

- (NSString *)layoutCodeLowercase {
    return @"ru-ru";
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
    return @"RU";
}

- (NSString *)layoutDisplayName {
    return @"Russian, RU";
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
            case 37: // %
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 40: // (
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 41: // )
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 42: // *
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 43: // +
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 44: // ,
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 45: // -
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 46: // .
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 47: // /
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:2 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 59: // ;
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 61: // =
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 63: // ?
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 92: // backslash
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 95: // _
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 1025: // Ё
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:2 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 8381: // ₽
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8470: // №
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
    }
    return keyboardKeyModel;
}

- (NSString *)availableCharactersString {
    //\t\n !"%()*+,-./0123456789:;=?\_ЁАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюяё₽№
    return @"\t\n !\"%()*+,-./0123456789:;=?\\_\u0401\u0410\u0411\u0412\u0413\u0414\u0415\u0416\u0417\u0418\u0419\u041A\u041B\u041C\u041D\u041E\u041F\u0420\u0421\u0422\u0423\u0424\u0425\u0426\u0427\u0428\u0429\u042A\u042B\u042C\u042D\u042E\u042F\u0430\u0431\u0432\u0433\u0434\u0435\u0436\u0437\u0438\u0439\u043A\u043B\u043C\u043D\u043E\u043F\u0440\u0441\u0442\u0443\u0444\u0445\u0446\u0447\u0448\u0449\u044A\u044B\u044C\u044D\u044E\u044F\u0451\u20BD\u2116";
}

- (NSArray<NSNumber *> *)availableCharactersLUT {
    if (_availableCharactersLUT == nil) {
        NSLog(@"create LUT");
        NSMutableArray<NSNumber *> *lut = [NSMutableArray array];
        [lut addObject:[NSNumber numberWithInteger:0]];
        [lut addObject:[NSNumber numberWithInteger:9]];
        [lut addObject:[NSNumber numberWithInteger:10]];
        [lut addObject:[NSNumber numberWithInteger:33]];
        [lut addObject:[NSNumber numberWithInteger:34]];
        [lut addObject:[NSNumber numberWithInteger:37]];
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
        [lut addObject:[NSNumber numberWithInteger:61]];
        [lut addObject:[NSNumber numberWithInteger:63]];
        [lut addObject:[NSNumber numberWithInteger:92]];
        [lut addObject:[NSNumber numberWithInteger:95]];
        [lut addObject:[NSNumber numberWithInteger:1025]];
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
        [lut addObject:[NSNumber numberWithInteger:8381]];
        [lut addObject:[NSNumber numberWithInteger:8470]];
        _availableCharactersLUT = lut;
    }
    return _availableCharactersLUT;
}

- (InputStickKeyLabels *)keyLabels {
    if (_keyLabels == nil) {
        _keyLabels = [[InputStickKeyLabels alloc] init];
        [_keyLabels setupKey:0x04 withCharCodesArray:@[@0x00, @0x0444, @0x0424, @0x0000, @0x0000, @0x0424, @0x0444, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x05 withCharCodesArray:@[@0x00, @0x0438, @0x0418, @0x0000, @0x0000, @0x0418, @0x0438, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x06 withCharCodesArray:@[@0x00, @0x0441, @0x0421, @0x0000, @0x0000, @0x0421, @0x0441, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x07 withCharCodesArray:@[@0x00, @0x0432, @0x0412, @0x0000, @0x0000, @0x0412, @0x0432, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x08 withCharCodesArray:@[@0x00, @0x0443, @0x0423, @0x0000, @0x0000, @0x0423, @0x0443, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x09 withCharCodesArray:@[@0x00, @0x0430, @0x0410, @0x0000, @0x0000, @0x0410, @0x0430, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x0A withCharCodesArray:@[@0x00, @0x043F, @0x041F, @0x0000, @0x0000, @0x041F, @0x043F, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x0B withCharCodesArray:@[@0x00, @0x0440, @0x0420, @0x0000, @0x0000, @0x0420, @0x0440, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x0C withCharCodesArray:@[@0x00, @0x0448, @0x0428, @0x0000, @0x0000, @0x0428, @0x0448, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x0D withCharCodesArray:@[@0x00, @0x043E, @0x041E, @0x0000, @0x0000, @0x041E, @0x043E, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x0E withCharCodesArray:@[@0x00, @0x043B, @0x041B, @0x0000, @0x0000, @0x041B, @0x043B, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x0F withCharCodesArray:@[@0x00, @0x0434, @0x0414, @0x0000, @0x0000, @0x0414, @0x0434, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x10 withCharCodesArray:@[@0x00, @0x044C, @0x042C, @0x0000, @0x0000, @0x042C, @0x044C, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x11 withCharCodesArray:@[@0x00, @0x0442, @0x0422, @0x0000, @0x0000, @0x0422, @0x0442, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x12 withCharCodesArray:@[@0x00, @0x0449, @0x0429, @0x0000, @0x0000, @0x0429, @0x0449, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x13 withCharCodesArray:@[@0x00, @0x0437, @0x0417, @0x0000, @0x0000, @0x0417, @0x0437, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x14 withCharCodesArray:@[@0x00, @0x0439, @0x0419, @0x0000, @0x0000, @0x0419, @0x0439, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x15 withCharCodesArray:@[@0x00, @0x043A, @0x041A, @0x0000, @0x0000, @0x041A, @0x043A, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x16 withCharCodesArray:@[@0x00, @0x044B, @0x042B, @0x0000, @0x0000, @0x042B, @0x044B, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x17 withCharCodesArray:@[@0x00, @0x0435, @0x0415, @0x0000, @0x0000, @0x0415, @0x0435, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x18 withCharCodesArray:@[@0x00, @0x0433, @0x0413, @0x0000, @0x0000, @0x0413, @0x0433, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x19 withCharCodesArray:@[@0x00, @0x043C, @0x041C, @0x0000, @0x0000, @0x041C, @0x043C, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x1A withCharCodesArray:@[@0x00, @0x0446, @0x0426, @0x0000, @0x0000, @0x0426, @0x0446, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x1B withCharCodesArray:@[@0x00, @0x0447, @0x0427, @0x0000, @0x0000, @0x0427, @0x0447, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x1C withCharCodesArray:@[@0x00, @0x043D, @0x041D, @0x0000, @0x0000, @0x041D, @0x043D, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x1D withCharCodesArray:@[@0x00, @0x044F, @0x042F, @0x0000, @0x0000, @0x042F, @0x044F, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x1E withCharCodesArray:@[@0x00, @0x0031, @0x0021, @0x0000, @0x0000, @0x0031, @0x0021, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x1F withCharCodesArray:@[@0x00, @0x0032, @0x0022, @0x0000, @0x0000, @0x0032, @0x0022, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x20 withCharCodesArray:@[@0x00, @0x0033, @0x2116, @0x0000, @0x0000, @0x0033, @0x2116, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x21 withCharCodesArray:@[@0x00, @0x0034, @0x003B, @0x0000, @0x0000, @0x0034, @0x003B, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x22 withCharCodesArray:@[@0x00, @0x0035, @0x0025, @0x0000, @0x0000, @0x0035, @0x0025, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x23 withCharCodesArray:@[@0x00, @0x0036, @0x003A, @0x0000, @0x0000, @0x0036, @0x003A, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x24 withCharCodesArray:@[@0x00, @0x0037, @0x003F, @0x0000, @0x0000, @0x0037, @0x003F, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x25 withCharCodesArray:@[@0x00, @0x0038, @0x002A, @0x20BD, @0x0000, @0x0038, @0x002A, @0x20BD, @0x0000]];
        [_keyLabels setupKey:0x26 withCharCodesArray:@[@0x00, @0x0039, @0x0028, @0x0000, @0x0000, @0x0039, @0x0028, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x27 withCharCodesArray:@[@0x00, @0x0030, @0x0029, @0x0000, @0x0000, @0x0030, @0x0029, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x2D withCharCodesArray:@[@0x00, @0x002D, @0x005F, @0x0000, @0x0000, @0x002D, @0x005F, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x2E withCharCodesArray:@[@0x00, @0x003D, @0x002B, @0x0000, @0x0000, @0x003D, @0x002B, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x2F withCharCodesArray:@[@0x00, @0x0445, @0x0425, @0x0000, @0x0000, @0x0425, @0x0445, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x30 withCharCodesArray:@[@0x00, @0x044A, @0x042A, @0x0000, @0x0000, @0x042A, @0x044A, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x31 withCharCodesArray:@[@0x00, @0x005C, @0x002F, @0x0000, @0x0000, @0x005C, @0x002F, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x33 withCharCodesArray:@[@0x00, @0x0436, @0x0416, @0x0000, @0x0000, @0x0416, @0x0436, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x34 withCharCodesArray:@[@0x00, @0x044D, @0x042D, @0x0000, @0x0000, @0x042D, @0x044D, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x35 withCharCodesArray:@[@0x00, @0x0451, @0x0401, @0x0000, @0x0000, @0x0401, @0x0451, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x36 withCharCodesArray:@[@0x00, @0x0431, @0x0411, @0x0000, @0x0000, @0x0411, @0x0431, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x37 withCharCodesArray:@[@0x00, @0x044E, @0x042E, @0x0000, @0x0000, @0x042E, @0x044E, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x38 withCharCodesArray:@[@0x00, @0x002E, @0x002C, @0x0000, @0x0000, @0x002E, @0x002C, @0x0000, @0x0000]];
    }
    return _keyLabels;
}

@end
