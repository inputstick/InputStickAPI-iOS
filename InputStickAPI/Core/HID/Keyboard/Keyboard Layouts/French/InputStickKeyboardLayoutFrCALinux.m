/*
 * InputStickAPI-iOS
 * Copyright (c) 2020 Jakub Zawadzki, www.inputstick.com
 */
 
#import "InputStickKeyboardLayoutFrCALinux.h"
#import "InputStickKeyboardKeyModel.h"
#import "InputStickKeyLabels.h"

//InputStickKeyboardLayoutGenerator v1.00

@interface InputStickKeyboardLayoutFrCALinux () {
    InputStickKeyLabels *_keyLabels;
    NSArray<NSNumber *> *_availableCharactersLUT;
}

@end


@implementation InputStickKeyboardLayoutFrCALinux

- (NSString *)layoutCode {
    return @"fr-CA-linux";
}

- (NSString *)layoutCodeLowercase {
    return @"fr-ca-linux";
}

- (NSString *)layoutLanguageCode {
    return @"fr";
}

- (NSString *)layoutLanguageNativeName {
    return @"Français";
}

- (NSString *)layoutLanguageEnglishName {
    return @"French";
}

- (NSString *)layoutCountryCode {
    return @"CA";
}

- (NSString *)layoutCountryNativeName {
    return @"Canada";
}

- (NSString *)layoutCountryEnglishName {
    return @"Canada";
}

- (NSString *)layoutVariant {
    return @"CA Linux";
}

- (NSString *)layoutDisplayName {
    return @"French, CA Linux";
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 35: // #
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:0 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:2 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:2 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 59: // ;
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 60: // <
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 61: // =
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 62: // >
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 63: // ?
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 64: // @
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 65: // A
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 66: // B
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 67: // C
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 68: // D
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 69: // E
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 70: // F
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 71: // G
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 72: // H
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 73: // I
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 74: // J
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 75: // K
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 76: // L
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 77: // M
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 78: // N
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 79: // O
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 80: // P
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 81: // Q
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 82: // R
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 83: // S
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 84: // T
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 85: // U
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 86: // V
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 87: // W
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 88: // X
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 89: // Y
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 90: // Z
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 91: // [
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 92: // backslash
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 93: // ]
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 94: // ^
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:44 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 95: // _
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 96: // `
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:44 modifiers:0 deadkey:52 deadkeyModifiers:0];
                break;
            case 97: // a
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 98: // b
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 99: // c
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 100: // d
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 101: // e
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 102: // f
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 103: // g
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 104: // h
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 105: // i
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 106: // j
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 107: // k
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 108: // l
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 109: // m
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 110: // n
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 111: // o
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 112: // p
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 113: // q
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 114: // r
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 115: // s
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 116: // t
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 117: // u
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 118: // v
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 119: // w
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 120: // x
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 121: // y
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 122: // z
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 123: // {
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 124: // |
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 125: // }
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 126: // ~
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 162: // ¢
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 163: // £
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 164: // ¤
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 166: // ¦
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 167: // §
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 171: // «
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:100 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 172: // ¬
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 173: // ­
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 175: // ¯
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 176: // °
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:100 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 177: // ±
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 178: // ²
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 179: // ³
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 181: // µ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 182: // ¶
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 184: // ¸
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:44 modifiers:0 deadkey:48 deadkeyModifiers:0];
                break;
            case 185: // ¹
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 187: // »
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:100 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 188: // ¼
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 189: // ½
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 190: // ¾
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 192: // À
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:52 deadkeyModifiers:0];
                break;
            case 193: // Á
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 194: // Â
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 196: // Ä
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:48 deadkeyModifiers:2];
                break;
            case 199: // Ç
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:48 deadkeyModifiers:0];
                break;
            case 200: // È
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:52 deadkeyModifiers:0];
                break;
            case 201: // É
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 202: // Ê
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 203: // Ë
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:48 deadkeyModifiers:2];
                break;
            case 204: // Ì
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:52 deadkeyModifiers:0];
                break;
            case 205: // Í
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 206: // Î
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 207: // Ï
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:48 deadkeyModifiers:2];
                break;
            case 210: // Ò
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:52 deadkeyModifiers:0];
                break;
            case 211: // Ó
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 212: // Ô
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 214: // Ö
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:48 deadkeyModifiers:2];
                break;
            case 217: // Ù
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:52 deadkeyModifiers:0];
                break;
            case 218: // Ú
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 219: // Û
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 220: // Ü
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:48 deadkeyModifiers:2];
                break;
            case 221: // Ý
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 224: // à
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:52 deadkeyModifiers:0];
                break;
            case 225: // á
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 226: // â
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 228: // ä
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:48 deadkeyModifiers:2];
                break;
            case 231: // ç
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:48 deadkeyModifiers:0];
                break;
            case 232: // è
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:52 deadkeyModifiers:0];
                break;
            case 233: // é
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 234: // ê
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 235: // ë
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:48 deadkeyModifiers:2];
                break;
            case 236: // ì
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:52 deadkeyModifiers:0];
                break;
            case 237: // í
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 238: // î
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 239: // ï
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:48 deadkeyModifiers:2];
                break;
            case 242: // ò
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:52 deadkeyModifiers:0];
                break;
            case 243: // ó
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 244: // ô
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 246: // ö
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:48 deadkeyModifiers:2];
                break;
            case 249: // ù
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:52 deadkeyModifiers:0];
                break;
            case 250: // ú
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 251: // û
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 252: // ü
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:48 deadkeyModifiers:2];
                break;
            case 253: // ý
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 255: // ÿ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:48 deadkeyModifiers:2];
                break;
            case 262: // Ć
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 263: // ć
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 264: // Ĉ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 265: // ĉ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 284: // Ĝ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 285: // ĝ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 290: // Ģ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:48 deadkeyModifiers:0];
                break;
            case 291: // ģ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:48 deadkeyModifiers:0];
                break;
            case 292: // Ĥ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 293: // ĥ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 308: // Ĵ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 309: // ĵ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 310: // Ķ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:2 deadkey:48 deadkeyModifiers:0];
                break;
            case 311: // ķ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:0 deadkey:48 deadkeyModifiers:0];
                break;
            case 313: // Ĺ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 314: // ĺ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 315: // Ļ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:2 deadkey:48 deadkeyModifiers:0];
                break;
            case 316: // ļ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:0 deadkey:48 deadkeyModifiers:0];
                break;
            case 323: // Ń
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 324: // ń
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 325: // Ņ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:48 deadkeyModifiers:0];
                break;
            case 326: // ņ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:48 deadkeyModifiers:0];
                break;
            case 340: // Ŕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 341: // ŕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 342: // Ŗ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:2 deadkey:48 deadkeyModifiers:0];
                break;
            case 343: // ŗ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:0 deadkey:48 deadkeyModifiers:0];
                break;
            case 346: // Ś
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 347: // ś
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 348: // Ŝ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 349: // ŝ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 350: // Ş
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:48 deadkeyModifiers:0];
                break;
            case 351: // ş
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:48 deadkeyModifiers:0];
                break;
            case 354: // Ţ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:2 deadkey:48 deadkeyModifiers:0];
                break;
            case 355: // ţ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:0 deadkey:48 deadkeyModifiers:0];
                break;
            case 372: // Ŵ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 373: // ŵ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 374: // Ŷ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 375: // ŷ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 376: // Ÿ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:48 deadkeyModifiers:2];
                break;
            case 377: // Ź
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 378: // ź
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 471: // Ǘ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 472: // ǘ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 475: // Ǜ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:2 deadkey:52 deadkeyModifiers:0];
                break;
            case 476: // ǜ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:0 deadkey:52 deadkeyModifiers:0];
                break;
            case 500: // Ǵ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 501: // ǵ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 504: // Ǹ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:52 deadkeyModifiers:0];
                break;
            case 505: // ǹ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:52 deadkeyModifiers:0];
                break;
            case 552: // Ȩ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:48 deadkeyModifiers:0];
                break;
            case 553: // ȩ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:48 deadkeyModifiers:0];
                break;
            case 836: // ̈́
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:2 deadkey:48 deadkeyModifiers:2];
                break;
            case 7696: // Ḑ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:2 deadkey:48 deadkeyModifiers:0];
                break;
            case 7697: // ḑ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:0 deadkey:48 deadkeyModifiers:0];
                break;
            case 7718: // Ḧ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:48 deadkeyModifiers:2];
                break;
            case 7719: // ḧ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:48 deadkeyModifiers:2];
                break;
            case 7720: // Ḩ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:48 deadkeyModifiers:0];
                break;
            case 7721: // ḩ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:48 deadkeyModifiers:0];
                break;
            case 7728: // Ḱ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 7729: // ḱ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 7742: // Ḿ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 7743: // ḿ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 7764: // Ṕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 7765: // ṕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 7808: // Ẁ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:2 deadkey:52 deadkeyModifiers:0];
                break;
            case 7809: // ẁ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:52 deadkeyModifiers:0];
                break;
            case 7810: // Ẃ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:2 deadkey:56 deadkeyModifiers:64];
                break;
            case 7811: // ẃ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:56 deadkeyModifiers:64];
                break;
            case 7812: // Ẅ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:2 deadkey:48 deadkeyModifiers:2];
                break;
            case 7813: // ẅ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:48 deadkeyModifiers:2];
                break;
            case 7820: // Ẍ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:2 deadkey:48 deadkeyModifiers:2];
                break;
            case 7821: // ẍ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:0 deadkey:48 deadkeyModifiers:2];
                break;
            case 7824: // Ẑ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 7825: // ẑ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 7831: // ẗ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:0 deadkey:48 deadkeyModifiers:2];
                break;
            case 7870: // Ế
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 7871: // ế
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 7922: // Ỳ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:52 deadkeyModifiers:0];
                break;
            case 7923: // ỳ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:52 deadkeyModifiers:0];
                break;
            case 8304: // ⁰
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 8308: // ⁴
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 8309: // ⁵
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 8310: // ⁶
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 8311: // ⁷
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 8312: // ⁸
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 8313: // ⁹
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 8314: // ⁺
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 8315: // ⁻
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 8316: // ⁼
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:0 deadkey:47 deadkeyModifiers:0];
                break;
            case 8317: // ⁽
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 8318: // ⁾
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:2 deadkey:47 deadkeyModifiers:0];
                break;
            case 8373: // ₵
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:64 deadkey:48 deadkeyModifiers:0];
                break;
    }
    return keyboardKeyModel;
}

- (NSString *)availableCharactersString {
    //\t\n !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~¢£¤¦§«¬­¯°±²³µ¶¸¹»¼½¾ÀÁÂÄÇÈÉÊËÌÍÎÏÒÓÔÖÙÚÛÜÝàáâäçèéêëìíîïòóôöùúûüýÿĆćĈĉĜĝĢģĤĥĴĵĶķĹĺĻļŃńŅņŔŕŖŗŚśŜŝŞşŢţŴŵŶŷŸŹźǗǘǛǜǴǵǸǹȨȩ̈́ḐḑḦḧḨḩḰḱḾḿṔṕẀẁẂẃẄẅẌẍẐẑẗẾếỲỳ⁰⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾₵
    return @"\t\n !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\u00A2\u00A3\u00A4\u00A6\u00A7\u00AB\u00AC\u00AD\u00AF\u00B0\u00B1\u00B2\u00B3\u00B5\u00B6\u00B8\u00B9\u00BB\u00BC\u00BD\u00BE\u00C0\u00C1\u00C2\u00C4\u00C7\u00C8\u00C9\u00CA\u00CB\u00CC\u00CD\u00CE\u00CF\u00D2\u00D3\u00D4\u00D6\u00D9\u00DA\u00DB\u00DC\u00DD\u00E0\u00E1\u00E2\u00E4\u00E7\u00E8\u00E9\u00EA\u00EB\u00EC\u00ED\u00EE\u00EF\u00F2\u00F3\u00F4\u00F6\u00F9\u00FA\u00FB\u00FC\u00FD\u00FF\u0106\u0107\u0108\u0109\u011C\u011D\u0122\u0123\u0124\u0125\u0134\u0135\u0136\u0137\u0139\u013A\u013B\u013C\u0143\u0144\u0145\u0146\u0154\u0155\u0156\u0157\u015A\u015B\u015C\u015D\u015E\u015F\u0162\u0163\u0174\u0175\u0176\u0177\u0178\u0179\u017A\u01D7\u01D8\u01DB\u01DC\u01F4\u01F5\u01F8\u01F9\u0228\u0229\u0344\u1E10\u1E11\u1E26\u1E27\u1E28\u1E29\u1E30\u1E31\u1E3E\u1E3F\u1E54\u1E55\u1E80\u1E81\u1E82\u1E83\u1E84\u1E85\u1E8C\u1E8D\u1E90\u1E91\u1E97\u1EBE\u1EBF\u1EF2\u1EF3\u2070\u2074\u2075\u2076\u2077\u2078\u2079\u207A\u207B\u207C\u207D\u207E\u20B5";
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
        [lut addObject:[NSNumber numberWithInteger:65]];
        [lut addObject:[NSNumber numberWithInteger:66]];
        [lut addObject:[NSNumber numberWithInteger:67]];
        [lut addObject:[NSNumber numberWithInteger:68]];
        [lut addObject:[NSNumber numberWithInteger:69]];
        [lut addObject:[NSNumber numberWithInteger:70]];
        [lut addObject:[NSNumber numberWithInteger:71]];
        [lut addObject:[NSNumber numberWithInteger:72]];
        [lut addObject:[NSNumber numberWithInteger:73]];
        [lut addObject:[NSNumber numberWithInteger:74]];
        [lut addObject:[NSNumber numberWithInteger:75]];
        [lut addObject:[NSNumber numberWithInteger:76]];
        [lut addObject:[NSNumber numberWithInteger:77]];
        [lut addObject:[NSNumber numberWithInteger:78]];
        [lut addObject:[NSNumber numberWithInteger:79]];
        [lut addObject:[NSNumber numberWithInteger:80]];
        [lut addObject:[NSNumber numberWithInteger:81]];
        [lut addObject:[NSNumber numberWithInteger:82]];
        [lut addObject:[NSNumber numberWithInteger:83]];
        [lut addObject:[NSNumber numberWithInteger:84]];
        [lut addObject:[NSNumber numberWithInteger:85]];
        [lut addObject:[NSNumber numberWithInteger:86]];
        [lut addObject:[NSNumber numberWithInteger:87]];
        [lut addObject:[NSNumber numberWithInteger:88]];
        [lut addObject:[NSNumber numberWithInteger:89]];
        [lut addObject:[NSNumber numberWithInteger:90]];
        [lut addObject:[NSNumber numberWithInteger:91]];
        [lut addObject:[NSNumber numberWithInteger:92]];
        [lut addObject:[NSNumber numberWithInteger:93]];
        [lut addObject:[NSNumber numberWithInteger:94]];
        [lut addObject:[NSNumber numberWithInteger:95]];
        [lut addObject:[NSNumber numberWithInteger:96]];
        [lut addObject:[NSNumber numberWithInteger:97]];
        [lut addObject:[NSNumber numberWithInteger:98]];
        [lut addObject:[NSNumber numberWithInteger:99]];
        [lut addObject:[NSNumber numberWithInteger:100]];
        [lut addObject:[NSNumber numberWithInteger:101]];
        [lut addObject:[NSNumber numberWithInteger:102]];
        [lut addObject:[NSNumber numberWithInteger:103]];
        [lut addObject:[NSNumber numberWithInteger:104]];
        [lut addObject:[NSNumber numberWithInteger:105]];
        [lut addObject:[NSNumber numberWithInteger:106]];
        [lut addObject:[NSNumber numberWithInteger:107]];
        [lut addObject:[NSNumber numberWithInteger:108]];
        [lut addObject:[NSNumber numberWithInteger:109]];
        [lut addObject:[NSNumber numberWithInteger:110]];
        [lut addObject:[NSNumber numberWithInteger:111]];
        [lut addObject:[NSNumber numberWithInteger:112]];
        [lut addObject:[NSNumber numberWithInteger:113]];
        [lut addObject:[NSNumber numberWithInteger:114]];
        [lut addObject:[NSNumber numberWithInteger:115]];
        [lut addObject:[NSNumber numberWithInteger:116]];
        [lut addObject:[NSNumber numberWithInteger:117]];
        [lut addObject:[NSNumber numberWithInteger:118]];
        [lut addObject:[NSNumber numberWithInteger:119]];
        [lut addObject:[NSNumber numberWithInteger:120]];
        [lut addObject:[NSNumber numberWithInteger:121]];
        [lut addObject:[NSNumber numberWithInteger:122]];
        [lut addObject:[NSNumber numberWithInteger:123]];
        [lut addObject:[NSNumber numberWithInteger:124]];
        [lut addObject:[NSNumber numberWithInteger:125]];
        [lut addObject:[NSNumber numberWithInteger:126]];
        [lut addObject:[NSNumber numberWithInteger:162]];
        [lut addObject:[NSNumber numberWithInteger:163]];
        [lut addObject:[NSNumber numberWithInteger:164]];
        [lut addObject:[NSNumber numberWithInteger:166]];
        [lut addObject:[NSNumber numberWithInteger:167]];
        [lut addObject:[NSNumber numberWithInteger:171]];
        [lut addObject:[NSNumber numberWithInteger:172]];
        [lut addObject:[NSNumber numberWithInteger:173]];
        [lut addObject:[NSNumber numberWithInteger:175]];
        [lut addObject:[NSNumber numberWithInteger:176]];
        [lut addObject:[NSNumber numberWithInteger:177]];
        [lut addObject:[NSNumber numberWithInteger:178]];
        [lut addObject:[NSNumber numberWithInteger:179]];
        [lut addObject:[NSNumber numberWithInteger:181]];
        [lut addObject:[NSNumber numberWithInteger:182]];
        [lut addObject:[NSNumber numberWithInteger:184]];
        [lut addObject:[NSNumber numberWithInteger:185]];
        [lut addObject:[NSNumber numberWithInteger:187]];
        [lut addObject:[NSNumber numberWithInteger:188]];
        [lut addObject:[NSNumber numberWithInteger:189]];
        [lut addObject:[NSNumber numberWithInteger:190]];
        [lut addObject:[NSNumber numberWithInteger:192]];
        [lut addObject:[NSNumber numberWithInteger:193]];
        [lut addObject:[NSNumber numberWithInteger:194]];
        [lut addObject:[NSNumber numberWithInteger:196]];
        [lut addObject:[NSNumber numberWithInteger:199]];
        [lut addObject:[NSNumber numberWithInteger:200]];
        [lut addObject:[NSNumber numberWithInteger:201]];
        [lut addObject:[NSNumber numberWithInteger:202]];
        [lut addObject:[NSNumber numberWithInteger:203]];
        [lut addObject:[NSNumber numberWithInteger:204]];
        [lut addObject:[NSNumber numberWithInteger:205]];
        [lut addObject:[NSNumber numberWithInteger:206]];
        [lut addObject:[NSNumber numberWithInteger:207]];
        [lut addObject:[NSNumber numberWithInteger:210]];
        [lut addObject:[NSNumber numberWithInteger:211]];
        [lut addObject:[NSNumber numberWithInteger:212]];
        [lut addObject:[NSNumber numberWithInteger:214]];
        [lut addObject:[NSNumber numberWithInteger:217]];
        [lut addObject:[NSNumber numberWithInteger:218]];
        [lut addObject:[NSNumber numberWithInteger:219]];
        [lut addObject:[NSNumber numberWithInteger:220]];
        [lut addObject:[NSNumber numberWithInteger:221]];
        [lut addObject:[NSNumber numberWithInteger:224]];
        [lut addObject:[NSNumber numberWithInteger:225]];
        [lut addObject:[NSNumber numberWithInteger:226]];
        [lut addObject:[NSNumber numberWithInteger:228]];
        [lut addObject:[NSNumber numberWithInteger:231]];
        [lut addObject:[NSNumber numberWithInteger:232]];
        [lut addObject:[NSNumber numberWithInteger:233]];
        [lut addObject:[NSNumber numberWithInteger:234]];
        [lut addObject:[NSNumber numberWithInteger:235]];
        [lut addObject:[NSNumber numberWithInteger:236]];
        [lut addObject:[NSNumber numberWithInteger:237]];
        [lut addObject:[NSNumber numberWithInteger:238]];
        [lut addObject:[NSNumber numberWithInteger:239]];
        [lut addObject:[NSNumber numberWithInteger:242]];
        [lut addObject:[NSNumber numberWithInteger:243]];
        [lut addObject:[NSNumber numberWithInteger:244]];
        [lut addObject:[NSNumber numberWithInteger:246]];
        [lut addObject:[NSNumber numberWithInteger:249]];
        [lut addObject:[NSNumber numberWithInteger:250]];
        [lut addObject:[NSNumber numberWithInteger:251]];
        [lut addObject:[NSNumber numberWithInteger:252]];
        [lut addObject:[NSNumber numberWithInteger:253]];
        [lut addObject:[NSNumber numberWithInteger:255]];
        [lut addObject:[NSNumber numberWithInteger:262]];
        [lut addObject:[NSNumber numberWithInteger:263]];
        [lut addObject:[NSNumber numberWithInteger:264]];
        [lut addObject:[NSNumber numberWithInteger:265]];
        [lut addObject:[NSNumber numberWithInteger:284]];
        [lut addObject:[NSNumber numberWithInteger:285]];
        [lut addObject:[NSNumber numberWithInteger:290]];
        [lut addObject:[NSNumber numberWithInteger:291]];
        [lut addObject:[NSNumber numberWithInteger:292]];
        [lut addObject:[NSNumber numberWithInteger:293]];
        [lut addObject:[NSNumber numberWithInteger:308]];
        [lut addObject:[NSNumber numberWithInteger:309]];
        [lut addObject:[NSNumber numberWithInteger:310]];
        [lut addObject:[NSNumber numberWithInteger:311]];
        [lut addObject:[NSNumber numberWithInteger:313]];
        [lut addObject:[NSNumber numberWithInteger:314]];
        [lut addObject:[NSNumber numberWithInteger:315]];
        [lut addObject:[NSNumber numberWithInteger:316]];
        [lut addObject:[NSNumber numberWithInteger:323]];
        [lut addObject:[NSNumber numberWithInteger:324]];
        [lut addObject:[NSNumber numberWithInteger:325]];
        [lut addObject:[NSNumber numberWithInteger:326]];
        [lut addObject:[NSNumber numberWithInteger:340]];
        [lut addObject:[NSNumber numberWithInteger:341]];
        [lut addObject:[NSNumber numberWithInteger:342]];
        [lut addObject:[NSNumber numberWithInteger:343]];
        [lut addObject:[NSNumber numberWithInteger:346]];
        [lut addObject:[NSNumber numberWithInteger:347]];
        [lut addObject:[NSNumber numberWithInteger:348]];
        [lut addObject:[NSNumber numberWithInteger:349]];
        [lut addObject:[NSNumber numberWithInteger:350]];
        [lut addObject:[NSNumber numberWithInteger:351]];
        [lut addObject:[NSNumber numberWithInteger:354]];
        [lut addObject:[NSNumber numberWithInteger:355]];
        [lut addObject:[NSNumber numberWithInteger:372]];
        [lut addObject:[NSNumber numberWithInteger:373]];
        [lut addObject:[NSNumber numberWithInteger:374]];
        [lut addObject:[NSNumber numberWithInteger:375]];
        [lut addObject:[NSNumber numberWithInteger:376]];
        [lut addObject:[NSNumber numberWithInteger:377]];
        [lut addObject:[NSNumber numberWithInteger:378]];
        [lut addObject:[NSNumber numberWithInteger:471]];
        [lut addObject:[NSNumber numberWithInteger:472]];
        [lut addObject:[NSNumber numberWithInteger:475]];
        [lut addObject:[NSNumber numberWithInteger:476]];
        [lut addObject:[NSNumber numberWithInteger:500]];
        [lut addObject:[NSNumber numberWithInteger:501]];
        [lut addObject:[NSNumber numberWithInteger:504]];
        [lut addObject:[NSNumber numberWithInteger:505]];
        [lut addObject:[NSNumber numberWithInteger:552]];
        [lut addObject:[NSNumber numberWithInteger:553]];
        [lut addObject:[NSNumber numberWithInteger:836]];
        [lut addObject:[NSNumber numberWithInteger:7696]];
        [lut addObject:[NSNumber numberWithInteger:7697]];
        [lut addObject:[NSNumber numberWithInteger:7718]];
        [lut addObject:[NSNumber numberWithInteger:7719]];
        [lut addObject:[NSNumber numberWithInteger:7720]];
        [lut addObject:[NSNumber numberWithInteger:7721]];
        [lut addObject:[NSNumber numberWithInteger:7728]];
        [lut addObject:[NSNumber numberWithInteger:7729]];
        [lut addObject:[NSNumber numberWithInteger:7742]];
        [lut addObject:[NSNumber numberWithInteger:7743]];
        [lut addObject:[NSNumber numberWithInteger:7764]];
        [lut addObject:[NSNumber numberWithInteger:7765]];
        [lut addObject:[NSNumber numberWithInteger:7808]];
        [lut addObject:[NSNumber numberWithInteger:7809]];
        [lut addObject:[NSNumber numberWithInteger:7810]];
        [lut addObject:[NSNumber numberWithInteger:7811]];
        [lut addObject:[NSNumber numberWithInteger:7812]];
        [lut addObject:[NSNumber numberWithInteger:7813]];
        [lut addObject:[NSNumber numberWithInteger:7820]];
        [lut addObject:[NSNumber numberWithInteger:7821]];
        [lut addObject:[NSNumber numberWithInteger:7824]];
        [lut addObject:[NSNumber numberWithInteger:7825]];
        [lut addObject:[NSNumber numberWithInteger:7831]];
        [lut addObject:[NSNumber numberWithInteger:7870]];
        [lut addObject:[NSNumber numberWithInteger:7871]];
        [lut addObject:[NSNumber numberWithInteger:7922]];
        [lut addObject:[NSNumber numberWithInteger:7923]];
        [lut addObject:[NSNumber numberWithInteger:8304]];
        [lut addObject:[NSNumber numberWithInteger:8308]];
        [lut addObject:[NSNumber numberWithInteger:8309]];
        [lut addObject:[NSNumber numberWithInteger:8310]];
        [lut addObject:[NSNumber numberWithInteger:8311]];
        [lut addObject:[NSNumber numberWithInteger:8312]];
        [lut addObject:[NSNumber numberWithInteger:8313]];
        [lut addObject:[NSNumber numberWithInteger:8314]];
        [lut addObject:[NSNumber numberWithInteger:8315]];
        [lut addObject:[NSNumber numberWithInteger:8316]];
        [lut addObject:[NSNumber numberWithInteger:8317]];
        [lut addObject:[NSNumber numberWithInteger:8318]];
        [lut addObject:[NSNumber numberWithInteger:8373]];
        _availableCharactersLUT = lut;
    }
    return _availableCharactersLUT;
}

- (InputStickKeyLabels *)keyLabels {
    if (_keyLabels == nil) {
        _keyLabels = [[InputStickKeyLabels alloc] init];
        [_keyLabels setupKey:0x04 withCharCodesArray:@[@0x00, @0x0061, @0x0041, @0x0061, @0x0041, @0x0041, @0x0061, @0x0041, @0x0061]];
        [_keyLabels setupKey:0x05 withCharCodesArray:@[@0x00, @0x0062, @0x0042, @0x0062, @0x0042, @0x0042, @0x0062, @0x0042, @0x0062]];
        [_keyLabels setupKey:0x06 withCharCodesArray:@[@0x00, @0x0063, @0x0043, @0x0063, @0x0043, @0x0043, @0x0063, @0x0043, @0x0063]];
        [_keyLabels setupKey:0x07 withCharCodesArray:@[@0x00, @0x0064, @0x0044, @0x0064, @0x0044, @0x0044, @0x0064, @0x0044, @0x0064]];
        [_keyLabels setupKey:0x08 withCharCodesArray:@[@0x00, @0x0065, @0x0045, @0x0065, @0x0045, @0x0045, @0x0065, @0x0045, @0x0065]];
        [_keyLabels setupKey:0x09 withCharCodesArray:@[@0x00, @0x0066, @0x0046, @0x0066, @0x0046, @0x0046, @0x0066, @0x0046, @0x0066]];
        [_keyLabels setupKey:0x0A withCharCodesArray:@[@0x00, @0x0067, @0x0047, @0x0067, @0x0047, @0x0047, @0x0067, @0x0047, @0x0067]];
        [_keyLabels setupKey:0x0B withCharCodesArray:@[@0x00, @0x0068, @0x0048, @0x0068, @0x0048, @0x0048, @0x0068, @0x0048, @0x0068]];
        [_keyLabels setupKey:0x0C withCharCodesArray:@[@0x00, @0x0069, @0x0049, @0x0069, @0x0049, @0x0049, @0x0069, @0x0049, @0x0069]];
        [_keyLabels setupKey:0x0D withCharCodesArray:@[@0x00, @0x006A, @0x004A, @0x006A, @0x004A, @0x004A, @0x006A, @0x004A, @0x006A]];
        [_keyLabels setupKey:0x0E withCharCodesArray:@[@0x00, @0x006B, @0x004B, @0x006B, @0x004B, @0x004B, @0x006B, @0x004B, @0x006B]];
        [_keyLabels setupKey:0x0F withCharCodesArray:@[@0x00, @0x006C, @0x004C, @0x006C, @0x004C, @0x004C, @0x006C, @0x004C, @0x006C]];
        [_keyLabels setupKey:0x10 withCharCodesArray:@[@0x00, @0x006D, @0x004D, @0x00B5, @0x0000, @0x004D, @0x006D, @0x00B5, @0x0000]];
        [_keyLabels setupKey:0x11 withCharCodesArray:@[@0x00, @0x006E, @0x004E, @0x006E, @0x004E, @0x004E, @0x006E, @0x004E, @0x006E]];
        [_keyLabels setupKey:0x12 withCharCodesArray:@[@0x00, @0x006F, @0x004F, @0x00A7, @0x0000, @0x004F, @0x006F, @0x00A7, @0x0000]];
        [_keyLabels setupKey:0x13 withCharCodesArray:@[@0x00, @0x0070, @0x0050, @0x00B6, @0x0000, @0x0050, @0x0070, @0x00B6, @0x0000]];
        [_keyLabels setupKey:0x14 withCharCodesArray:@[@0x00, @0x0071, @0x0051, @0x0071, @0x0051, @0x0051, @0x0071, @0x0051, @0x0071]];
        [_keyLabels setupKey:0x15 withCharCodesArray:@[@0x00, @0x0072, @0x0052, @0x0072, @0x0052, @0x0052, @0x0072, @0x0052, @0x0072]];
        [_keyLabels setupKey:0x16 withCharCodesArray:@[@0x00, @0x0073, @0x0053, @0x0073, @0x0053, @0x0053, @0x0073, @0x0053, @0x0073]];
        [_keyLabels setupKey:0x17 withCharCodesArray:@[@0x00, @0x0074, @0x0054, @0x0074, @0x0054, @0x0054, @0x0074, @0x0054, @0x0074]];
        [_keyLabels setupKey:0x18 withCharCodesArray:@[@0x00, @0x0075, @0x0055, @0x0075, @0x0055, @0x0055, @0x0075, @0x0055, @0x0075]];
        [_keyLabels setupKey:0x19 withCharCodesArray:@[@0x00, @0x0076, @0x0056, @0x0076, @0x0056, @0x0056, @0x0076, @0x0056, @0x0076]];
        [_keyLabels setupKey:0x1A withCharCodesArray:@[@0x00, @0x0077, @0x0057, @0x0077, @0x0057, @0x0057, @0x0077, @0x0057, @0x0077]];
        [_keyLabels setupKey:0x1B withCharCodesArray:@[@0x00, @0x0078, @0x0058, @0x0078, @0x0058, @0x0058, @0x0078, @0x0058, @0x0078]];
        [_keyLabels setupKey:0x1C withCharCodesArray:@[@0x00, @0x0079, @0x0059, @0x0079, @0x0059, @0x0059, @0x0079, @0x0059, @0x0079]];
        [_keyLabels setupKey:0x1D withCharCodesArray:@[@0x00, @0x007A, @0x005A, @0x007A, @0x005A, @0x005A, @0x007A, @0x005A, @0x007A]];
        [_keyLabels setupKey:0x1E withCharCodesArray:@[@0x00, @0x0031, @0x0021, @0x00B1, @0x0000, @0x0031, @0x0021, @0x00B1, @0x0000]];
        [_keyLabels setupKey:0x1F withCharCodesArray:@[@0x00, @0x0032, @0x0022, @0x0040, @0x0000, @0x0032, @0x0022, @0x0040, @0x0000]];
        [_keyLabels setupKey:0x20 withCharCodesArray:@[@0x00, @0x0033, @0x002F, @0x00A3, @0x0000, @0x0033, @0x002F, @0x00A3, @0x0000]];
        [_keyLabels setupKey:0x21 withCharCodesArray:@[@0x00, @0x0034, @0x0024, @0x00A2, @0x0000, @0x0034, @0x0024, @0x00A2, @0x0000]];
        [_keyLabels setupKey:0x22 withCharCodesArray:@[@0x00, @0x0035, @0x0025, @0x00A4, @0x0000, @0x0035, @0x0025, @0x00A4, @0x0000]];
        [_keyLabels setupKey:0x23 withCharCodesArray:@[@0x00, @0x0036, @0x003F, @0x00AC, @0x0000, @0x0036, @0x003F, @0x00AC, @0x0000]];
        [_keyLabels setupKey:0x24 withCharCodesArray:@[@0x00, @0x0037, @0x0026, @0x00A6, @0x0000, @0x0037, @0x0026, @0x00A6, @0x0000]];
        [_keyLabels setupKey:0x25 withCharCodesArray:@[@0x00, @0x0038, @0x002A, @0x00B2, @0x0000, @0x0038, @0x002A, @0x00B2, @0x0000]];
        [_keyLabels setupKey:0x26 withCharCodesArray:@[@0x00, @0x0039, @0x0028, @0x00B3, @0x0000, @0x0039, @0x0028, @0x00B3, @0x0000]];
        [_keyLabels setupKey:0x27 withCharCodesArray:@[@0x00, @0x0030, @0x0029, @0x00BC, @0x0000, @0x0030, @0x0029, @0x00BC, @0x0000]];
        [_keyLabels setupKey:0x2D withCharCodesArray:@[@0x00, @0x002D, @0x005F, @0x00BD, @0x0000, @0x002D, @0x005F, @0x00BD, @0x0000]];
        [_keyLabels setupKey:0x2E withCharCodesArray:@[@0x00, @0x003D, @0x002B, @0x00BE, @0x0000, @0x003D, @0x002B, @0x00BE, @0x0000]];
        [_keyLabels setupKey:0x2F withCharCodesArray:@[@0x33, @0x005E, @0x005E, @0x005B, @0x0000, @0x005E, @0x005E, @0x005B, @0x0000]];
        [_keyLabels setupKey:0x30 withCharCodesArray:@[@0x33, @0x00B8, @0x0022, @0x005D, @0x0000, @0x00B8, @0x0022, @0x005D, @0x0000]];
        [_keyLabels setupKey:0x31 withCharCodesArray:@[@0x00, @0x003C, @0x003E, @0x007D, @0x0000, @0x003C, @0x003E, @0x007D, @0x0000]];
        [_keyLabels setupKey:0x33 withCharCodesArray:@[@0x00, @0x003B, @0x003A, @0x007E, @0x0000, @0x003B, @0x003A, @0x007E, @0x0000]];
        [_keyLabels setupKey:0x34 withCharCodesArray:@[@0x33, @0x0060, @0x0060, @0x007B, @0x0000, @0x0060, @0x0060, @0x007B, @0x0000]];
        [_keyLabels setupKey:0x35 withCharCodesArray:@[@0x00, @0x0023, @0x007C, @0x005C, @0x0000, @0x0023, @0x007C, @0x005C, @0x0000]];
        [_keyLabels setupKey:0x36 withCharCodesArray:@[@0x00, @0x002C, @0x0027, @0x00AF, @0x0000, @0x002C, @0x0027, @0x00AF, @0x0000]];
        [_keyLabels setupKey:0x37 withCharCodesArray:@[@0x00, @0x002E, @0x002E, @0x00AD, @0x0000, @0x002E, @0x002E, @0x00AD, @0x0000]];
        [_keyLabels setupKey:0x38 withCharCodesArray:@[@0x44, @0x00E9, @0x00C9, @0x0027, @0x0000, @0x00C9, @0x00E9, @0x0027, @0x0000]];
        [_keyLabels setupKey:0x64 withCharCodesArray:@[@0x00, @0x00AB, @0x00BB, @0x00B0, @0x0000, @0x00AB, @0x00BB, @0x00B0, @0x0000]];
    }
    return _keyLabels;
}

@end
