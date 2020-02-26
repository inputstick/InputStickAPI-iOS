/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */
 
#import "InputStickKeyboardLayoutHeIL.h"
#import "InputStickKeyboardKeyModel.h"

static NSString *const LocaleName =  @"he-IL";
static NSString *const NativeName =  @"עִבְרִית";
static NSString *const EnglishName = @"Hebrew";
static NSString *const Variant =     @"IL";
static InputStickKeyboardType const Type = KEYBOARD_ANSI;

@implementation InputStickKeyboardLayoutHeIL

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

//he-IL
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
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 35: //#
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 36: //$
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 37: //%
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 38: //&
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 39: //'
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 40: //(
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 41: //)
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 42: //*
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 43: //+
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 44: //,
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 45: //-
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 46: //.
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 47: ///
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:0 deadkey:0 deadkeyModifiers:0];
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
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 59: //;
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 60: // <
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 61: //=
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 62: //>
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 63: //?
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 64: //@
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 65: //A
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 66: //B
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 67: //C
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 68: //D
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 69: //E
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 70: //F
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 71: //G
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 72: //H
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 73: //I
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 74: //J
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 75: //K
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 76: //L
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 77: //M
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 78: //N
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 79: //O
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 80: //P
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 81: //Q
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 82: //R
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 83: //S
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 84: //T
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 85: //U
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 86: //V
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 87: //W
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 88: //X
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 89: //Y
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 90: //Z
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 91: //[
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 92: //backslash
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 93: //]
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 94: //^
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 95: //_
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 123: //{
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 124: //|
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 125: //}
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 126: //~
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 1471: //ֿ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:66 deadkey:0 deadkeyModifiers:0];
            break;
        case 1488: //א
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1489: //ב
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1490: //ג
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1491: //ד
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1492: //ה
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1493: //ו
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1494: //ז
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1495: //ח
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1496: //ט
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1497: //י
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1498: //ך
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1499: //כ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1500: //ל
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1501: //ם
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1502: //מ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1503: //ן
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1504: //נ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1505: //ס
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1506: //ע
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1507: //ף
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1508: //פ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1509: //ץ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1510: //צ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1511: //ק
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1512: //ר
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1513: //ש
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1514: //ת
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 1520: //װ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:66 deadkey:0 deadkeyModifiers:0];
            break;
        case 1521: //ױ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:66 deadkey:0 deadkeyModifiers:0];
            break;
        case 1522: //ײ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:66 deadkey:0 deadkeyModifiers:0];
            break;
        case 8206: //‎
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 8207: //‏
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 8362: //₪
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:66 deadkey:0 deadkeyModifiers:0];
            break;
        case 8364: //€
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:66 deadkey:0 deadkeyModifiers:0];
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
    [array addObject:[NSNumber numberWithInteger:35]];
    [array addObject:[NSNumber numberWithInteger:36]];
    [array addObject:[NSNumber numberWithInteger:37]];
    [array addObject:[NSNumber numberWithInteger:38]];
    [array addObject:[NSNumber numberWithInteger:39]];
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
    [array addObject:[NSNumber numberWithInteger:60]];
    [array addObject:[NSNumber numberWithInteger:61]];
    [array addObject:[NSNumber numberWithInteger:62]];
    [array addObject:[NSNumber numberWithInteger:63]];
    [array addObject:[NSNumber numberWithInteger:64]];
    [array addObject:[NSNumber numberWithInteger:65]];
    [array addObject:[NSNumber numberWithInteger:66]];
    [array addObject:[NSNumber numberWithInteger:67]];
    [array addObject:[NSNumber numberWithInteger:68]];
    [array addObject:[NSNumber numberWithInteger:69]];
    [array addObject:[NSNumber numberWithInteger:70]];
    [array addObject:[NSNumber numberWithInteger:71]];
    [array addObject:[NSNumber numberWithInteger:72]];
    [array addObject:[NSNumber numberWithInteger:73]];
    [array addObject:[NSNumber numberWithInteger:74]];
    [array addObject:[NSNumber numberWithInteger:75]];
    [array addObject:[NSNumber numberWithInteger:76]];
    [array addObject:[NSNumber numberWithInteger:77]];
    [array addObject:[NSNumber numberWithInteger:78]];
    [array addObject:[NSNumber numberWithInteger:79]];
    [array addObject:[NSNumber numberWithInteger:80]];
    [array addObject:[NSNumber numberWithInteger:81]];
    [array addObject:[NSNumber numberWithInteger:82]];
    [array addObject:[NSNumber numberWithInteger:83]];
    [array addObject:[NSNumber numberWithInteger:84]];
    [array addObject:[NSNumber numberWithInteger:85]];
    [array addObject:[NSNumber numberWithInteger:86]];
    [array addObject:[NSNumber numberWithInteger:87]];
    [array addObject:[NSNumber numberWithInteger:88]];
    [array addObject:[NSNumber numberWithInteger:89]];
    [array addObject:[NSNumber numberWithInteger:90]];
    [array addObject:[NSNumber numberWithInteger:91]];
    [array addObject:[NSNumber numberWithInteger:92]];
    [array addObject:[NSNumber numberWithInteger:93]];
    [array addObject:[NSNumber numberWithInteger:94]];
    [array addObject:[NSNumber numberWithInteger:95]];
    [array addObject:[NSNumber numberWithInteger:123]];
    [array addObject:[NSNumber numberWithInteger:124]];
    [array addObject:[NSNumber numberWithInteger:125]];
    [array addObject:[NSNumber numberWithInteger:126]];
    [array addObject:[NSNumber numberWithInteger:1471]];
    [array addObject:[NSNumber numberWithInteger:1488]];
    [array addObject:[NSNumber numberWithInteger:1489]];
    [array addObject:[NSNumber numberWithInteger:1490]];
    [array addObject:[NSNumber numberWithInteger:1491]];
    [array addObject:[NSNumber numberWithInteger:1492]];
    [array addObject:[NSNumber numberWithInteger:1493]];
    [array addObject:[NSNumber numberWithInteger:1494]];
    [array addObject:[NSNumber numberWithInteger:1495]];
    [array addObject:[NSNumber numberWithInteger:1496]];
    [array addObject:[NSNumber numberWithInteger:1497]];
    [array addObject:[NSNumber numberWithInteger:1498]];
    [array addObject:[NSNumber numberWithInteger:1499]];
    [array addObject:[NSNumber numberWithInteger:1500]];
    [array addObject:[NSNumber numberWithInteger:1501]];
    [array addObject:[NSNumber numberWithInteger:1502]];
    [array addObject:[NSNumber numberWithInteger:1503]];
    [array addObject:[NSNumber numberWithInteger:1504]];
    [array addObject:[NSNumber numberWithInteger:1505]];
    [array addObject:[NSNumber numberWithInteger:1506]];
    [array addObject:[NSNumber numberWithInteger:1507]];
    [array addObject:[NSNumber numberWithInteger:1508]];
    [array addObject:[NSNumber numberWithInteger:1509]];
    [array addObject:[NSNumber numberWithInteger:1510]];
    [array addObject:[NSNumber numberWithInteger:1511]];
    [array addObject:[NSNumber numberWithInteger:1512]];
    [array addObject:[NSNumber numberWithInteger:1513]];
    [array addObject:[NSNumber numberWithInteger:1514]];
    [array addObject:[NSNumber numberWithInteger:1520]];
    [array addObject:[NSNumber numberWithInteger:1521]];
    [array addObject:[NSNumber numberWithInteger:1522]];
    [array addObject:[NSNumber numberWithInteger:8206]];
    [array addObject:[NSNumber numberWithInteger:8207]];
    [array addObject:[NSNumber numberWithInteger:8362]];
    [array addObject:[NSNumber numberWithInteger:8364]];
    return array;
}

+ (NSArray *)getLUT {
    NSMutableArray *lut = [[NSMutableArray alloc] init];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  49], [NSNumber numberWithInt:  33], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  50], [NSNumber numberWithInt:  64], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  51], [NSNumber numberWithInt:  35], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:8206], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  52], [NSNumber numberWithInt:  36], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:8207], [NSNumber numberWithInt:8362], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  53], [NSNumber numberWithInt:  37], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  54], [NSNumber numberWithInt:  94], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  55], [NSNumber numberWithInt:  38], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  56], [NSNumber numberWithInt:  42], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  57], [NSNumber numberWithInt:  41], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  48], [NSNumber numberWithInt:  40], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  45], [NSNumber numberWithInt:  95], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:1471], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  61], [NSNumber numberWithInt:  43], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:  47], [NSNumber numberWithInt:  81], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:  39], [NSNumber numberWithInt:  87], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1511], [NSNumber numberWithInt:  69], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:8364], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1512], [NSNumber numberWithInt:  82], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1488], [NSNumber numberWithInt:  84], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1496], [NSNumber numberWithInt:  89], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1493], [NSNumber numberWithInt:  85], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:1520], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1503], [NSNumber numberWithInt:  73], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1501], [NSNumber numberWithInt:  79], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1508], [NSNumber numberWithInt:  80], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  93], [NSNumber numberWithInt: 125], [NSNumber numberWithInt:8206], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  91], [NSNumber numberWithInt: 123], [NSNumber numberWithInt:8207], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1513], [NSNumber numberWithInt:  65], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1491], [NSNumber numberWithInt:  83], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1490], [NSNumber numberWithInt:  68], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1499], [NSNumber numberWithInt:  70], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1506], [NSNumber numberWithInt:  71], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1497], [NSNumber numberWithInt:  72], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:1522], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1495], [NSNumber numberWithInt:  74], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:1521], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1500], [NSNumber numberWithInt:  75], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1498], [NSNumber numberWithInt:  76], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:1507], [NSNumber numberWithInt:  58], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  44], [NSNumber numberWithInt:  34], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  59], [NSNumber numberWithInt: 126], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  92], [NSNumber numberWithInt: 124], [NSNumber numberWithInt:  28], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1494], [NSNumber numberWithInt:  90], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1505], [NSNumber numberWithInt:  88], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1489], [NSNumber numberWithInt:  67], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1492], [NSNumber numberWithInt:  86], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1504], [NSNumber numberWithInt:  66], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1502], [NSNumber numberWithInt:  78], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt:1510], [NSNumber numberWithInt:  77], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:1514], [NSNumber numberWithInt:  62], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:1509], [NSNumber numberWithInt:  60], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  46], [NSNumber numberWithInt:  63], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
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
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  46], [NSNumber numberWithInt:  46], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  92], [NSNumber numberWithInt: 124], [NSNumber numberWithInt:  28], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
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
