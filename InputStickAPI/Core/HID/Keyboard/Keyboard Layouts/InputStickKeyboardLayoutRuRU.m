/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */
 
#import "InputStickKeyboardLayoutRuRU.h"
#import "InputStickKeyboardKeyModel.h"

static NSString *const LocaleName =  @"ru-RU";
static NSString *const NativeName =  @"Русский";
static NSString *const EnglishName = @"Russian";
static NSString *const Variant =     @"RU";
static InputStickKeyboardType const Type = KEYBOARD_ANSI;

@implementation InputStickKeyboardLayoutRuRU

+ (NSString *)layoutCode {
    return LocaleName;
}

+ (NSString *)layoutCodeLowercase {
    return [[self layoutCode] lowercaseString];
}

+ (NSString *)layoutNativeName {
    return NativeName;
}

+ (NSString *)layoutEnglishName {
    return EnglishName;
}

+ (NSString *)layoutVariant {
    return Variant;
}

+ (NSString *)layoutFullName {
    return [NSString stringWithFormat:@"%@ (%@) [%@]", EnglishName, NativeName, Variant];
}

+ (InputStickKeyboardType)keyboardType {
    return Type;
}

//ru-RU
+ (InputStickKeyboardKeyModel *)getKeyModelForCharacter:(int)character {
    InputStickKeyboardKeyModel *keyboardKeyModel = nil;
    switch (character) {
        case 0: //empty
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:0 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 9: //tab
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:43 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 10: //enter
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:40 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 32: //space
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:44 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 33: //!
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 34: //"
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 37: //%
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 40: //(
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 41: //)
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 42: //*
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 43: //+
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 44: //,
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 45: //-
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 46: //.
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 47: ///
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 48: //0
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 49: //1
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 50: //2
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 51: //3
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 52: //4
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 53: //5
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 54: //6
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 55: //7
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 56: //8
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 57: //9
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 58: //:
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 59: //;
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 61: //=
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 63: //?
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 92: //backslash
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 95: //_
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1025: //Ё
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1040: //А
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1041: //Б
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1042: //В
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1043: //Г
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1044: //Д
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1045: //Е
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1046: //Ж
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1047: //З
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1048: //И
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1049: //Й
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1050: //К
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1051: //Л
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1052: //М
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1053: //Н
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1054: //О
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1055: //П
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1056: //Р
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1057: //С
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1058: //Т
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1059: //У
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1060: //Ф
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1061: //Х
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1062: //Ц
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1063: //Ч
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1064: //Ш
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1065: //Щ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1066: //Ъ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1067: //Ы
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1068: //Ь
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1069: //Э
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1070: //Ю
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1071: //Я
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1072: //а
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1073: //б
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1074: //в
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1075: //г
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1076: //д
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1077: //е
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1078: //ж
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1079: //з
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1080: //и
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1081: //й
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1082: //к
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1083: //л
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1084: //м
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1085: //н
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1086: //о
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1087: //п
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1088: //р
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1089: //с
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1090: //т
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1091: //у
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1092: //ф
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1093: //х
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1094: //ц
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1095: //ч
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1096: //ш
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1097: //щ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1098: //ъ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1099: //ы
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1100: //ь
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1101: //э
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1102: //ю
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1103: //я
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1105: //ё
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 8470: //№
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
    }
    return keyboardKeyModel;
}

+ (NSArray<NSNumber *> *)getAvailableCharacters {
    NSMutableArray<NSNumber *> *array = [NSMutableArray array];
    [array addObject:[NSNumber numberWithInteger:0]];
    [array addObject:[NSNumber numberWithInteger:9]];
    [array addObject:[NSNumber numberWithInteger:10]];
    [array addObject:[NSNumber numberWithInteger:28]];
    [array addObject:[NSNumber numberWithInteger:32]];
    [array addObject:[NSNumber numberWithInteger:33]];
    [array addObject:[NSNumber numberWithInteger:34]];
    [array addObject:[NSNumber numberWithInteger:37]];
    [array addObject:[NSNumber numberWithInteger:40]];
    [array addObject:[NSNumber numberWithInteger:41]];
    [array addObject:[NSNumber numberWithInteger:42]];
    [array addObject:[NSNumber numberWithInteger:43]];
    [array addObject:[NSNumber numberWithInteger:44]];
    [array addObject:[NSNumber numberWithInteger:45]];
    [array addObject:[NSNumber numberWithInteger:46]];
    [array addObject:[NSNumber numberWithInteger:47]];
    [array addObject:[NSNumber numberWithInteger:48]];
    [array addObject:[NSNumber numberWithInteger:49]];
    [array addObject:[NSNumber numberWithInteger:50]];
    [array addObject:[NSNumber numberWithInteger:51]];
    [array addObject:[NSNumber numberWithInteger:52]];
    [array addObject:[NSNumber numberWithInteger:53]];
    [array addObject:[NSNumber numberWithInteger:54]];
    [array addObject:[NSNumber numberWithInteger:55]];
    [array addObject:[NSNumber numberWithInteger:56]];
    [array addObject:[NSNumber numberWithInteger:57]];
    [array addObject:[NSNumber numberWithInteger:58]];
    [array addObject:[NSNumber numberWithInteger:59]];
    [array addObject:[NSNumber numberWithInteger:61]];
    [array addObject:[NSNumber numberWithInteger:63]];
    [array addObject:[NSNumber numberWithInteger:92]];
    [array addObject:[NSNumber numberWithInteger:95]];
    [array addObject:[NSNumber numberWithInteger:1025]];
    [array addObject:[NSNumber numberWithInteger:1040]];
    [array addObject:[NSNumber numberWithInteger:1041]];
    [array addObject:[NSNumber numberWithInteger:1042]];
    [array addObject:[NSNumber numberWithInteger:1043]];
    [array addObject:[NSNumber numberWithInteger:1044]];
    [array addObject:[NSNumber numberWithInteger:1045]];
    [array addObject:[NSNumber numberWithInteger:1046]];
    [array addObject:[NSNumber numberWithInteger:1047]];
    [array addObject:[NSNumber numberWithInteger:1048]];
    [array addObject:[NSNumber numberWithInteger:1049]];
    [array addObject:[NSNumber numberWithInteger:1050]];
    [array addObject:[NSNumber numberWithInteger:1051]];
    [array addObject:[NSNumber numberWithInteger:1052]];
    [array addObject:[NSNumber numberWithInteger:1053]];
    [array addObject:[NSNumber numberWithInteger:1054]];
    [array addObject:[NSNumber numberWithInteger:1055]];
    [array addObject:[NSNumber numberWithInteger:1056]];
    [array addObject:[NSNumber numberWithInteger:1057]];
    [array addObject:[NSNumber numberWithInteger:1058]];
    [array addObject:[NSNumber numberWithInteger:1059]];
    [array addObject:[NSNumber numberWithInteger:1060]];
    [array addObject:[NSNumber numberWithInteger:1061]];
    [array addObject:[NSNumber numberWithInteger:1062]];
    [array addObject:[NSNumber numberWithInteger:1063]];
    [array addObject:[NSNumber numberWithInteger:1064]];
    [array addObject:[NSNumber numberWithInteger:1065]];
    [array addObject:[NSNumber numberWithInteger:1066]];
    [array addObject:[NSNumber numberWithInteger:1067]];
    [array addObject:[NSNumber numberWithInteger:1068]];
    [array addObject:[NSNumber numberWithInteger:1069]];
    [array addObject:[NSNumber numberWithInteger:1070]];
    [array addObject:[NSNumber numberWithInteger:1071]];
    [array addObject:[NSNumber numberWithInteger:1072]];
    [array addObject:[NSNumber numberWithInteger:1073]];
    [array addObject:[NSNumber numberWithInteger:1074]];
    [array addObject:[NSNumber numberWithInteger:1075]];
    [array addObject:[NSNumber numberWithInteger:1076]];
    [array addObject:[NSNumber numberWithInteger:1077]];
    [array addObject:[NSNumber numberWithInteger:1078]];
    [array addObject:[NSNumber numberWithInteger:1079]];
    [array addObject:[NSNumber numberWithInteger:1080]];
    [array addObject:[NSNumber numberWithInteger:1081]];
    [array addObject:[NSNumber numberWithInteger:1082]];
    [array addObject:[NSNumber numberWithInteger:1083]];
    [array addObject:[NSNumber numberWithInteger:1084]];
    [array addObject:[NSNumber numberWithInteger:1085]];
    [array addObject:[NSNumber numberWithInteger:1086]];
    [array addObject:[NSNumber numberWithInteger:1087]];
    [array addObject:[NSNumber numberWithInteger:1088]];
    [array addObject:[NSNumber numberWithInteger:1089]];
    [array addObject:[NSNumber numberWithInteger:1090]];
    [array addObject:[NSNumber numberWithInteger:1091]];
    [array addObject:[NSNumber numberWithInteger:1092]];
    [array addObject:[NSNumber numberWithInteger:1093]];
    [array addObject:[NSNumber numberWithInteger:1094]];
    [array addObject:[NSNumber numberWithInteger:1095]];
    [array addObject:[NSNumber numberWithInteger:1096]];
    [array addObject:[NSNumber numberWithInteger:1097]];
    [array addObject:[NSNumber numberWithInteger:1098]];
    [array addObject:[NSNumber numberWithInteger:1099]];
    [array addObject:[NSNumber numberWithInteger:1100]];
    [array addObject:[NSNumber numberWithInteger:1101]];
    [array addObject:[NSNumber numberWithInteger:1102]];
    [array addObject:[NSNumber numberWithInteger:1103]];
    [array addObject:[NSNumber numberWithInteger:1105]];
    [array addObject:[NSNumber numberWithInteger:8470]];
    return array;
}

+ (NSArray *)getLUT {
    NSMutableArray *lut = [[NSMutableArray alloc] init];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  49], [NSNumber numberWithInt:  33], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  50], [NSNumber numberWithInt:  34], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  51], [NSNumber numberWithInt:8470], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  52], [NSNumber numberWithInt:  59], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  53], [NSNumber numberWithInt:  37], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  54], [NSNumber numberWithInt:  58], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  55], [NSNumber numberWithInt:  63], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  56], [NSNumber numberWithInt:  42], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  57], [NSNumber numberWithInt:  40], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  48], [NSNumber numberWithInt:  41], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  45], [NSNumber numberWithInt:  95], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  61], [NSNumber numberWithInt:  43], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1081], [NSNumber numberWithInt:1049], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1094], [NSNumber numberWithInt:1062], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1091], [NSNumber numberWithInt:1059], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1082], [NSNumber numberWithInt:1050], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1077], [NSNumber numberWithInt:1045], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1085], [NSNumber numberWithInt:1053], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1075], [NSNumber numberWithInt:1043], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1096], [NSNumber numberWithInt:1064], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1097], [NSNumber numberWithInt:1065], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1079], [NSNumber numberWithInt:1047], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1093], [NSNumber numberWithInt:1061], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1098], [NSNumber numberWithInt:1066], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1092], [NSNumber numberWithInt:1060], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1099], [NSNumber numberWithInt:1067], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1074], [NSNumber numberWithInt:1042], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1072], [NSNumber numberWithInt:1040], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1087], [NSNumber numberWithInt:1055], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1088], [NSNumber numberWithInt:1056], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1086], [NSNumber numberWithInt:1054], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1083], [NSNumber numberWithInt:1051], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1076], [NSNumber numberWithInt:1044], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1078], [NSNumber numberWithInt:1046], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1101], [NSNumber numberWithInt:1069], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1105], [NSNumber numberWithInt:1025], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  92], [NSNumber numberWithInt:  47], [NSNumber numberWithInt:  28], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1103], [NSNumber numberWithInt:1071], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1095], [NSNumber numberWithInt:1063], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1089], [NSNumber numberWithInt:1057], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1084], [NSNumber numberWithInt:1052], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1080], [NSNumber numberWithInt:1048], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1090], [NSNumber numberWithInt:1058], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1100], [NSNumber numberWithInt:1068], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1073], [NSNumber numberWithInt:1041], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1102], [NSNumber numberWithInt:1070], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  46], [NSNumber numberWithInt:  44], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  32], [NSNumber numberWithInt:  32], [NSNumber numberWithInt:  32], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  44], [NSNumber numberWithInt:  44], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  92], [NSNumber numberWithInt:  47], [NSNumber numberWithInt:  28], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    return lut;
}


@end
