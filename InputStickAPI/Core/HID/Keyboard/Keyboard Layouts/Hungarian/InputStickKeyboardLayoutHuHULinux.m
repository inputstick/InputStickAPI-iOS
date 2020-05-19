/*
 * InputStickAPI-iOS
 * Copyright (c) 2020 Jakub Zawadzki, www.inputstick.com
 */
 
#import "InputStickKeyboardLayoutHuHULinux.h"
#import "InputStickKeyboardKeyModel.h"
#import "InputStickKeyLabels.h"

//InputStickKeyboardLayoutGenerator v1.00

@interface InputStickKeyboardLayoutHuHULinux () {
    InputStickKeyLabels *_keyLabels;
    NSArray<NSNumber *> *_availableCharactersLUT;
}

@end


@implementation InputStickKeyboardLayoutHuHULinux

- (NSString *)layoutCode {
    return @"hu-HU-linux";
}

- (NSString *)layoutCodeLowercase {
    return [[self layoutCode] lowercaseString];
}

- (NSString *)layoutNativeName {
    return @"Magyar";
}

- (NSString *)layoutEnglishName {
    return @"Hungarian";
}

- (NSString *)layoutVariant {
    return @"HU Linux";
}

- (NSString *)layoutFullName {
    return @"Hungarian (Magyar) [HU Linux]";
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 34: // "
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 35: // #
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 36: // $
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 37: // %
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 38: // &
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 39: // '
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 40: // (
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 41: // )
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 42: // *
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 43: // +
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 44: // ,
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 45: // -
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 46: // .
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 47: // /
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 48: // 0
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:0 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 59: // ;
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 60: // <
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 61: // =
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 62: // >
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 63: // ?
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 64: // @
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:64 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 90: // Z
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 91: // [
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 92: // backslash
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 93: // ]
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 94: // ^
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 95: // _
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 96: // `
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:64 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 122: // z
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 123: // {
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 124: // |
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 125: // }
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 126: // ~
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 162: // ¢
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 164: // ¤
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 165: // ¥
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 167: // §
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 168: // ¨
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 169: // ©
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 170: // ª
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 172: // ¬
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 174: // ®
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 175: // ¯
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:44 modifiers:0 deadkey:48 deadkeyModifiers:66];
                break;
            case 176: // °
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 178: // ²
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 179: // ³
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 180: // ´
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 182: // ¶
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 184: // ¸
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 185: // ¹
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 186: // º
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 192: // À
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:36 deadkeyModifiers:66];
                break;
            case 193: // Á
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 194: // Â
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 195: // Ã
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:30 deadkeyModifiers:66];
                break;
            case 196: // Ä
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 197: // Å
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:34 deadkeyModifiers:64];
                break;
            case 199: // Ç
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:46 deadkeyModifiers:64];
                break;
            case 200: // È
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:36 deadkeyModifiers:66];
                break;
            case 201: // É
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 202: // Ê
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 203: // Ë
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:45 deadkeyModifiers:64];
                break;
            case 204: // Ì
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:36 deadkeyModifiers:66];
                break;
            case 205: // Í
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:100 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 206: // Î
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 207: // Ï
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:45 deadkeyModifiers:64];
                break;
            case 208: // Ð
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 209: // Ñ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:30 deadkeyModifiers:66];
                break;
            case 210: // Ò
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:36 deadkeyModifiers:66];
                break;
            case 211: // Ó
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 212: // Ô
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 213: // Õ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:30 deadkeyModifiers:66];
                break;
            case 214: // Ö
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 215: // ×
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 216: // Ø
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 217: // Ù
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:36 deadkeyModifiers:66];
                break;
            case 218: // Ú
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 219: // Û
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 220: // Ü
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 221: // Ý
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:38 deadkeyModifiers:64];
                break;
            case 222: // Þ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 223: // ß
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 224: // à
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:36 deadkeyModifiers:66];
                break;
            case 225: // á
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 226: // â
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 227: // ã
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:30 deadkeyModifiers:66];
                break;
            case 228: // ä
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 229: // å
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:34 deadkeyModifiers:64];
                break;
            case 231: // ç
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:46 deadkeyModifiers:64];
                break;
            case 232: // è
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:36 deadkeyModifiers:66];
                break;
            case 233: // é
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 234: // ê
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 235: // ë
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:45 deadkeyModifiers:64];
                break;
            case 236: // ì
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:36 deadkeyModifiers:66];
                break;
            case 237: // í
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:100 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 238: // î
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 239: // ï
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:45 deadkeyModifiers:64];
                break;
            case 241: // ñ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:30 deadkeyModifiers:66];
                break;
            case 242: // ò
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:36 deadkeyModifiers:66];
                break;
            case 243: // ó
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 244: // ô
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 245: // õ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:30 deadkeyModifiers:66];
                break;
            case 246: // ö
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 247: // ÷
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 249: // ù
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:36 deadkeyModifiers:66];
                break;
            case 250: // ú
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 251: // û
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 252: // ü
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 253: // ý
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:38 deadkeyModifiers:64];
                break;
            case 255: // ÿ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:45 deadkeyModifiers:64];
                break;
            case 256: // Ā
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:48 deadkeyModifiers:66];
                break;
            case 257: // ā
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:48 deadkeyModifiers:66];
                break;
            case 258: // Ă
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:33 deadkeyModifiers:64];
                break;
            case 259: // ă
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:33 deadkeyModifiers:64];
                break;
            case 260: // Ą
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:35 deadkeyModifiers:64];
                break;
            case 261: // ą
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:35 deadkeyModifiers:64];
                break;
            case 262: // Ć
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:38 deadkeyModifiers:64];
                break;
            case 263: // ć
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:38 deadkeyModifiers:64];
                break;
            case 264: // Ĉ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 265: // ĉ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 266: // Ċ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 267: // ċ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 268: // Č
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 269: // č
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 270: // Ď
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 271: // ď
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 272: // Đ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 273: // đ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 274: // Ē
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:48 deadkeyModifiers:66];
                break;
            case 275: // ē
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:48 deadkeyModifiers:66];
                break;
            case 276: // Ĕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:33 deadkeyModifiers:64];
                break;
            case 277: // ĕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:33 deadkeyModifiers:64];
                break;
            case 278: // Ė
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 279: // ė
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 280: // Ę
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:35 deadkeyModifiers:64];
                break;
            case 281: // ę
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:35 deadkeyModifiers:64];
                break;
            case 282: // Ě
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 283: // ě
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 284: // Ĝ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 285: // ĝ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 286: // Ğ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:33 deadkeyModifiers:64];
                break;
            case 287: // ğ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:33 deadkeyModifiers:64];
                break;
            case 288: // Ġ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 289: // ġ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 290: // Ģ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:46 deadkeyModifiers:64];
                break;
            case 291: // ģ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:46 deadkeyModifiers:64];
                break;
            case 292: // Ĥ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 293: // ĥ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 294: // Ħ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 295: // ħ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 296: // Ĩ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:30 deadkeyModifiers:66];
                break;
            case 297: // ĩ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:30 deadkeyModifiers:66];
                break;
            case 298: // Ī
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:48 deadkeyModifiers:66];
                break;
            case 299: // ī
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:48 deadkeyModifiers:66];
                break;
            case 300: // Ĭ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:33 deadkeyModifiers:64];
                break;
            case 301: // ĭ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:33 deadkeyModifiers:64];
                break;
            case 302: // Į
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:35 deadkeyModifiers:64];
                break;
            case 303: // į
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:35 deadkeyModifiers:64];
                break;
            case 304: // İ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 305: // ı
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 308: // Ĵ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 309: // ĵ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 310: // Ķ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:2 deadkey:46 deadkeyModifiers:64];
                break;
            case 311: // ķ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:0 deadkey:46 deadkeyModifiers:64];
                break;
            case 313: // Ĺ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:2 deadkey:38 deadkeyModifiers:64];
                break;
            case 314: // ĺ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:0 deadkey:38 deadkeyModifiers:64];
                break;
            case 315: // Ļ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:2 deadkey:46 deadkeyModifiers:64];
                break;
            case 316: // ļ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:0 deadkey:46 deadkeyModifiers:64];
                break;
            case 317: // Ľ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 318: // ľ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 319: // Ŀ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 320: // ŀ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 321: // Ł
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 322: // ł
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 323: // Ń
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:38 deadkeyModifiers:64];
                break;
            case 324: // ń
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:38 deadkeyModifiers:64];
                break;
            case 325: // Ņ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:46 deadkeyModifiers:64];
                break;
            case 326: // ņ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:46 deadkeyModifiers:64];
                break;
            case 327: // Ň
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 328: // ň
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 330: // Ŋ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 332: // Ō
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:48 deadkeyModifiers:66];
                break;
            case 333: // ō
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:48 deadkeyModifiers:66];
                break;
            case 334: // Ŏ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:33 deadkeyModifiers:64];
                break;
            case 335: // ŏ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:33 deadkeyModifiers:64];
                break;
            case 336: // Ő
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 337: // ő
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 340: // Ŕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:2 deadkey:38 deadkeyModifiers:64];
                break;
            case 341: // ŕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:0 deadkey:38 deadkeyModifiers:64];
                break;
            case 342: // Ŗ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:2 deadkey:46 deadkeyModifiers:64];
                break;
            case 343: // ŗ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:0 deadkey:46 deadkeyModifiers:64];
                break;
            case 344: // Ř
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 345: // ř
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 346: // Ś
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:38 deadkeyModifiers:64];
                break;
            case 347: // ś
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:38 deadkeyModifiers:64];
                break;
            case 348: // Ŝ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 349: // ŝ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 350: // Ş
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:46 deadkeyModifiers:64];
                break;
            case 351: // ş
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:46 deadkeyModifiers:64];
                break;
            case 352: // Š
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 353: // š
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 354: // Ţ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:2 deadkey:46 deadkeyModifiers:64];
                break;
            case 355: // ţ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:0 deadkey:46 deadkeyModifiers:64];
                break;
            case 356: // Ť
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 357: // ť
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 358: // Ŧ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 359: // ŧ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 360: // Ũ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:30 deadkeyModifiers:66];
                break;
            case 361: // ũ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:30 deadkeyModifiers:66];
                break;
            case 362: // Ū
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:48 deadkeyModifiers:66];
                break;
            case 363: // ū
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:48 deadkeyModifiers:66];
                break;
            case 364: // Ŭ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:33 deadkeyModifiers:64];
                break;
            case 365: // ŭ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:33 deadkeyModifiers:64];
                break;
            case 366: // Ů
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:34 deadkeyModifiers:64];
                break;
            case 367: // ů
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:34 deadkeyModifiers:64];
                break;
            case 368: // Ű
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 369: // ű
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 370: // Ų
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:35 deadkeyModifiers:64];
                break;
            case 371: // ų
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:35 deadkeyModifiers:64];
                break;
            case 372: // Ŵ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 373: // ŵ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 374: // Ŷ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 375: // ŷ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 376: // Ÿ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:45 deadkeyModifiers:64];
                break;
            case 377: // Ź
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:38 deadkeyModifiers:64];
                break;
            case 378: // ź
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:38 deadkeyModifiers:64];
                break;
            case 379: // Ż
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 380: // ż
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 381: // Ž
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 382: // ž
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 461: // Ǎ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 462: // ǎ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 463: // Ǐ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 464: // ǐ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 465: // Ǒ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 466: // ǒ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 467: // Ǔ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 468: // ǔ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 469: // Ǖ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:2 deadkey:48 deadkeyModifiers:66];
                break;
            case 470: // ǖ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:0 deadkey:48 deadkeyModifiers:66];
                break;
            case 471: // Ǘ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:2 deadkey:45 deadkeyModifiers:64];
                break;
            case 472: // ǘ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:0 deadkey:45 deadkeyModifiers:64];
                break;
            case 473: // Ǚ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 474: // ǚ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 475: // Ǜ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:2 deadkey:36 deadkeyModifiers:66];
                break;
            case 476: // ǜ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:0 deadkey:36 deadkeyModifiers:66];
                break;
            case 478: // Ǟ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:64 deadkey:48 deadkeyModifiers:66];
                break;
            case 479: // ǟ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:64 deadkey:48 deadkeyModifiers:66];
                break;
            case 486: // Ǧ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 487: // ǧ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 488: // Ǩ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 489: // ǩ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 490: // Ǫ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:35 deadkeyModifiers:64];
                break;
            case 491: // ǫ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:35 deadkeyModifiers:64];
                break;
            case 496: // ǰ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 500: // Ǵ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:38 deadkeyModifiers:64];
                break;
            case 501: // ǵ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:38 deadkeyModifiers:64];
                break;
            case 504: // Ǹ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:36 deadkeyModifiers:66];
                break;
            case 505: // ǹ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:36 deadkeyModifiers:66];
                break;
            case 506: // Ǻ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:2 deadkey:34 deadkeyModifiers:64];
                break;
            case 507: // ǻ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:0 deadkey:34 deadkeyModifiers:64];
                break;
            case 510: // Ǿ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:66 deadkey:38 deadkeyModifiers:64];
                break;
            case 542: // Ȟ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 543: // ȟ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 550: // Ȧ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 551: // ȧ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 552: // Ȩ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:46 deadkeyModifiers:64];
                break;
            case 553: // ȩ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:46 deadkeyModifiers:64];
                break;
            case 554: // Ȫ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:2 deadkey:48 deadkeyModifiers:66];
                break;
            case 555: // ȫ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:0 deadkey:48 deadkeyModifiers:66];
                break;
            case 558: // Ȯ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 559: // ȯ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 562: // Ȳ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:48 deadkeyModifiers:66];
                break;
            case 563: // ȳ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:48 deadkeyModifiers:66];
                break;
            case 567: // ȷ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 711: // ˇ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 728: // ˘
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 729: // ˙
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 731: // ˛
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 733: // ˝
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 836: //
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:66 deadkey:45 deadkeyModifiers:64];
                break;
            case 901: // ΅
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:66 deadkey:38 deadkeyModifiers:64];
                break;
            case 911: // Ώ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:66 deadkey:38 deadkeyModifiers:64];
                break;
            case 937: // Ω
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 7682: // Ḃ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 7683: // ḃ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 7690: // Ḋ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 7691: // ḋ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 7696: // Ḑ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:2 deadkey:46 deadkeyModifiers:64];
                break;
            case 7697: // ḑ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:0 deadkey:46 deadkeyModifiers:64];
                break;
            case 7702: // Ḗ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:2 deadkey:48 deadkeyModifiers:66];
                break;
            case 7703: // ḗ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:0 deadkey:48 deadkeyModifiers:66];
                break;
            case 7710: // Ḟ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 7711: // ḟ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 7712: // Ḡ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:48 deadkeyModifiers:66];
                break;
            case 7713: // ḡ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:48 deadkeyModifiers:66];
                break;
            case 7714: // Ḣ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 7715: // ḣ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 7718: // Ḧ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:45 deadkeyModifiers:64];
                break;
            case 7719: // ḧ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:45 deadkeyModifiers:64];
                break;
            case 7720: // Ḩ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:46 deadkeyModifiers:64];
                break;
            case 7721: // ḩ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:46 deadkeyModifiers:64];
                break;
            case 7726: // Ḯ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:100 modifiers:2 deadkey:45 deadkeyModifiers:64];
                break;
            case 7727: // ḯ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:100 modifiers:0 deadkey:45 deadkeyModifiers:64];
                break;
            case 7728: // Ḱ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:2 deadkey:38 deadkeyModifiers:64];
                break;
            case 7729: // ḱ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:0 deadkey:38 deadkeyModifiers:64];
                break;
            case 7742: // Ḿ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:2 deadkey:38 deadkeyModifiers:64];
                break;
            case 7743: // ḿ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:0 deadkey:38 deadkeyModifiers:64];
                break;
            case 7744: // Ṁ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 7745: // ṁ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 7748: // Ṅ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 7749: // ṅ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 7756: // Ṍ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:2 deadkey:30 deadkeyModifiers:66];
                break;
            case 7757: // ṍ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:0 deadkey:30 deadkeyModifiers:66];
                break;
            case 7758: // Ṏ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:2 deadkey:30 deadkeyModifiers:66];
                break;
            case 7759: // ṏ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:0 deadkey:30 deadkeyModifiers:66];
                break;
            case 7762: // Ṓ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:2 deadkey:48 deadkeyModifiers:66];
                break;
            case 7763: // ṓ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:0 deadkey:48 deadkeyModifiers:66];
                break;
            case 7764: // Ṕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:2 deadkey:38 deadkeyModifiers:64];
                break;
            case 7765: // ṕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:0 deadkey:38 deadkeyModifiers:64];
                break;
            case 7766: // Ṗ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 7767: // ṗ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 7768: // Ṙ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 7769: // ṙ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 7776: // Ṡ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 7777: // ṡ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 7786: // Ṫ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 7787: // ṫ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 7800: // Ṹ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:2 deadkey:30 deadkeyModifiers:66];
                break;
            case 7801: // ṹ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:0 deadkey:30 deadkeyModifiers:66];
                break;
            case 7804: // Ṽ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:2 deadkey:30 deadkeyModifiers:66];
                break;
            case 7805: // ṽ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:0 deadkey:30 deadkeyModifiers:66];
                break;
            case 7808: // Ẁ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:2 deadkey:36 deadkeyModifiers:66];
                break;
            case 7809: // ẁ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:36 deadkeyModifiers:66];
                break;
            case 7810: // Ẃ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:2 deadkey:38 deadkeyModifiers:64];
                break;
            case 7811: // ẃ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:38 deadkeyModifiers:64];
                break;
            case 7812: // Ẅ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:2 deadkey:45 deadkeyModifiers:64];
                break;
            case 7813: // ẅ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:45 deadkeyModifiers:64];
                break;
            case 7814: // Ẇ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 7815: // ẇ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 7818: // Ẋ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 7819: // ẋ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 7820: // Ẍ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:2 deadkey:45 deadkeyModifiers:64];
                break;
            case 7821: // ẍ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:0 deadkey:45 deadkeyModifiers:64];
                break;
            case 7822: // Ẏ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:37 deadkeyModifiers:64];
                break;
            case 7823: // ẏ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:37 deadkeyModifiers:64];
                break;
            case 7824: // Ẑ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 7825: // ẑ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 7831: // ẗ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:0 deadkey:45 deadkeyModifiers:64];
                break;
            case 7832: // ẘ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:34 deadkeyModifiers:64];
                break;
            case 7833: // ẙ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:34 deadkeyModifiers:64];
                break;
            case 7844: // Ấ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 7845: // ấ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 7854: // Ắ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:2 deadkey:33 deadkeyModifiers:64];
                break;
            case 7855: // ắ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:0 deadkey:33 deadkeyModifiers:64];
                break;
            case 7868: // Ẽ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:30 deadkeyModifiers:66];
                break;
            case 7869: // ẽ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:30 deadkeyModifiers:66];
                break;
            case 7870: // Ế
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 7871: // ế
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 7888: // Ố
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 7889: // ố
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 7922: // Ỳ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:36 deadkeyModifiers:66];
                break;
            case 7923: // ỳ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:36 deadkeyModifiers:66];
                break;
            case 7928: // Ỹ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:30 deadkeyModifiers:66];
                break;
            case 7929: // ỹ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:30 deadkeyModifiers:66];
                break;
            case 8173: // ῭
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:66 deadkey:36 deadkeyModifiers:66];
                break;
            case 8186: // Ὼ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:66 deadkey:36 deadkeyModifiers:66];
                break;
            case 8211: // –
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8216: // ‘
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8217: // ’
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8221: // ”
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8222: // „
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8304: // ⁰
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 8308: // ⁴
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 8309: // ⁵
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 8310: // ⁶
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 8311: // ⁷
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 8312: // ⁸
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 8313: // ⁹
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 8314: // ⁺
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 8315: // ⁻
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:0 deadkey:32 deadkeyModifiers:66];
                break;
            case 8316: // ⁼
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 8317: // ⁽
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 8318: // ⁾
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:2 deadkey:32 deadkeyModifiers:66];
                break;
            case 8320: // ₀
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 8321: // ₁
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 8322: // ₂
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 8323: // ₃
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 8324: // ₄
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 8325: // ₅
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 8326: // ₆
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 8327: // ₇
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 8328: // ₈
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 8329: // ₉
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 8330: // ₊
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 8331: // ₋
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:0 deadkey:31 deadkeyModifiers:64];
                break;
            case 8332: // ₌
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 8333: // ₍
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 8334: // ₎
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:2 deadkey:31 deadkeyModifiers:64];
                break;
            case 8364: // €
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8373: // ₵
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:66 deadkey:46 deadkeyModifiers:64];
                break;
            case 8593: // ↑
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8771: // ≃
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:2 deadkey:30 deadkeyModifiers:66];
                break;
            case 8818: // ≲
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:64 deadkey:30 deadkeyModifiers:66];
                break;
            case 8819: // ≳
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:64 deadkey:30 deadkeyModifiers:66];
                break;
    }
    return keyboardKeyModel;
}

- (NSString *)availableCharactersString {
    //\t\n !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~¢¤¥§¨©ª¬®¯°²³´¶¸¹ºÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåçèéêëìíîïñòóôõö÷ùúûüýÿĀāĂăĄąĆćĈĉĊċČčĎďĐđĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħĨĩĪīĬĭĮįİıĴĵĶķĹĺĻļĽľĿŀŁłŃńŅņŇňŊŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšŢţŤťŦŧŨũŪūŬŭŮůŰűŲųŴŵŶŷŸŹźŻżŽžǍǎǏǐǑǒǓǔǕǖǗǘǙǚǛǜǞǟǦǧǨǩǪǫǰǴǵǸǹǺǻǾȞȟȦȧȨȩȪȫȮȯȲȳȷˇ˘˙˛˝̈́΅ΏΩḂḃḊḋḐḑḖḗḞḟḠḡḢḣḦḧḨḩḮḯḰḱḾḿṀṁṄṅṌṍṎṏṒṓṔṕṖṗṘṙṠṡṪṫṸṹṼṽẀẁẂẃẄẅẆẇẊẋẌẍẎẏẐẑẗẘẙẤấẮắẼẽẾếỐốỲỳỸỹ῭Ὼ–‘’”„⁰⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎€₵↑≃≲≳
    return @"\t\n !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\u00A2\u00A4\u00A5\u00A7\u00A8\u00A9\u00AA\u00AC\u00AE\u00AF\u00B0\u00B2\u00B3\u00B4\u00B6\u00B8\u00B9\u00BA\u00C0\u00C1\u00C2\u00C3\u00C4\u00C5\u00C7\u00C8\u00C9\u00CA\u00CB\u00CC\u00CD\u00CE\u00CF\u00D0\u00D1\u00D2\u00D3\u00D4\u00D5\u00D6\u00D7\u00D8\u00D9\u00DA\u00DB\u00DC\u00DD\u00DE\u00DF\u00E0\u00E1\u00E2\u00E3\u00E4\u00E5\u00E7\u00E8\u00E9\u00EA\u00EB\u00EC\u00ED\u00EE\u00EF\u00F1\u00F2\u00F3\u00F4\u00F5\u00F6\u00F7\u00F9\u00FA\u00FB\u00FC\u00FD\u00FF\u0100\u0101\u0102\u0103\u0104\u0105\u0106\u0107\u0108\u0109\u010A\u010B\u010C\u010D\u010E\u010F\u0110\u0111\u0112\u0113\u0114\u0115\u0116\u0117\u0118\u0119\u011A\u011B\u011C\u011D\u011E\u011F\u0120\u0121\u0122\u0123\u0124\u0125\u0126\u0127\u0128\u0129\u012A\u012B\u012C\u012D\u012E\u012F\u0130\u0131\u0134\u0135\u0136\u0137\u0139\u013A\u013B\u013C\u013D\u013E\u013F\u0140\u0141\u0142\u0143\u0144\u0145\u0146\u0147\u0148\u014A\u014C\u014D\u014E\u014F\u0150\u0151\u0154\u0155\u0156\u0157\u0158\u0159\u015A\u015B\u015C\u015D\u015E\u015F\u0160\u0161\u0162\u0163\u0164\u0165\u0166\u0167\u0168\u0169\u016A\u016B\u016C\u016D\u016E\u016F\u0170\u0171\u0172\u0173\u0174\u0175\u0176\u0177\u0178\u0179\u017A\u017B\u017C\u017D\u017E\u01CD\u01CE\u01CF\u01D0\u01D1\u01D2\u01D3\u01D4\u01D5\u01D6\u01D7\u01D8\u01D9\u01DA\u01DB\u01DC\u01DE\u01DF\u01E6\u01E7\u01E8\u01E9\u01EA\u01EB\u01F0\u01F4\u01F5\u01F8\u01F9\u01FA\u01FB\u01FE\u021E\u021F\u0226\u0227\u0228\u0229\u022A\u022B\u022E\u022F\u0232\u0233\u0237\u02C7\u02D8\u02D9\u02DB\u02DD\u0344\u0385\u038F\u03A9\u1E02\u1E03\u1E0A\u1E0B\u1E10\u1E11\u1E16\u1E17\u1E1E\u1E1F\u1E20\u1E21\u1E22\u1E23\u1E26\u1E27\u1E28\u1E29\u1E2E\u1E2F\u1E30\u1E31\u1E3E\u1E3F\u1E40\u1E41\u1E44\u1E45\u1E4C\u1E4D\u1E4E\u1E4F\u1E52\u1E53\u1E54\u1E55\u1E56\u1E57\u1E58\u1E59\u1E60\u1E61\u1E6A\u1E6B\u1E78\u1E79\u1E7C\u1E7D\u1E80\u1E81\u1E82\u1E83\u1E84\u1E85\u1E86\u1E87\u1E8A\u1E8B\u1E8C\u1E8D\u1E8E\u1E8F\u1E90\u1E91\u1E97\u1E98\u1E99\u1EA4\u1EA5\u1EAE\u1EAF\u1EBC\u1EBD\u1EBE\u1EBF\u1ED0\u1ED1\u1EF2\u1EF3\u1EF8\u1EF9\u1FED\u1FFA\u2013\u2018\u2019\u201D\u201E\u2070\u2074\u2075\u2076\u2077\u2078\u2079\u207A\u207B\u207C\u207D\u207E\u2080\u2081\u2082\u2083\u2084\u2085\u2086\u2087\u2088\u2089\u208A\u208B\u208C\u208D\u208E\u20AC\u20B5\u2191\u2243\u2272\u2273";
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
        [lut addObject:[NSNumber numberWithInteger:164]];
        [lut addObject:[NSNumber numberWithInteger:165]];
        [lut addObject:[NSNumber numberWithInteger:167]];
        [lut addObject:[NSNumber numberWithInteger:168]];
        [lut addObject:[NSNumber numberWithInteger:169]];
        [lut addObject:[NSNumber numberWithInteger:170]];
        [lut addObject:[NSNumber numberWithInteger:172]];
        [lut addObject:[NSNumber numberWithInteger:174]];
        [lut addObject:[NSNumber numberWithInteger:175]];
        [lut addObject:[NSNumber numberWithInteger:176]];
        [lut addObject:[NSNumber numberWithInteger:178]];
        [lut addObject:[NSNumber numberWithInteger:179]];
        [lut addObject:[NSNumber numberWithInteger:180]];
        [lut addObject:[NSNumber numberWithInteger:182]];
        [lut addObject:[NSNumber numberWithInteger:184]];
        [lut addObject:[NSNumber numberWithInteger:185]];
        [lut addObject:[NSNumber numberWithInteger:186]];
        [lut addObject:[NSNumber numberWithInteger:192]];
        [lut addObject:[NSNumber numberWithInteger:193]];
        [lut addObject:[NSNumber numberWithInteger:194]];
        [lut addObject:[NSNumber numberWithInteger:195]];
        [lut addObject:[NSNumber numberWithInteger:196]];
        [lut addObject:[NSNumber numberWithInteger:197]];
        [lut addObject:[NSNumber numberWithInteger:199]];
        [lut addObject:[NSNumber numberWithInteger:200]];
        [lut addObject:[NSNumber numberWithInteger:201]];
        [lut addObject:[NSNumber numberWithInteger:202]];
        [lut addObject:[NSNumber numberWithInteger:203]];
        [lut addObject:[NSNumber numberWithInteger:204]];
        [lut addObject:[NSNumber numberWithInteger:205]];
        [lut addObject:[NSNumber numberWithInteger:206]];
        [lut addObject:[NSNumber numberWithInteger:207]];
        [lut addObject:[NSNumber numberWithInteger:208]];
        [lut addObject:[NSNumber numberWithInteger:209]];
        [lut addObject:[NSNumber numberWithInteger:210]];
        [lut addObject:[NSNumber numberWithInteger:211]];
        [lut addObject:[NSNumber numberWithInteger:212]];
        [lut addObject:[NSNumber numberWithInteger:213]];
        [lut addObject:[NSNumber numberWithInteger:214]];
        [lut addObject:[NSNumber numberWithInteger:215]];
        [lut addObject:[NSNumber numberWithInteger:216]];
        [lut addObject:[NSNumber numberWithInteger:217]];
        [lut addObject:[NSNumber numberWithInteger:218]];
        [lut addObject:[NSNumber numberWithInteger:219]];
        [lut addObject:[NSNumber numberWithInteger:220]];
        [lut addObject:[NSNumber numberWithInteger:221]];
        [lut addObject:[NSNumber numberWithInteger:222]];
        [lut addObject:[NSNumber numberWithInteger:223]];
        [lut addObject:[NSNumber numberWithInteger:224]];
        [lut addObject:[NSNumber numberWithInteger:225]];
        [lut addObject:[NSNumber numberWithInteger:226]];
        [lut addObject:[NSNumber numberWithInteger:227]];
        [lut addObject:[NSNumber numberWithInteger:228]];
        [lut addObject:[NSNumber numberWithInteger:229]];
        [lut addObject:[NSNumber numberWithInteger:231]];
        [lut addObject:[NSNumber numberWithInteger:232]];
        [lut addObject:[NSNumber numberWithInteger:233]];
        [lut addObject:[NSNumber numberWithInteger:234]];
        [lut addObject:[NSNumber numberWithInteger:235]];
        [lut addObject:[NSNumber numberWithInteger:236]];
        [lut addObject:[NSNumber numberWithInteger:237]];
        [lut addObject:[NSNumber numberWithInteger:238]];
        [lut addObject:[NSNumber numberWithInteger:239]];
        [lut addObject:[NSNumber numberWithInteger:241]];
        [lut addObject:[NSNumber numberWithInteger:242]];
        [lut addObject:[NSNumber numberWithInteger:243]];
        [lut addObject:[NSNumber numberWithInteger:244]];
        [lut addObject:[NSNumber numberWithInteger:245]];
        [lut addObject:[NSNumber numberWithInteger:246]];
        [lut addObject:[NSNumber numberWithInteger:247]];
        [lut addObject:[NSNumber numberWithInteger:249]];
        [lut addObject:[NSNumber numberWithInteger:250]];
        [lut addObject:[NSNumber numberWithInteger:251]];
        [lut addObject:[NSNumber numberWithInteger:252]];
        [lut addObject:[NSNumber numberWithInteger:253]];
        [lut addObject:[NSNumber numberWithInteger:255]];
        [lut addObject:[NSNumber numberWithInteger:256]];
        [lut addObject:[NSNumber numberWithInteger:257]];
        [lut addObject:[NSNumber numberWithInteger:258]];
        [lut addObject:[NSNumber numberWithInteger:259]];
        [lut addObject:[NSNumber numberWithInteger:260]];
        [lut addObject:[NSNumber numberWithInteger:261]];
        [lut addObject:[NSNumber numberWithInteger:262]];
        [lut addObject:[NSNumber numberWithInteger:263]];
        [lut addObject:[NSNumber numberWithInteger:264]];
        [lut addObject:[NSNumber numberWithInteger:265]];
        [lut addObject:[NSNumber numberWithInteger:266]];
        [lut addObject:[NSNumber numberWithInteger:267]];
        [lut addObject:[NSNumber numberWithInteger:268]];
        [lut addObject:[NSNumber numberWithInteger:269]];
        [lut addObject:[NSNumber numberWithInteger:270]];
        [lut addObject:[NSNumber numberWithInteger:271]];
        [lut addObject:[NSNumber numberWithInteger:272]];
        [lut addObject:[NSNumber numberWithInteger:273]];
        [lut addObject:[NSNumber numberWithInteger:274]];
        [lut addObject:[NSNumber numberWithInteger:275]];
        [lut addObject:[NSNumber numberWithInteger:276]];
        [lut addObject:[NSNumber numberWithInteger:277]];
        [lut addObject:[NSNumber numberWithInteger:278]];
        [lut addObject:[NSNumber numberWithInteger:279]];
        [lut addObject:[NSNumber numberWithInteger:280]];
        [lut addObject:[NSNumber numberWithInteger:281]];
        [lut addObject:[NSNumber numberWithInteger:282]];
        [lut addObject:[NSNumber numberWithInteger:283]];
        [lut addObject:[NSNumber numberWithInteger:284]];
        [lut addObject:[NSNumber numberWithInteger:285]];
        [lut addObject:[NSNumber numberWithInteger:286]];
        [lut addObject:[NSNumber numberWithInteger:287]];
        [lut addObject:[NSNumber numberWithInteger:288]];
        [lut addObject:[NSNumber numberWithInteger:289]];
        [lut addObject:[NSNumber numberWithInteger:290]];
        [lut addObject:[NSNumber numberWithInteger:291]];
        [lut addObject:[NSNumber numberWithInteger:292]];
        [lut addObject:[NSNumber numberWithInteger:293]];
        [lut addObject:[NSNumber numberWithInteger:294]];
        [lut addObject:[NSNumber numberWithInteger:295]];
        [lut addObject:[NSNumber numberWithInteger:296]];
        [lut addObject:[NSNumber numberWithInteger:297]];
        [lut addObject:[NSNumber numberWithInteger:298]];
        [lut addObject:[NSNumber numberWithInteger:299]];
        [lut addObject:[NSNumber numberWithInteger:300]];
        [lut addObject:[NSNumber numberWithInteger:301]];
        [lut addObject:[NSNumber numberWithInteger:302]];
        [lut addObject:[NSNumber numberWithInteger:303]];
        [lut addObject:[NSNumber numberWithInteger:304]];
        [lut addObject:[NSNumber numberWithInteger:305]];
        [lut addObject:[NSNumber numberWithInteger:308]];
        [lut addObject:[NSNumber numberWithInteger:309]];
        [lut addObject:[NSNumber numberWithInteger:310]];
        [lut addObject:[NSNumber numberWithInteger:311]];
        [lut addObject:[NSNumber numberWithInteger:313]];
        [lut addObject:[NSNumber numberWithInteger:314]];
        [lut addObject:[NSNumber numberWithInteger:315]];
        [lut addObject:[NSNumber numberWithInteger:316]];
        [lut addObject:[NSNumber numberWithInteger:317]];
        [lut addObject:[NSNumber numberWithInteger:318]];
        [lut addObject:[NSNumber numberWithInteger:319]];
        [lut addObject:[NSNumber numberWithInteger:320]];
        [lut addObject:[NSNumber numberWithInteger:321]];
        [lut addObject:[NSNumber numberWithInteger:322]];
        [lut addObject:[NSNumber numberWithInteger:323]];
        [lut addObject:[NSNumber numberWithInteger:324]];
        [lut addObject:[NSNumber numberWithInteger:325]];
        [lut addObject:[NSNumber numberWithInteger:326]];
        [lut addObject:[NSNumber numberWithInteger:327]];
        [lut addObject:[NSNumber numberWithInteger:328]];
        [lut addObject:[NSNumber numberWithInteger:330]];
        [lut addObject:[NSNumber numberWithInteger:332]];
        [lut addObject:[NSNumber numberWithInteger:333]];
        [lut addObject:[NSNumber numberWithInteger:334]];
        [lut addObject:[NSNumber numberWithInteger:335]];
        [lut addObject:[NSNumber numberWithInteger:336]];
        [lut addObject:[NSNumber numberWithInteger:337]];
        [lut addObject:[NSNumber numberWithInteger:340]];
        [lut addObject:[NSNumber numberWithInteger:341]];
        [lut addObject:[NSNumber numberWithInteger:342]];
        [lut addObject:[NSNumber numberWithInteger:343]];
        [lut addObject:[NSNumber numberWithInteger:344]];
        [lut addObject:[NSNumber numberWithInteger:345]];
        [lut addObject:[NSNumber numberWithInteger:346]];
        [lut addObject:[NSNumber numberWithInteger:347]];
        [lut addObject:[NSNumber numberWithInteger:348]];
        [lut addObject:[NSNumber numberWithInteger:349]];
        [lut addObject:[NSNumber numberWithInteger:350]];
        [lut addObject:[NSNumber numberWithInteger:351]];
        [lut addObject:[NSNumber numberWithInteger:352]];
        [lut addObject:[NSNumber numberWithInteger:353]];
        [lut addObject:[NSNumber numberWithInteger:354]];
        [lut addObject:[NSNumber numberWithInteger:355]];
        [lut addObject:[NSNumber numberWithInteger:356]];
        [lut addObject:[NSNumber numberWithInteger:357]];
        [lut addObject:[NSNumber numberWithInteger:358]];
        [lut addObject:[NSNumber numberWithInteger:359]];
        [lut addObject:[NSNumber numberWithInteger:360]];
        [lut addObject:[NSNumber numberWithInteger:361]];
        [lut addObject:[NSNumber numberWithInteger:362]];
        [lut addObject:[NSNumber numberWithInteger:363]];
        [lut addObject:[NSNumber numberWithInteger:364]];
        [lut addObject:[NSNumber numberWithInteger:365]];
        [lut addObject:[NSNumber numberWithInteger:366]];
        [lut addObject:[NSNumber numberWithInteger:367]];
        [lut addObject:[NSNumber numberWithInteger:368]];
        [lut addObject:[NSNumber numberWithInteger:369]];
        [lut addObject:[NSNumber numberWithInteger:370]];
        [lut addObject:[NSNumber numberWithInteger:371]];
        [lut addObject:[NSNumber numberWithInteger:372]];
        [lut addObject:[NSNumber numberWithInteger:373]];
        [lut addObject:[NSNumber numberWithInteger:374]];
        [lut addObject:[NSNumber numberWithInteger:375]];
        [lut addObject:[NSNumber numberWithInteger:376]];
        [lut addObject:[NSNumber numberWithInteger:377]];
        [lut addObject:[NSNumber numberWithInteger:378]];
        [lut addObject:[NSNumber numberWithInteger:379]];
        [lut addObject:[NSNumber numberWithInteger:380]];
        [lut addObject:[NSNumber numberWithInteger:381]];
        [lut addObject:[NSNumber numberWithInteger:382]];
        [lut addObject:[NSNumber numberWithInteger:461]];
        [lut addObject:[NSNumber numberWithInteger:462]];
        [lut addObject:[NSNumber numberWithInteger:463]];
        [lut addObject:[NSNumber numberWithInteger:464]];
        [lut addObject:[NSNumber numberWithInteger:465]];
        [lut addObject:[NSNumber numberWithInteger:466]];
        [lut addObject:[NSNumber numberWithInteger:467]];
        [lut addObject:[NSNumber numberWithInteger:468]];
        [lut addObject:[NSNumber numberWithInteger:469]];
        [lut addObject:[NSNumber numberWithInteger:470]];
        [lut addObject:[NSNumber numberWithInteger:471]];
        [lut addObject:[NSNumber numberWithInteger:472]];
        [lut addObject:[NSNumber numberWithInteger:473]];
        [lut addObject:[NSNumber numberWithInteger:474]];
        [lut addObject:[NSNumber numberWithInteger:475]];
        [lut addObject:[NSNumber numberWithInteger:476]];
        [lut addObject:[NSNumber numberWithInteger:478]];
        [lut addObject:[NSNumber numberWithInteger:479]];
        [lut addObject:[NSNumber numberWithInteger:486]];
        [lut addObject:[NSNumber numberWithInteger:487]];
        [lut addObject:[NSNumber numberWithInteger:488]];
        [lut addObject:[NSNumber numberWithInteger:489]];
        [lut addObject:[NSNumber numberWithInteger:490]];
        [lut addObject:[NSNumber numberWithInteger:491]];
        [lut addObject:[NSNumber numberWithInteger:496]];
        [lut addObject:[NSNumber numberWithInteger:500]];
        [lut addObject:[NSNumber numberWithInteger:501]];
        [lut addObject:[NSNumber numberWithInteger:504]];
        [lut addObject:[NSNumber numberWithInteger:505]];
        [lut addObject:[NSNumber numberWithInteger:506]];
        [lut addObject:[NSNumber numberWithInteger:507]];
        [lut addObject:[NSNumber numberWithInteger:510]];
        [lut addObject:[NSNumber numberWithInteger:542]];
        [lut addObject:[NSNumber numberWithInteger:543]];
        [lut addObject:[NSNumber numberWithInteger:550]];
        [lut addObject:[NSNumber numberWithInteger:551]];
        [lut addObject:[NSNumber numberWithInteger:552]];
        [lut addObject:[NSNumber numberWithInteger:553]];
        [lut addObject:[NSNumber numberWithInteger:554]];
        [lut addObject:[NSNumber numberWithInteger:555]];
        [lut addObject:[NSNumber numberWithInteger:558]];
        [lut addObject:[NSNumber numberWithInteger:559]];
        [lut addObject:[NSNumber numberWithInteger:562]];
        [lut addObject:[NSNumber numberWithInteger:563]];
        [lut addObject:[NSNumber numberWithInteger:567]];
        [lut addObject:[NSNumber numberWithInteger:711]];
        [lut addObject:[NSNumber numberWithInteger:728]];
        [lut addObject:[NSNumber numberWithInteger:729]];
        [lut addObject:[NSNumber numberWithInteger:731]];
        [lut addObject:[NSNumber numberWithInteger:733]];
        [lut addObject:[NSNumber numberWithInteger:836]];
        [lut addObject:[NSNumber numberWithInteger:901]];
        [lut addObject:[NSNumber numberWithInteger:911]];
        [lut addObject:[NSNumber numberWithInteger:937]];
        [lut addObject:[NSNumber numberWithInteger:7682]];
        [lut addObject:[NSNumber numberWithInteger:7683]];
        [lut addObject:[NSNumber numberWithInteger:7690]];
        [lut addObject:[NSNumber numberWithInteger:7691]];
        [lut addObject:[NSNumber numberWithInteger:7696]];
        [lut addObject:[NSNumber numberWithInteger:7697]];
        [lut addObject:[NSNumber numberWithInteger:7702]];
        [lut addObject:[NSNumber numberWithInteger:7703]];
        [lut addObject:[NSNumber numberWithInteger:7710]];
        [lut addObject:[NSNumber numberWithInteger:7711]];
        [lut addObject:[NSNumber numberWithInteger:7712]];
        [lut addObject:[NSNumber numberWithInteger:7713]];
        [lut addObject:[NSNumber numberWithInteger:7714]];
        [lut addObject:[NSNumber numberWithInteger:7715]];
        [lut addObject:[NSNumber numberWithInteger:7718]];
        [lut addObject:[NSNumber numberWithInteger:7719]];
        [lut addObject:[NSNumber numberWithInteger:7720]];
        [lut addObject:[NSNumber numberWithInteger:7721]];
        [lut addObject:[NSNumber numberWithInteger:7726]];
        [lut addObject:[NSNumber numberWithInteger:7727]];
        [lut addObject:[NSNumber numberWithInteger:7728]];
        [lut addObject:[NSNumber numberWithInteger:7729]];
        [lut addObject:[NSNumber numberWithInteger:7742]];
        [lut addObject:[NSNumber numberWithInteger:7743]];
        [lut addObject:[NSNumber numberWithInteger:7744]];
        [lut addObject:[NSNumber numberWithInteger:7745]];
        [lut addObject:[NSNumber numberWithInteger:7748]];
        [lut addObject:[NSNumber numberWithInteger:7749]];
        [lut addObject:[NSNumber numberWithInteger:7756]];
        [lut addObject:[NSNumber numberWithInteger:7757]];
        [lut addObject:[NSNumber numberWithInteger:7758]];
        [lut addObject:[NSNumber numberWithInteger:7759]];
        [lut addObject:[NSNumber numberWithInteger:7762]];
        [lut addObject:[NSNumber numberWithInteger:7763]];
        [lut addObject:[NSNumber numberWithInteger:7764]];
        [lut addObject:[NSNumber numberWithInteger:7765]];
        [lut addObject:[NSNumber numberWithInteger:7766]];
        [lut addObject:[NSNumber numberWithInteger:7767]];
        [lut addObject:[NSNumber numberWithInteger:7768]];
        [lut addObject:[NSNumber numberWithInteger:7769]];
        [lut addObject:[NSNumber numberWithInteger:7776]];
        [lut addObject:[NSNumber numberWithInteger:7777]];
        [lut addObject:[NSNumber numberWithInteger:7786]];
        [lut addObject:[NSNumber numberWithInteger:7787]];
        [lut addObject:[NSNumber numberWithInteger:7800]];
        [lut addObject:[NSNumber numberWithInteger:7801]];
        [lut addObject:[NSNumber numberWithInteger:7804]];
        [lut addObject:[NSNumber numberWithInteger:7805]];
        [lut addObject:[NSNumber numberWithInteger:7808]];
        [lut addObject:[NSNumber numberWithInteger:7809]];
        [lut addObject:[NSNumber numberWithInteger:7810]];
        [lut addObject:[NSNumber numberWithInteger:7811]];
        [lut addObject:[NSNumber numberWithInteger:7812]];
        [lut addObject:[NSNumber numberWithInteger:7813]];
        [lut addObject:[NSNumber numberWithInteger:7814]];
        [lut addObject:[NSNumber numberWithInteger:7815]];
        [lut addObject:[NSNumber numberWithInteger:7818]];
        [lut addObject:[NSNumber numberWithInteger:7819]];
        [lut addObject:[NSNumber numberWithInteger:7820]];
        [lut addObject:[NSNumber numberWithInteger:7821]];
        [lut addObject:[NSNumber numberWithInteger:7822]];
        [lut addObject:[NSNumber numberWithInteger:7823]];
        [lut addObject:[NSNumber numberWithInteger:7824]];
        [lut addObject:[NSNumber numberWithInteger:7825]];
        [lut addObject:[NSNumber numberWithInteger:7831]];
        [lut addObject:[NSNumber numberWithInteger:7832]];
        [lut addObject:[NSNumber numberWithInteger:7833]];
        [lut addObject:[NSNumber numberWithInteger:7844]];
        [lut addObject:[NSNumber numberWithInteger:7845]];
        [lut addObject:[NSNumber numberWithInteger:7854]];
        [lut addObject:[NSNumber numberWithInteger:7855]];
        [lut addObject:[NSNumber numberWithInteger:7868]];
        [lut addObject:[NSNumber numberWithInteger:7869]];
        [lut addObject:[NSNumber numberWithInteger:7870]];
        [lut addObject:[NSNumber numberWithInteger:7871]];
        [lut addObject:[NSNumber numberWithInteger:7888]];
        [lut addObject:[NSNumber numberWithInteger:7889]];
        [lut addObject:[NSNumber numberWithInteger:7922]];
        [lut addObject:[NSNumber numberWithInteger:7923]];
        [lut addObject:[NSNumber numberWithInteger:7928]];
        [lut addObject:[NSNumber numberWithInteger:7929]];
        [lut addObject:[NSNumber numberWithInteger:8173]];
        [lut addObject:[NSNumber numberWithInteger:8186]];
        [lut addObject:[NSNumber numberWithInteger:8211]];
        [lut addObject:[NSNumber numberWithInteger:8216]];
        [lut addObject:[NSNumber numberWithInteger:8217]];
        [lut addObject:[NSNumber numberWithInteger:8221]];
        [lut addObject:[NSNumber numberWithInteger:8222]];
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
        [lut addObject:[NSNumber numberWithInteger:8320]];
        [lut addObject:[NSNumber numberWithInteger:8321]];
        [lut addObject:[NSNumber numberWithInteger:8322]];
        [lut addObject:[NSNumber numberWithInteger:8323]];
        [lut addObject:[NSNumber numberWithInteger:8324]];
        [lut addObject:[NSNumber numberWithInteger:8325]];
        [lut addObject:[NSNumber numberWithInteger:8326]];
        [lut addObject:[NSNumber numberWithInteger:8327]];
        [lut addObject:[NSNumber numberWithInteger:8328]];
        [lut addObject:[NSNumber numberWithInteger:8329]];
        [lut addObject:[NSNumber numberWithInteger:8330]];
        [lut addObject:[NSNumber numberWithInteger:8331]];
        [lut addObject:[NSNumber numberWithInteger:8332]];
        [lut addObject:[NSNumber numberWithInteger:8333]];
        [lut addObject:[NSNumber numberWithInteger:8334]];
        [lut addObject:[NSNumber numberWithInteger:8364]];
        [lut addObject:[NSNumber numberWithInteger:8373]];
        [lut addObject:[NSNumber numberWithInteger:8593]];
        [lut addObject:[NSNumber numberWithInteger:8771]];
        [lut addObject:[NSNumber numberWithInteger:8818]];
        [lut addObject:[NSNumber numberWithInteger:8819]];
        _availableCharactersLUT = lut;
    }
    return _availableCharactersLUT;
}

- (InputStickKeyLabels *)keyLabels {
    if (_keyLabels == nil) {
        _keyLabels = [[InputStickKeyLabels alloc] init];
        [_keyLabels setupKey:0x04 withCharCodesArray:@[@0x00, @0x0061, @0x0041, @0x00E4, @0x00C4, @0x0041, @0x0061, @0x00C4, @0x00E4]];
        [_keyLabels setupKey:0x05 withCharCodesArray:@[@0x00, @0x0062, @0x0042, @0x007B, @0x2019, @0x0042, @0x0062, @0x007B, @0x2019]];
        [_keyLabels setupKey:0x06 withCharCodesArray:@[@0x00, @0x0063, @0x0043, @0x0026, @0x00A9, @0x0043, @0x0063, @0x0026, @0x00A9]];
        [_keyLabels setupKey:0x07 withCharCodesArray:@[@0x00, @0x0064, @0x0044, @0x0110, @0x00D0, @0x0044, @0x0064, @0x0110, @0x00D0]];
        [_keyLabels setupKey:0x08 withCharCodesArray:@[@0x00, @0x0065, @0x0045, @0x00C4, @0x0045, @0x0045, @0x0065, @0x00C4, @0x0045]];
        [_keyLabels setupKey:0x09 withCharCodesArray:@[@0x00, @0x0066, @0x0046, @0x005B, @0x00AA, @0x0046, @0x0066, @0x005B, @0x00AA]];
        [_keyLabels setupKey:0x0A withCharCodesArray:@[@0x00, @0x0067, @0x0047, @0x005D, @0x014A, @0x0047, @0x0067, @0x005D, @0x014A]];
        [_keyLabels setupKey:0x0B withCharCodesArray:@[@0x00, @0x0068, @0x0048, @0x0127, @0x0126, @0x0048, @0x0068, @0x0126, @0x0127]];
        [_keyLabels setupKey:0x0C withCharCodesArray:@[@0x00, @0x0069, @0x0049, @0x00CD, @0x00ED, @0x0049, @0x0069, @0x00CD, @0x00CD]];
        [_keyLabels setupKey:0x0D withCharCodesArray:@[@0x00, @0x006A, @0x004A, @0x00ED, @0x00CD, @0x004A, @0x006A, @0x00CD, @0x00ED]];
        [_keyLabels setupKey:0x0E withCharCodesArray:@[@0x00, @0x006B, @0x004B, @0x0142, @0x0026, @0x004B, @0x006B, @0x0141, @0x0026]];
        [_keyLabels setupKey:0x0F withCharCodesArray:@[@0x00, @0x006C, @0x004C, @0x0141, @0x0141, @0x004C, @0x006C, @0x0141, @0x0141]];
        [_keyLabels setupKey:0x10 withCharCodesArray:@[@0x00, @0x006D, @0x004D, @0x003C, @0x00BA, @0x004D, @0x006D, @0x003C, @0x00BA]];
        [_keyLabels setupKey:0x11 withCharCodesArray:@[@0x00, @0x006E, @0x004E, @0x007D, @0x004E, @0x004E, @0x006E, @0x007D, @0x004E]];
        [_keyLabels setupKey:0x12 withCharCodesArray:@[@0x00, @0x006F, @0x004F, @0x201E, @0x00D8, @0x004F, @0x006F, @0x201E, @0x00D8]];
        [_keyLabels setupKey:0x13 withCharCodesArray:@[@0x00, @0x0070, @0x0050, @0x201D, @0x00DE, @0x0050, @0x0070, @0x201D, @0x00DE]];
        [_keyLabels setupKey:0x14 withCharCodesArray:@[@0x00, @0x0071, @0x0051, @0x005C, @0x03A9, @0x0051, @0x0071, @0x005C, @0x03A9]];
        [_keyLabels setupKey:0x15 withCharCodesArray:@[@0x00, @0x0072, @0x0052, @0x00B6, @0x00AE, @0x0052, @0x0072, @0x00B6, @0x00AE]];
        [_keyLabels setupKey:0x16 withCharCodesArray:@[@0x00, @0x0073, @0x0053, @0x0111, @0x00A7, @0x0053, @0x0073, @0x0110, @0x00A7]];
        [_keyLabels setupKey:0x17 withCharCodesArray:@[@0x00, @0x0074, @0x0054, @0x0167, @0x0166, @0x0054, @0x0074, @0x0166, @0x0167]];
        [_keyLabels setupKey:0x18 withCharCodesArray:@[@0x00, @0x0075, @0x0055, @0x20AC, @0x2191, @0x0055, @0x0075, @0x20AC, @0x2191]];
        [_keyLabels setupKey:0x19 withCharCodesArray:@[@0x00, @0x0076, @0x0056, @0x0040, @0x2018, @0x0056, @0x0076, @0x0040, @0x2018]];
        [_keyLabels setupKey:0x1A withCharCodesArray:@[@0x00, @0x0077, @0x0057, @0x007C, @0x0141, @0x0057, @0x0077, @0x007C, @0x0141]];
        [_keyLabels setupKey:0x1B withCharCodesArray:@[@0x00, @0x0078, @0x0058, @0x0023, @0x003E, @0x0058, @0x0078, @0x0023, @0x003E]];
        [_keyLabels setupKey:0x1C withCharCodesArray:@[@0x00, @0x007A, @0x005A, @0x2013, @0x00A5, @0x005A, @0x007A, @0x2013, @0x00A5]];
        [_keyLabels setupKey:0x1D withCharCodesArray:@[@0x00, @0x0079, @0x0059, @0x003E, @0x003C, @0x0059, @0x0079, @0x003E, @0x003C]];
        [_keyLabels setupKey:0x1E withCharCodesArray:@[@0x88, @0x0031, @0x0027, @0x007E, @0x007E, @0x0031, @0x0027, @0x007E, @0x007E]];
        [_keyLabels setupKey:0x1F withCharCodesArray:@[@0x44, @0x0032, @0x0022, @0x02C7, @0x02C7, @0x0032, @0x0022, @0x02C7, @0x02C7]];
        [_keyLabels setupKey:0x20 withCharCodesArray:@[@0x88, @0x0033, @0x002B, @0x005E, @0x005E, @0x0033, @0x002B, @0x005E, @0x005E]];
        [_keyLabels setupKey:0x21 withCharCodesArray:@[@0x44, @0x0034, @0x0021, @0x02D8, @0x02D8, @0x0034, @0x0021, @0x02D8, @0x02D8]];
        [_keyLabels setupKey:0x22 withCharCodesArray:@[@0x44, @0x0035, @0x0025, @0x00B0, @0x00B0, @0x0035, @0x0025, @0x00B0, @0x00B0]];
        [_keyLabels setupKey:0x23 withCharCodesArray:@[@0x44, @0x0036, @0x002F, @0x02DB, @0x02DB, @0x0036, @0x002F, @0x02DB, @0x02DB]];
        [_keyLabels setupKey:0x24 withCharCodesArray:@[@0x88, @0x0037, @0x003D, @0x0060, @0x0060, @0x0037, @0x003D, @0x0060, @0x0060]];
        [_keyLabels setupKey:0x25 withCharCodesArray:@[@0x44, @0x0038, @0x0028, @0x02D9, @0x02D9, @0x0038, @0x0028, @0x02D9, @0x02D9]];
        [_keyLabels setupKey:0x26 withCharCodesArray:@[@0x44, @0x0039, @0x0029, @0x0027, @0x00B4, @0x0039, @0x0029, @0x0027, @0x00B4]];
        [_keyLabels setupKey:0x27 withCharCodesArray:@[@0x44, @0x00F6, @0x00D6, @0x02DD, @0x02DD, @0x00D6, @0x00F6, @0x02DD, @0x02DD]];
        [_keyLabels setupKey:0x2D withCharCodesArray:@[@0x44, @0x00FC, @0x00DC, @0x0022, @0x00A8, @0x00DC, @0x00FC, @0x0022, @0x00A8]];
        [_keyLabels setupKey:0x2E withCharCodesArray:@[@0x44, @0x00F3, @0x00D3, @0x00B8, @0x00B8, @0x00D3, @0x00F3, @0x00B8, @0x00B8]];
        [_keyLabels setupKey:0x2F withCharCodesArray:@[@0x88, @0x0151, @0x0150, @0x00F7, @0x00B0, @0x0150, @0x0151, @0x00F7, @0x00B0]];
        [_keyLabels setupKey:0x30 withCharCodesArray:@[@0x88, @0x00FA, @0x00DA, @0x00D7, @0x00AF, @0x00DA, @0x00FA, @0x00D7, @0x00AF]];
        [_keyLabels setupKey:0x31 withCharCodesArray:@[@0x88, @0x0171, @0x0170, @0x00A4, @0x02D8, @0x0170, @0x0171, @0x00A4, @0x02D8]];
        [_keyLabels setupKey:0x33 withCharCodesArray:@[@0x00, @0x00E9, @0x00C9, @0x0024, @0x00A2, @0x00C9, @0x00E9, @0x0024, @0x00A2]];
        [_keyLabels setupKey:0x34 withCharCodesArray:@[@0x88, @0x00E1, @0x00C1, @0x00DF, @0x02C7, @0x00C1, @0x00E1, @0x00DF, @0x02C7]];
        [_keyLabels setupKey:0x35 withCharCodesArray:@[@0x00, @0x0030, @0x00A7, @0x00AC, @0x00AC, @0x0030, @0x00A7, @0x00AC, @0x00AC]];
        [_keyLabels setupKey:0x36 withCharCodesArray:@[@0x00, @0x002C, @0x003F, @0x003B, @0x00D7, @0x002C, @0x003F, @0x003B, @0x00D7]];
        [_keyLabels setupKey:0x37 withCharCodesArray:@[@0x00, @0x002E, @0x003A, @0x003E, @0x00F7, @0x002E, @0x003A, @0x003E, @0x00F7]];
        [_keyLabels setupKey:0x38 withCharCodesArray:@[@0x88, @0x002D, @0x005F, @0x002A, @0x02D9, @0x002D, @0x005F, @0x002A, @0x02D9]];
        [_keyLabels setupKey:0x64 withCharCodesArray:@[@0x00, @0x00ED, @0x00CD, @0x003C, @0x003E, @0x00CD, @0x00ED, @0x003C, @0x003E]];
    }
    return _keyLabels;
}

@end
