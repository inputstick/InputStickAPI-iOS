/*
 * InputStickAPI-iOS
 * Copyright (c) 2020 Jakub Zawadzki, www.inputstick.com
 */
 
#import "InputStickKeyboardLayoutHuHUMac.h"
#import "InputStickKeyboardKeyModel.h"
#import "InputStickKeyLabels.h"

//InputStickKeyboardLayoutGenerator v1.00

@interface InputStickKeyboardLayoutHuHUMac () {
    InputStickKeyLabels *_keyLabels;
    NSArray<NSNumber *> *_availableCharactersLUT;
}

@end


@implementation InputStickKeyboardLayoutHuHUMac

- (NSString *)layoutCode {
    return @"hu-HU-mac";
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
    return @"HU macOS";
}

- (NSString *)layoutFullName {
    return @"Hungarian (Magyar) [HU macOS]";
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 36: // $
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 37: // %
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 38: // &
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:64 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:66 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 60: // <
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 61: // =
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 62: // >
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 63: // ?
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 64: // @
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:64 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 92: // backslash
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 93: // ]
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 94: // ^
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 95: // _
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 96: // `
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:64 deadkey:0 deadkeyModifiers:0];
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
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 124: // |
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:100 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 125: // }
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 126: // ~
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 163: // £
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 167: // §
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 168: // ¨
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 169: // ©
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 171: // «
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 172: // ¬
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 174: // ®
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 176: // °
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 182: // ¶
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 187: // »
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 193: // Á
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 196: // Ä
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:24 deadkeyModifiers:64];
                break;
            case 201: // É
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 205: // Í
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:100 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 211: // Ó
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 212: // Ô
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 213: // Õ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 214: // Ö
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 218: // Ú
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 220: // Ü
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 221: // Ý
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 223: // ß
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 225: // á
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 228: // ä
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:24 deadkeyModifiers:64];
                break;
            case 233: // é
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 237: // í
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:100 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 243: // ó
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 244: // ô
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:12 deadkeyModifiers:64];
                break;
            case 245: // õ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:17 deadkeyModifiers:64];
                break;
            case 246: // ö
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 247: // ÷
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 250: // ú
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 252: // ü
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 253: // ý
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 260: // Ą
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 261: // ą
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 263: // ć
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 268: // Č
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:52 deadkeyModifiers:66];
                break;
            case 269: // č
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:52 deadkeyModifiers:66];
                break;
            case 281: // ę
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 282: // Ě
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:52 deadkeyModifiers:66];
                break;
            case 283: // ě
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:52 deadkeyModifiers:66];
                break;
            case 290: // Ģ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 298: // Ī
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 299: // ī
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 302: // Į
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 310: // Ķ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 311: // ķ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 315: // Ļ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 316: // ļ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 321: // Ł
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 322: // ł
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 324: // ń
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 325: // Ņ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 327: // Ň
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:52 deadkeyModifiers:66];
                break;
            case 328: // ň
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:52 deadkeyModifiers:66];
                break;
            case 333: // ō
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 336: // Ő
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 337: // ő
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 340: // Ŕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:100 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 341: // ŕ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:30 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 342: // Ŗ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 343: // ŗ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:36 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 344: // Ř
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 345: // ř
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 347: // ś
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 352: // Š
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:52 deadkeyModifiers:66];
                break;
            case 353: // š
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 356: // Ť
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:2 deadkey:52 deadkeyModifiers:66];
                break;
            case 357: // ť
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 362: // Ū
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 366: // Ů
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 368: // Ű
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:2 deadkey:0 deadkeyModifiers:0];
                break;
            case 369: // ű
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:0 deadkey:0 deadkeyModifiers:0];
                break;
            case 370: // Ų
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 371: // ų
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 377: // Ź
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 378: // ź
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 379: // Ż
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 380: // ż
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 381: // Ž
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 382: // ž
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 711: // ˇ
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:44 modifiers:0 deadkey:52 deadkeyModifiers:66];
                break;
            case 8211: // –
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8212: // —
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8217: // ’
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8218: // ‚
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:66 deadkey:0 deadkeyModifiers:0];
                break;
            case 8221: // ”
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8222: // „
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8224: // †
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8226: // •
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8230: // …
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:51 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8249: // ‹
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8250: // ›
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8364: // €
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8482: // ™
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8706: // ∂
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8710: // ∆
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
            case 8800: // ≠
                keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:64 deadkey:0 deadkeyModifiers:0];
                break;
    }
    return keyboardKeyModel;
}

- (NSString *)availableCharactersString {
    //\t\n !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~£§¨©«¬®°¶»ÁÄÉÍÓÔÕÖÚÜÝßáäéíóôõö÷úüýĄąćČčęĚěĢĪīĮĶķĻļŁłńŅŇňōŐőŔŕŖŗŘřśŠšŤťŪŮŰűŲųŹźŻżŽžˇ–—’‚”„†•…‹›€™∂∆≠
    return @"\t\n !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\u00A3\u00A7\u00A8\u00A9\u00AB\u00AC\u00AE\u00B0\u00B6\u00BB\u00C1\u00C4\u00C9\u00CD\u00D3\u00D4\u00D5\u00D6\u00DA\u00DC\u00DD\u00DF\u00E1\u00E4\u00E9\u00ED\u00F3\u00F4\u00F5\u00F6\u00F7\u00FA\u00FC\u00FD\u0104\u0105\u0107\u010C\u010D\u0119\u011A\u011B\u0122\u012A\u012B\u012E\u0136\u0137\u013B\u013C\u0141\u0142\u0144\u0145\u0147\u0148\u014D\u0150\u0151\u0154\u0155\u0156\u0157\u0158\u0159\u015B\u0160\u0161\u0164\u0165\u016A\u016E\u0170\u0171\u0172\u0173\u0179\u017A\u017B\u017C\u017D\u017E\u02C7\u2013\u2014\u2019\u201A\u201D\u201E\u2020\u2022\u2026\u2039\u203A\u20AC\u2122\u2202\u2206\u2260";
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
        [lut addObject:[NSNumber numberWithInteger:163]];
        [lut addObject:[NSNumber numberWithInteger:167]];
        [lut addObject:[NSNumber numberWithInteger:168]];
        [lut addObject:[NSNumber numberWithInteger:169]];
        [lut addObject:[NSNumber numberWithInteger:171]];
        [lut addObject:[NSNumber numberWithInteger:172]];
        [lut addObject:[NSNumber numberWithInteger:174]];
        [lut addObject:[NSNumber numberWithInteger:176]];
        [lut addObject:[NSNumber numberWithInteger:182]];
        [lut addObject:[NSNumber numberWithInteger:187]];
        [lut addObject:[NSNumber numberWithInteger:193]];
        [lut addObject:[NSNumber numberWithInteger:196]];
        [lut addObject:[NSNumber numberWithInteger:201]];
        [lut addObject:[NSNumber numberWithInteger:205]];
        [lut addObject:[NSNumber numberWithInteger:211]];
        [lut addObject:[NSNumber numberWithInteger:212]];
        [lut addObject:[NSNumber numberWithInteger:213]];
        [lut addObject:[NSNumber numberWithInteger:214]];
        [lut addObject:[NSNumber numberWithInteger:218]];
        [lut addObject:[NSNumber numberWithInteger:220]];
        [lut addObject:[NSNumber numberWithInteger:221]];
        [lut addObject:[NSNumber numberWithInteger:223]];
        [lut addObject:[NSNumber numberWithInteger:225]];
        [lut addObject:[NSNumber numberWithInteger:228]];
        [lut addObject:[NSNumber numberWithInteger:233]];
        [lut addObject:[NSNumber numberWithInteger:237]];
        [lut addObject:[NSNumber numberWithInteger:243]];
        [lut addObject:[NSNumber numberWithInteger:244]];
        [lut addObject:[NSNumber numberWithInteger:245]];
        [lut addObject:[NSNumber numberWithInteger:246]];
        [lut addObject:[NSNumber numberWithInteger:247]];
        [lut addObject:[NSNumber numberWithInteger:250]];
        [lut addObject:[NSNumber numberWithInteger:252]];
        [lut addObject:[NSNumber numberWithInteger:253]];
        [lut addObject:[NSNumber numberWithInteger:260]];
        [lut addObject:[NSNumber numberWithInteger:261]];
        [lut addObject:[NSNumber numberWithInteger:263]];
        [lut addObject:[NSNumber numberWithInteger:268]];
        [lut addObject:[NSNumber numberWithInteger:269]];
        [lut addObject:[NSNumber numberWithInteger:281]];
        [lut addObject:[NSNumber numberWithInteger:282]];
        [lut addObject:[NSNumber numberWithInteger:283]];
        [lut addObject:[NSNumber numberWithInteger:290]];
        [lut addObject:[NSNumber numberWithInteger:298]];
        [lut addObject:[NSNumber numberWithInteger:299]];
        [lut addObject:[NSNumber numberWithInteger:302]];
        [lut addObject:[NSNumber numberWithInteger:310]];
        [lut addObject:[NSNumber numberWithInteger:311]];
        [lut addObject:[NSNumber numberWithInteger:315]];
        [lut addObject:[NSNumber numberWithInteger:316]];
        [lut addObject:[NSNumber numberWithInteger:321]];
        [lut addObject:[NSNumber numberWithInteger:322]];
        [lut addObject:[NSNumber numberWithInteger:324]];
        [lut addObject:[NSNumber numberWithInteger:325]];
        [lut addObject:[NSNumber numberWithInteger:327]];
        [lut addObject:[NSNumber numberWithInteger:328]];
        [lut addObject:[NSNumber numberWithInteger:333]];
        [lut addObject:[NSNumber numberWithInteger:336]];
        [lut addObject:[NSNumber numberWithInteger:337]];
        [lut addObject:[NSNumber numberWithInteger:340]];
        [lut addObject:[NSNumber numberWithInteger:341]];
        [lut addObject:[NSNumber numberWithInteger:342]];
        [lut addObject:[NSNumber numberWithInteger:343]];
        [lut addObject:[NSNumber numberWithInteger:344]];
        [lut addObject:[NSNumber numberWithInteger:345]];
        [lut addObject:[NSNumber numberWithInteger:347]];
        [lut addObject:[NSNumber numberWithInteger:352]];
        [lut addObject:[NSNumber numberWithInteger:353]];
        [lut addObject:[NSNumber numberWithInteger:356]];
        [lut addObject:[NSNumber numberWithInteger:357]];
        [lut addObject:[NSNumber numberWithInteger:362]];
        [lut addObject:[NSNumber numberWithInteger:366]];
        [lut addObject:[NSNumber numberWithInteger:368]];
        [lut addObject:[NSNumber numberWithInteger:369]];
        [lut addObject:[NSNumber numberWithInteger:370]];
        [lut addObject:[NSNumber numberWithInteger:371]];
        [lut addObject:[NSNumber numberWithInteger:377]];
        [lut addObject:[NSNumber numberWithInteger:378]];
        [lut addObject:[NSNumber numberWithInteger:379]];
        [lut addObject:[NSNumber numberWithInteger:380]];
        [lut addObject:[NSNumber numberWithInteger:381]];
        [lut addObject:[NSNumber numberWithInteger:382]];
        [lut addObject:[NSNumber numberWithInteger:711]];
        [lut addObject:[NSNumber numberWithInteger:8211]];
        [lut addObject:[NSNumber numberWithInteger:8212]];
        [lut addObject:[NSNumber numberWithInteger:8217]];
        [lut addObject:[NSNumber numberWithInteger:8218]];
        [lut addObject:[NSNumber numberWithInteger:8221]];
        [lut addObject:[NSNumber numberWithInteger:8222]];
        [lut addObject:[NSNumber numberWithInteger:8224]];
        [lut addObject:[NSNumber numberWithInteger:8226]];
        [lut addObject:[NSNumber numberWithInteger:8230]];
        [lut addObject:[NSNumber numberWithInteger:8249]];
        [lut addObject:[NSNumber numberWithInteger:8250]];
        [lut addObject:[NSNumber numberWithInteger:8364]];
        [lut addObject:[NSNumber numberWithInteger:8482]];
        [lut addObject:[NSNumber numberWithInteger:8706]];
        [lut addObject:[NSNumber numberWithInteger:8710]];
        [lut addObject:[NSNumber numberWithInteger:8800]];
        _availableCharactersLUT = lut;
    }
    return _availableCharactersLUT;
}

- (InputStickKeyLabels *)keyLabels {
    if (_keyLabels == nil) {
        _keyLabels = [[InputStickKeyLabels alloc] init];
        [_keyLabels setupKey:0x04 withCharCodesArray:@[@0x00, @0x0061, @0x0041, @0x0105, @0x0104, @0x0041, @0x0041, @0x0100, @0x0104]];
        [_keyLabels setupKey:0x05 withCharCodesArray:@[@0x00, @0x0062, @0x0042, @0x201D, @0x2019, @0x0042, @0x0042, @0x0171, @0x2019]];
        [_keyLabels setupKey:0x06 withCharCodesArray:@[@0x00, @0x0063, @0x0043, @0x0107, @0x00A9, @0x0043, @0x0043, @0x0101, @0x00A9]];
        [_keyLabels setupKey:0x07 withCharCodesArray:@[@0x00, @0x0064, @0x0044, @0x2202, @0x017D, @0x0044, @0x0044, @0x010C, @0x017D]];
        [_keyLabels setupKey:0x08 withCharCodesArray:@[@0x00, @0x0065, @0x0045, @0x20AC, @0x0161, @0x0045, @0x0045, @0x0161, @0x0161]];
        [_keyLabels setupKey:0x09 withCharCodesArray:@[@0x00, @0x0066, @0x0046, @0x0144, @0x017E, @0x0046, @0x0046, @0x010D, @0x017E]];
        [_keyLabels setupKey:0x0A withCharCodesArray:@[@0x00, @0x0067, @0x0047, @0x00A9, @0x016A, @0x0047, @0x0047, @0x010E, @0x016A]];
        [_keyLabels setupKey:0x0B withCharCodesArray:@[@0x00, @0x0068, @0x0048, @0x0137, @0x00D5, @0x0048, @0x0048, @0x010F, @0x00D5]];
        [_keyLabels setupKey:0x0C withCharCodesArray:@[@0x04, @0x0069, @0x0049, @0x005E, @0x0165, @0x0049, @0x0049, @0x0165, @0x0165]];
        [_keyLabels setupKey:0x0D withCharCodesArray:@[@0x00, @0x006A, @0x004A, @0x2206, @0x00D4, @0x004A, @0x004A, @0x0112, @0x00D4]];
        [_keyLabels setupKey:0x0E withCharCodesArray:@[@0x00, @0x006B, @0x004B, @0x017B, @0x0026, @0x004B, @0x004B, @0x016B, @0x0026]];
        [_keyLabels setupKey:0x0F withCharCodesArray:@[@0x00, @0x006C, @0x004C, @0x2022, @0x016E, @0x004C, @0x004C, @0x0113, @0x016E]];
        [_keyLabels setupKey:0x10 withCharCodesArray:@[@0x00, @0x006D, @0x004D, @0x0136, @0x0173, @0x004D, @0x004D, @0x0173, @0x0173]];
        [_keyLabels setupKey:0x11 withCharCodesArray:@[@0x04, @0x006E, @0x004E, @0x007E, @0x0172, @0x004E, @0x004E, @0x0172, @0x0172]];
        [_keyLabels setupKey:0x12 withCharCodesArray:@[@0x00, @0x006F, @0x004F, @0x0145, @0x012E, @0x004F, @0x004F, @0x00F4, @0x012E]];
        [_keyLabels setupKey:0x13 withCharCodesArray:@[@0x00, @0x0070, @0x0050, @0x013B, @0x0142, @0x0050, @0x0050, @0x00F5, @0x0142]];
        [_keyLabels setupKey:0x14 withCharCodesArray:@[@0x00, @0x0071, @0x0051, @0x0040, @0x013C, @0x0051, @0x0051, @0x0151, @0x013C]];
        [_keyLabels setupKey:0x15 withCharCodesArray:@[@0x00, @0x0072, @0x0052, @0x00B6, @0x00AE, @0x0052, @0x0052, @0x015A, @0x00AE]];
        [_keyLabels setupKey:0x16 withCharCodesArray:@[@0x00, @0x0073, @0x0053, @0x00DF, @0x017C, @0x0053, @0x0053, @0x013A, @0x017C]];
        [_keyLabels setupKey:0x17 withCharCodesArray:@[@0x00, @0x0074, @0x0054, @0x2020, @0x015B, @0x0054, @0x0054, @0x015B, @0x015B]];
        [_keyLabels setupKey:0x18 withCharCodesArray:@[@0x04, @0x0075, @0x0055, @0x00A8, @0x2020, @0x0055, @0x0055, @0x0164, @0x2020]];
        [_keyLabels setupKey:0x19 withCharCodesArray:@[@0x00, @0x0076, @0x0056, @0x201E, @0x201A, @0x0056, @0x0056, @0x25CA, @0x201A]];
        [_keyLabels setupKey:0x1A withCharCodesArray:@[@0x00, @0x0077, @0x0057, @0x0119, @0x0141, @0x0057, @0x0057, @0x0160, @0x0141]];
        [_keyLabels setupKey:0x1B withCharCodesArray:@[@0x00, @0x0078, @0x0058, @0x00BB, @0x003E, @0x0058, @0x0058, @0x0170, @0x003E]];
        [_keyLabels setupKey:0x1C withCharCodesArray:@[@0x00, @0x007A, @0x005A, @0x017A, @0x0179, @0x005A, @0x005A, @0x0146, @0x0179]];
        [_keyLabels setupKey:0x1D withCharCodesArray:@[@0x00, @0x0079, @0x0059, @0x00AB, @0x003C, @0x0059, @0x0059, @0x016F, @0x003C]];
        [_keyLabels setupKey:0x1E withCharCodesArray:@[@0x00, @0x0031, @0x0027, @0x0026, @0x0155, @0x0031, @0x0027, @0x0143, @0x0155]];
        [_keyLabels setupKey:0x1F withCharCodesArray:@[@0x00, @0x0032, @0x0022, @0x2122, @0x0158, @0x0032, @0x0022, @0x0148, @0x0158]];
        [_keyLabels setupKey:0x20 withCharCodesArray:@[@0x00, @0x0033, @0x002B, @0x00A3, @0x0023, @0x0033, @0x002B, @0x00A3, @0x0023]];
        [_keyLabels setupKey:0x21 withCharCodesArray:@[@0x00, @0x0034, @0x0021, @0x0024, @0x0024, @0x0034, @0x0021, @0x0118, @0x0024]];
        [_keyLabels setupKey:0x22 withCharCodesArray:@[@0x00, @0x0035, @0x0025, @0x2039, @0x0159, @0x0035, @0x0025, @0x012F, @0x0159]];
        [_keyLabels setupKey:0x23 withCharCodesArray:@[@0x00, @0x0036, @0x002F, @0x203A, @0x0156, @0x0036, @0x002F, @0x0116, @0x0156]];
        [_keyLabels setupKey:0x24 withCharCodesArray:@[@0x00, @0x0037, @0x003D, @0x007B, @0x0157, @0x0037, @0x003D, @0x0117, @0x0157]];
        [_keyLabels setupKey:0x25 withCharCodesArray:@[@0x00, @0x0038, @0x0028, @0x005B, @0x2122, @0x0038, @0x0028, @0x2022, @0x2122]];
        [_keyLabels setupKey:0x26 withCharCodesArray:@[@0x00, @0x0039, @0x0029, @0x005D, @0x007D, @0x0039, @0x0029, @0x013D, @0x007D]];
        [_keyLabels setupKey:0x27 withCharCodesArray:@[@0x00, @0x00F6, @0x00D6, @0x007D, @0x00B0, @0x00D6, @0x00D6, @0x013E, @0x00B0]];
        [_keyLabels setupKey:0x2D withCharCodesArray:@[@0x00, @0x00FC, @0x00DC, @0x005C, @0x012B, @0x00DC, @0x00DC, @0x011A, @0x012B]];
        [_keyLabels setupKey:0x2E withCharCodesArray:@[@0x00, @0x00F3, @0x00D3, @0x2260, @0x012A, @0x00D3, @0x00D3, @0x011B, @0x012A]];
        [_keyLabels setupKey:0x2F withCharCodesArray:@[@0x00, @0x0151, @0x0150, @0x00A8, @0x00DD, @0x0150, @0x0150, @0x201C, @0x00DD]];
        [_keyLabels setupKey:0x30 withCharCodesArray:@[@0x00, @0x00FA, @0x00DA, @0x007E, @0x00FD, @0x00DA, @0x00DA, @0x2018, @0x00FD]];
        [_keyLabels setupKey:0x31 withCharCodesArray:@[@0x00, @0x0171, @0x0170, @0x0060, @0x0122, @0x0170, @0x0170, @0x0123, @0x0122]];
        [_keyLabels setupKey:0x33 withCharCodesArray:@[@0x00, @0x00E9, @0x00C9, @0x2026, @0x014D, @0x00C9, @0x00C9, @0x00E4, @0x014D]];
        [_keyLabels setupKey:0x34 withCharCodesArray:@[@0x88, @0x00E1, @0x00C1, @0x005E, @0x02C7, @0x00C1, @0x00C1, @0x00C4, @0x02C7]];
        [_keyLabels setupKey:0x35 withCharCodesArray:@[@0x00, @0x0030, @0x00A7, @0x00AC, @0x2022, @0x0030, @0x00A7, @0x0030, @0x2022]];
        [_keyLabels setupKey:0x36 withCharCodesArray:@[@0x04, @0x002C, @0x003F, @0x2013, @0x002A, @0x002C, @0x003F, @0x2264, @0x002A]];
        [_keyLabels setupKey:0x37 withCharCodesArray:@[@0x00, @0x002E, @0x003A, @0x003B, @0x00F7, @0x002E, @0x003A, @0x2265, @0x00F7]];
        [_keyLabels setupKey:0x38 withCharCodesArray:@[@0x00, @0x002D, @0x005F, @0x2013, @0x2014, @0x002D, @0x005F, @0x00F7, @0x2014]];
        [_keyLabels setupKey:0x64 withCharCodesArray:@[@0x00, @0x00ED, @0x00CD, @0x007C, @0x0154, @0x00CD, @0x00CD, @0x0060, @0x0154]];
    }
    return _keyLabels;
}

@end
