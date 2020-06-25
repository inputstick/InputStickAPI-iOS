/*
 * InputStickAPI-iOS
 * Copyright (c) 2020 Jakub Zawadzki, www.inputstick.com
 */
 
#import "InputStickKeyboardLayoutElGRMac.h"
#import "InputStickKeyboardKeyModel.h"
#import "InputStickKeyLabels.h"

//InputStickKeyboardLayoutGenerator v1.00

@interface InputStickKeyboardLayoutElGRMac () {
    InputStickKeyLabels *_keyLabels;
    NSArray<NSNumber *> *_availableCharactersLUT;
}

@end


@implementation InputStickKeyboardLayoutElGRMac

- (NSString *)layoutCode {
    return @"el-GR-mac";
}

- (NSString *)layoutCodeLowercase {
    return @"el-gr-mac";
}

- (NSString *)layoutLanguageCode {
    return @"el";
}

- (NSString *)layoutLanguageNativeName {
    return @"Ελληνικά";
}

- (NSString *)layoutLanguageEnglishName {
    return @"Greek";
}

- (NSString *)layoutCountryCode {
    return @"GR";
}

- (NSString *)layoutCountryNativeName {
    return @"Ελλάδα";
}

- (NSString *)layoutCountryEnglishName {
    return @"Greece";
}

- (NSString *)layoutVariant {
    return @"GR macOS";
}

- (NSString *)layoutDisplayName {
    return @"Greek, GR macOS";
}

- (InputStickKeyboardType)keyboardType {
    return KEYBOARD_ISO;
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 35: // #
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 36: // $
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 37: // %
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 38: // &
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 39: // '
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:0 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 45: // -
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 46: // .
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:0 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 59: // ;
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 60: // <
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 61: // =
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 62: // >
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 63: // ?
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 64: // @
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 91: // [
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 92: // backslash
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 93: // ]
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 94: // ^
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 95: // _
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 96: // `
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:100 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 123: // {
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 124: // |
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 125: // }
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 126: // ~
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:100 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 163: // £
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 165: // ¥
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 166: // ¦
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 167: // §
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 168: // ¨
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:44 modifiers:0 deadkey:51 deadkeyModifiers:2];
                break;
            case 169: // ©
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 171: // «
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 172: // ¬
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 173: // ­
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 174: // ®
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 176: // °
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 177: // ±
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 178: // ²
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 179: // ³
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 182: // ¶
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 183: // ·
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 185: // ¹
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 187: // »
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 189: // ½
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 223: // ß
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 231: // ç
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 247: // ÷
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 339: // œ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 900: // ΄
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:44 modifiers:0 deadkey:51 deadkeyModifiers:0];
                break;
            case 901: // ΅
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:44 modifiers:0 deadkey:26 deadkeyModifiers:2];
                break;
            case 902: // Ά
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:51 deadkeyModifiers:0];
                break;
            case 904: // Έ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:51 deadkeyModifiers:0];
                break;
            case 905: // Ή
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:51 deadkeyModifiers:0];
                break;
            case 906: // Ί
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:51 deadkeyModifiers:0];
                break;
            case 908: // Ό
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:51 deadkeyModifiers:0];
                break;
            case 910: // Ύ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:51 deadkeyModifiers:0];
                break;
            case 911: // Ώ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:2 deadkey:51 deadkeyModifiers:0];
                break;
            case 912: // ΐ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:26 deadkeyModifiers:2];
                break;
            case 913: // Α
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 914: // Β
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 915: // Γ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 916: // Δ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 917: // Ε
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 918: // Ζ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 919: // Η
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 920: // Θ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 921: // Ι
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 922: // Κ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 923: // Λ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 924: // Μ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 925: // Ν
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 926: // Ξ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 927: // Ο
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 928: // Π
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 929: // Ρ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 931: // Σ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 932: // Τ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 933: // Υ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 934: // Φ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 935: // Χ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 936: // Ψ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 937: // Ω
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 938: // Ϊ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:51 deadkeyModifiers:2];
                break;
            case 939: // Ϋ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:51 deadkeyModifiers:2];
                break;
            case 940: // ά
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:51 deadkeyModifiers:0];
                break;
            case 941: // έ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:51 deadkeyModifiers:0];
                break;
            case 942: // ή
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:51 deadkeyModifiers:0];
                break;
            case 943: // ί
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:51 deadkeyModifiers:0];
                break;
            case 944: // ΰ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:26 deadkeyModifiers:2];
                break;
            case 945: // α
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 946: // β
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 947: // γ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 948: // δ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 949: // ε
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 950: // ζ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 951: // η
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 952: // θ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 953: // ι
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 954: // κ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 955: // λ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 956: // μ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 957: // ν
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 958: // ξ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 959: // ο
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 960: // π
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 961: // ρ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 962: // ς
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 963: // σ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 964: // τ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 965: // υ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 966: // φ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 967: // χ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 968: // ψ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 969: // ω
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 970: // ϊ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:51 deadkeyModifiers:2];
                break;
            case 971: // ϋ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:51 deadkeyModifiers:2];
                break;
            case 972: // ό
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:51 deadkeyModifiers:0];
                break;
            case 973: // ύ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:51 deadkeyModifiers:0];
                break;
            case 974: // ώ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:0 deadkey:51 deadkeyModifiers:0];
                break;
            case 8213: // ―
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8216: // ‘
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8217: // ’
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8220: // “
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8224: // †
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8226: // •
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8230: // …
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8364: // €
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8482: // ™
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8776: // ≈
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8800: // ≠
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8804: // ≤
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8805: // ≥
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
    }
    return keyboardKeyModel;
}

- (NSString *)availableCharactersString {
    //\t\n !"#$%&'()*+,-./0123456789:;<=>?@[\]^_`{|}~£¥¦§¨©«¬­®°±²³¶·¹»½ßç÷œ΄΅ΆΈΉΊΌΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώ―‘’“†•…€™≈≠≤≥
    return @"\t\n !\"#$%&\'()*+,-./0123456789:;<=>?@[\\]^_`{|}~\u00A3\u00A5\u00A6\u00A7\u00A8\u00A9\u00AB\u00AC\u00AD\u00AE\u00B0\u00B1\u00B2\u00B3\u00B6\u00B7\u00B9\u00BB\u00BD\u00DF\u00E7\u00F7\u0153\u0384\u0385\u0386\u0388\u0389\u038A\u038C\u038E\u038F\u0390\u0391\u0392\u0393\u0394\u0395\u0396\u0397\u0398\u0399\u039A\u039B\u039C\u039D\u039E\u039F\u03A0\u03A1\u03A3\u03A4\u03A5\u03A6\u03A7\u03A8\u03A9\u03AA\u03AB\u03AC\u03AD\u03AE\u03AF\u03B0\u03B1\u03B2\u03B3\u03B4\u03B5\u03B6\u03B7\u03B8\u03B9\u03BA\u03BB\u03BC\u03BD\u03BE\u03BF\u03C0\u03C1\u03C2\u03C3\u03C4\u03C5\u03C6\u03C7\u03C8\u03C9\u03CA\u03CB\u03CC\u03CD\u03CE\u2015\u2018\u2019\u201C\u2020\u2022\u2026\u20AC\u2122\u2248\u2260\u2264\u2265";
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
        [lut addObject:[NSNumber numberWithInteger:92]];
        [lut addObject:[NSNumber numberWithInteger:93]];
        [lut addObject:[NSNumber numberWithInteger:94]];
        [lut addObject:[NSNumber numberWithInteger:95]];
        [lut addObject:[NSNumber numberWithInteger:96]];
        [lut addObject:[NSNumber numberWithInteger:123]];
        [lut addObject:[NSNumber numberWithInteger:124]];
        [lut addObject:[NSNumber numberWithInteger:125]];
        [lut addObject:[NSNumber numberWithInteger:126]];
        [lut addObject:[NSNumber numberWithInteger:163]];
        [lut addObject:[NSNumber numberWithInteger:165]];
        [lut addObject:[NSNumber numberWithInteger:166]];
        [lut addObject:[NSNumber numberWithInteger:167]];
        [lut addObject:[NSNumber numberWithInteger:168]];
        [lut addObject:[NSNumber numberWithInteger:169]];
        [lut addObject:[NSNumber numberWithInteger:171]];
        [lut addObject:[NSNumber numberWithInteger:172]];
        [lut addObject:[NSNumber numberWithInteger:173]];
        [lut addObject:[NSNumber numberWithInteger:174]];
        [lut addObject:[NSNumber numberWithInteger:176]];
        [lut addObject:[NSNumber numberWithInteger:177]];
        [lut addObject:[NSNumber numberWithInteger:178]];
        [lut addObject:[NSNumber numberWithInteger:179]];
        [lut addObject:[NSNumber numberWithInteger:182]];
        [lut addObject:[NSNumber numberWithInteger:183]];
        [lut addObject:[NSNumber numberWithInteger:185]];
        [lut addObject:[NSNumber numberWithInteger:187]];
        [lut addObject:[NSNumber numberWithInteger:189]];
        [lut addObject:[NSNumber numberWithInteger:223]];
        [lut addObject:[NSNumber numberWithInteger:231]];
        [lut addObject:[NSNumber numberWithInteger:247]];
        [lut addObject:[NSNumber numberWithInteger:339]];
        [lut addObject:[NSNumber numberWithInteger:900]];
        [lut addObject:[NSNumber numberWithInteger:901]];
        [lut addObject:[NSNumber numberWithInteger:902]];
        [lut addObject:[NSNumber numberWithInteger:904]];
        [lut addObject:[NSNumber numberWithInteger:905]];
        [lut addObject:[NSNumber numberWithInteger:906]];
        [lut addObject:[NSNumber numberWithInteger:908]];
        [lut addObject:[NSNumber numberWithInteger:910]];
        [lut addObject:[NSNumber numberWithInteger:911]];
        [lut addObject:[NSNumber numberWithInteger:912]];
        [lut addObject:[NSNumber numberWithInteger:913]];
        [lut addObject:[NSNumber numberWithInteger:914]];
        [lut addObject:[NSNumber numberWithInteger:915]];
        [lut addObject:[NSNumber numberWithInteger:916]];
        [lut addObject:[NSNumber numberWithInteger:917]];
        [lut addObject:[NSNumber numberWithInteger:918]];
        [lut addObject:[NSNumber numberWithInteger:919]];
        [lut addObject:[NSNumber numberWithInteger:920]];
        [lut addObject:[NSNumber numberWithInteger:921]];
        [lut addObject:[NSNumber numberWithInteger:922]];
        [lut addObject:[NSNumber numberWithInteger:923]];
        [lut addObject:[NSNumber numberWithInteger:924]];
        [lut addObject:[NSNumber numberWithInteger:925]];
        [lut addObject:[NSNumber numberWithInteger:926]];
        [lut addObject:[NSNumber numberWithInteger:927]];
        [lut addObject:[NSNumber numberWithInteger:928]];
        [lut addObject:[NSNumber numberWithInteger:929]];
        [lut addObject:[NSNumber numberWithInteger:931]];
        [lut addObject:[NSNumber numberWithInteger:932]];
        [lut addObject:[NSNumber numberWithInteger:933]];
        [lut addObject:[NSNumber numberWithInteger:934]];
        [lut addObject:[NSNumber numberWithInteger:935]];
        [lut addObject:[NSNumber numberWithInteger:936]];
        [lut addObject:[NSNumber numberWithInteger:937]];
        [lut addObject:[NSNumber numberWithInteger:938]];
        [lut addObject:[NSNumber numberWithInteger:939]];
        [lut addObject:[NSNumber numberWithInteger:940]];
        [lut addObject:[NSNumber numberWithInteger:941]];
        [lut addObject:[NSNumber numberWithInteger:942]];
        [lut addObject:[NSNumber numberWithInteger:943]];
        [lut addObject:[NSNumber numberWithInteger:944]];
        [lut addObject:[NSNumber numberWithInteger:945]];
        [lut addObject:[NSNumber numberWithInteger:946]];
        [lut addObject:[NSNumber numberWithInteger:947]];
        [lut addObject:[NSNumber numberWithInteger:948]];
        [lut addObject:[NSNumber numberWithInteger:949]];
        [lut addObject:[NSNumber numberWithInteger:950]];
        [lut addObject:[NSNumber numberWithInteger:951]];
        [lut addObject:[NSNumber numberWithInteger:952]];
        [lut addObject:[NSNumber numberWithInteger:953]];
        [lut addObject:[NSNumber numberWithInteger:954]];
        [lut addObject:[NSNumber numberWithInteger:955]];
        [lut addObject:[NSNumber numberWithInteger:956]];
        [lut addObject:[NSNumber numberWithInteger:957]];
        [lut addObject:[NSNumber numberWithInteger:958]];
        [lut addObject:[NSNumber numberWithInteger:959]];
        [lut addObject:[NSNumber numberWithInteger:960]];
        [lut addObject:[NSNumber numberWithInteger:961]];
        [lut addObject:[NSNumber numberWithInteger:962]];
        [lut addObject:[NSNumber numberWithInteger:963]];
        [lut addObject:[NSNumber numberWithInteger:964]];
        [lut addObject:[NSNumber numberWithInteger:965]];
        [lut addObject:[NSNumber numberWithInteger:966]];
        [lut addObject:[NSNumber numberWithInteger:967]];
        [lut addObject:[NSNumber numberWithInteger:968]];
        [lut addObject:[NSNumber numberWithInteger:969]];
        [lut addObject:[NSNumber numberWithInteger:970]];
        [lut addObject:[NSNumber numberWithInteger:971]];
        [lut addObject:[NSNumber numberWithInteger:972]];
        [lut addObject:[NSNumber numberWithInteger:973]];
        [lut addObject:[NSNumber numberWithInteger:974]];
        [lut addObject:[NSNumber numberWithInteger:8213]];
        [lut addObject:[NSNumber numberWithInteger:8216]];
        [lut addObject:[NSNumber numberWithInteger:8217]];
        [lut addObject:[NSNumber numberWithInteger:8220]];
        [lut addObject:[NSNumber numberWithInteger:8224]];
        [lut addObject:[NSNumber numberWithInteger:8226]];
        [lut addObject:[NSNumber numberWithInteger:8230]];
        [lut addObject:[NSNumber numberWithInteger:8364]];
        [lut addObject:[NSNumber numberWithInteger:8482]];
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
        [_keyLabels setupKey:0x04 withCharCodesArray:@[@0x00, @0x03B1, @0x0391, @0x2026, @0x03AC, @0x0391, @0x0391, @0x2026, @0x03AC]];
        [_keyLabels setupKey:0x05 withCharCodesArray:@[@0x00, @0x03B2, @0x0392, @0x0000, @0x0000, @0x0392, @0x0392, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x06 withCharCodesArray:@[@0x00, @0x03C8, @0x03A8, @0x00E7, @0x03A7, @0x03A8, @0x03A8, @0x00E7, @0x03A7]];
        [_keyLabels setupKey:0x07 withCharCodesArray:@[@0x00, @0x03B4, @0x0394, @0x00F7, @0x0000, @0x0394, @0x0394, @0x00F7, @0x0000]];
        [_keyLabels setupKey:0x08 withCharCodesArray:@[@0x00, @0x03B5, @0x0395, @0x20AC, @0x0388, @0x0395, @0x0395, @0x20AC, @0x0388]];
        [_keyLabels setupKey:0x09 withCharCodesArray:@[@0x00, @0x03C6, @0x03A6, @0x2260, @0x03A0, @0x03A6, @0x03A6, @0x2260, @0x03A0]];
        [_keyLabels setupKey:0x0A withCharCodesArray:@[@0x00, @0x03B3, @0x0393, @0x00A9, @0x03AA, @0x0393, @0x0393, @0x00A9, @0x03AA]];
        [_keyLabels setupKey:0x0B withCharCodesArray:@[@0x00, @0x03B7, @0x0397, @0x00BD, @0x2260, @0x0397, @0x0397, @0x00BD, @0x2260]];
        [_keyLabels setupKey:0x0C withCharCodesArray:@[@0x00, @0x03B9, @0x0399, @0x2020, @0x039D, @0x0399, @0x0399, @0x2020, @0x039D]];
        [_keyLabels setupKey:0x0D withCharCodesArray:@[@0x00, @0x03BE, @0x039E, @0x2264, @0x00A7, @0x039E, @0x039E, @0x2264, @0x00A7]];
        [_keyLabels setupKey:0x0E withCharCodesArray:@[@0x00, @0x03BA, @0x039A, @0x2265, @0x00B0, @0x039A, @0x039A, @0x2265, @0x00B0]];
        [_keyLabels setupKey:0x0F withCharCodesArray:@[@0x00, @0x03BB, @0x039B, @0x00AC, @0x00B7, @0x039B, @0x039B, @0x00AC, @0x00B7]];
        [_keyLabels setupKey:0x10 withCharCodesArray:@[@0x00, @0x03BC, @0x039C, @0x2019, @0x038E, @0x039C, @0x039C, @0x2019, @0x038E]];
        [_keyLabels setupKey:0x11 withCharCodesArray:@[@0x00, @0x03BD, @0x039D, @0x2018, @0x038C, @0x039D, @0x039D, @0x2018, @0x038C]];
        [_keyLabels setupKey:0x12 withCharCodesArray:@[@0x00, @0x03BF, @0x039F, @0x0153, @0x03A4, @0x039F, @0x039F, @0x0153, @0x03A4]];
        [_keyLabels setupKey:0x13 withCharCodesArray:@[@0x00, @0x03C0, @0x03A0, @0x2248, @0x0000, @0x03A0, @0x03A0, @0x2248, @0x0000]];
        [_keyLabels setupKey:0x14 withCharCodesArray:@[@0x00, @0x003B, @0x003A, @0x00B7, @0x2015, @0x003B, @0x003A, @0x00B7, @0x2015]];
        [_keyLabels setupKey:0x15 withCharCodesArray:@[@0x00, @0x03C1, @0x03A1, @0x00AE, @0x0394, @0x03A1, @0x03A1, @0x00AE, @0x0394]];
        [_keyLabels setupKey:0x16 withCharCodesArray:@[@0x00, @0x03C3, @0x03A3, @0x00DF, @0x03C1, @0x03A3, @0x03A3, @0x00DF, @0x03C1]];
        [_keyLabels setupKey:0x17 withCharCodesArray:@[@0x00, @0x03C4, @0x03A4, @0x2122, @0x0000, @0x03A4, @0x03A4, @0x2122, @0x0000]];
        [_keyLabels setupKey:0x18 withCharCodesArray:@[@0x00, @0x03B8, @0x0398, @0x00AD, @0x039E, @0x0398, @0x0398, @0x00AD, @0x039E]];
        [_keyLabels setupKey:0x19 withCharCodesArray:@[@0x00, @0x03C9, @0x03A9, @0x00B1, @0x0386, @0x03A9, @0x03A9, @0x00B1, @0x0386]];
        [_keyLabels setupKey:0x1A withCharCodesArray:@[@0x22, @0x03C2, @0x0385, @0x2015, @0x0392, @0x03A3, @0x0385, @0x2015, @0x0392]];
        [_keyLabels setupKey:0x1B withCharCodesArray:@[@0x00, @0x03C7, @0x03A7, @0x0000, @0x0000, @0x03A7, @0x03A7, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x1C withCharCodesArray:@[@0x00, @0x03C5, @0x03A5, @0x00A5, @0x0000, @0x03A5, @0x03A5, @0x00A5, @0x0000]];
        [_keyLabels setupKey:0x1D withCharCodesArray:@[@0x00, @0x03B6, @0x0396, @0x00A7, @0x0000, @0x0396, @0x0396, @0x00A7, @0x0000]];
        [_keyLabels setupKey:0x1E withCharCodesArray:@[@0x00, @0x0031, @0x0021, @0x00B9, @0x03AD, @0x0031, @0x0021, @0x00B9, @0x03AD]];
        [_keyLabels setupKey:0x1F withCharCodesArray:@[@0x00, @0x0032, @0x0040, @0x00B2, @0x03AF, @0x0032, @0x0040, @0x00B2, @0x03AF]];
        [_keyLabels setupKey:0x20 withCharCodesArray:@[@0x00, @0x0033, @0x0023, @0x00B3, @0x03AE, @0x0033, @0x0023, @0x00B3, @0x03AE]];
        [_keyLabels setupKey:0x21 withCharCodesArray:@[@0x00, @0x0034, @0x0024, @0x00A3, @0x03CC, @0x0034, @0x0024, @0x00A3, @0x03CC]];
        [_keyLabels setupKey:0x22 withCharCodesArray:@[@0x00, @0x0035, @0x0025, @0x00A7, @0x038F, @0x0035, @0x0025, @0x00A7, @0x038F]];
        [_keyLabels setupKey:0x23 withCharCodesArray:@[@0x00, @0x0036, @0x005E, @0x00B6, @0x005E, @0x0036, @0x005E, @0x00B6, @0x005E]];
        [_keyLabels setupKey:0x24 withCharCodesArray:@[@0x00, @0x0037, @0x0026, @0x00B0, @0x0000, @0x0037, @0x0026, @0x00B0, @0x0000]];
        [_keyLabels setupKey:0x25 withCharCodesArray:@[@0x00, @0x0038, @0x002A, @0x2022, @0x03A1, @0x0038, @0x002A, @0x2022, @0x03A1]];
        [_keyLabels setupKey:0x26 withCharCodesArray:@[@0x00, @0x0039, @0x0028, @0x201C, @0x039A, @0x0039, @0x0028, @0x201C, @0x039A]];
        [_keyLabels setupKey:0x27 withCharCodesArray:@[@0x00, @0x0030, @0x0029, @0x00B0, @0x03CD, @0x0030, @0x0029, @0x00B0, @0x03CD]];
        [_keyLabels setupKey:0x2D withCharCodesArray:@[@0x00, @0x002D, @0x005F, @0x00B1, @0x005F, @0x002D, @0x005F, @0x00B1, @0x005F]];
        [_keyLabels setupKey:0x2E withCharCodesArray:@[@0x00, @0x003D, @0x002B, @0x00BD, @0x002B, @0x003D, @0x002B, @0x00BD, @0x002B]];
        [_keyLabels setupKey:0x2F withCharCodesArray:@[@0x00, @0x005B, @0x007B, @0x00AB, @0x007B, @0x005B, @0x007B, @0x00AB, @0x007B]];
        [_keyLabels setupKey:0x30 withCharCodesArray:@[@0x00, @0x005D, @0x007D, @0x00BB, @0x007D, @0x005D, @0x007D, @0x00BB, @0x007D]];
        [_keyLabels setupKey:0x31 withCharCodesArray:@[@0x00, @0x005C, @0x007C, @0x00A6, @0x0396, @0x005C, @0x007C, @0x00A6, @0x0396]];
        [_keyLabels setupKey:0x33 withCharCodesArray:@[@0x77, @0x0384, @0x00A8, @0x0385, @0x003A, @0x0384, @0x00A8, @0x0385, @0x003A]];
        [_keyLabels setupKey:0x34 withCharCodesArray:@[@0x00, @0x0027, @0x0022, @0x0027, @0x0022, @0x0027, @0x0022, @0x0027, @0x0022]];
        [_keyLabels setupKey:0x35 withCharCodesArray:@[@0x00, @0x00A7, @0x00B1, @0x0000, @0x0000, @0x00A7, @0x00B1, @0x0000, @0x0000]];
        [_keyLabels setupKey:0x36 withCharCodesArray:@[@0x00, @0x002C, @0x003C, @0x00AB, @0x0000, @0x002C, @0x003C, @0x00AB, @0x0000]];
        [_keyLabels setupKey:0x37 withCharCodesArray:@[@0x00, @0x002E, @0x003E, @0x00BB, @0x03CE, @0x002E, @0x003E, @0x00BB, @0x03CE]];
        [_keyLabels setupKey:0x38 withCharCodesArray:@[@0x00, @0x002F, @0x003F, @0x002F, @0x003F, @0x002F, @0x003F, @0x002F, @0x003F]];
        [_keyLabels setupKey:0x64 withCharCodesArray:@[@0x00, @0x0060, @0x007E, @0x0060, @0x039C, @0x0060, @0x007E, @0x0060, @0x039C]];
    }
    return _keyLabels;
}

@end
