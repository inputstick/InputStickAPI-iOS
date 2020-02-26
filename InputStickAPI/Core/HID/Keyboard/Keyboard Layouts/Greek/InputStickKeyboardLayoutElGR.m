/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickKeyboardLayoutElGR.h"
#import "InputStickKeyboardKeyModel.h"

static NSString *const LocaleName =  @"el-GR";
static NSString *const NativeName =  @"Ελληνικά";
static NSString *const EnglishName = @"Greek";
static NSString *const Variant =     @"GR";
static InputStickKeyboardType const Type = KEYBOARD_ANSI;

@implementation InputStickKeyboardLayoutElGR

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

//el-GR
+ (InputStickKeyboardKeyModel *)getKeyModelForCharacter:(int)character {
    InputStickKeyboardKeyModel *keyboardKeyModel = nil;
    switch (character) {
        case 0: //empty
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:0 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 10: //enter
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:40 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 9: //tab
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:43 modifiers:0 deadkey:0 deadkeyModifiers:0];
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
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:52 modifiers:0 deadkey:0 deadkeyModifiers:0];
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
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 45: //-
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 46: //.
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 47: ///
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:0 deadkey:0 deadkeyModifiers:0];
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
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 59: //;
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:20 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 60: // <
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:54 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 61: //=
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 62: //>
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:55 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 63: //?
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:56 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 64: //@
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 91: //[
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 92: //backslash
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 93: //]
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 94: //^
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 95: //_
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 96: //`
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 123: //{
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 124: //|
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 125: //}
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 126: //~
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:53 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 163: //£
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:33 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 164: //¤
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:37 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 165: //¥
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 166: //¦
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:38 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 167: //§
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:34 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 168: //¨
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:44 modifiers:0 deadkey:51 deadkeyModifiers:2];
            break;
        case 169: //©
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 171: //«
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:47 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 172: //¬
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:49 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 174: //®
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 176: //°
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:39 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 177: //±
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:45 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 178: //²
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:31 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 179: //³
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:32 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 182: //¶
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:35 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 187: //»
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:48 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 189: //½
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:46 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
        case 900: //΄
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:44 modifiers:0 deadkey:51 deadkeyModifiers:0];
            break;
        case 901: //΅
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:44 modifiers:0 deadkey:26 deadkeyModifiers:2];
            break;
        case 902: //Ά
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:51 deadkeyModifiers:0];
            break;
        case 904: //Έ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:51 deadkeyModifiers:0];
            break;
        case 905: //Ή
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:51 deadkeyModifiers:0];
            break;
        case 906: //Ί
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:51 deadkeyModifiers:0];
            break;
        case 908: //Ό
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:51 deadkeyModifiers:0];
            break;
        case 910: //Ύ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:51 deadkeyModifiers:0];
            break;
        case 911: //Ώ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:2 deadkey:51 deadkeyModifiers:0];
            break;
        case 912: //ΐ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:26 deadkeyModifiers:2];
            break;
        case 913: //Α
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 914: //Β
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 915: //Γ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 916: //Δ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 917: //Ε
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 918: //Ζ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 919: //Η
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 920: //Θ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 921: //Ι
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 922: //Κ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 923: //Λ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 924: //Μ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 925: //Ν
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 926: //Ξ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 927: //Ο
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 928: //Π
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 929: //Ρ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 931: //Σ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 932: //Τ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 933: //Υ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 934: //Φ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 935: //Χ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 936: //Ψ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 937: //Ω
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:2 deadkey:0 deadkeyModifiers:0];
            break;
        case 938: //Ϊ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:2 deadkey:51 deadkeyModifiers:2];
            break;
        case 939: //Ϋ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:2 deadkey:51 deadkeyModifiers:2];
            break;
        case 940: //ά
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:51 deadkeyModifiers:0];
            break;
        case 941: //έ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:51 deadkeyModifiers:0];
            break;
        case 942: //ή
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:51 deadkeyModifiers:0];
            break;
        case 943: //ί
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:51 deadkeyModifiers:0];
            break;
        case 944: //ΰ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:26 deadkeyModifiers:2];
            break;
        case 945: //α
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:4 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 946: //β
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:5 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 947: //γ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:10 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 948: //δ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:7 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 949: //ε
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 950: //ζ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:29 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 951: //η
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:11 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 952: //θ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:24 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 953: //ι
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 954: //κ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:14 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 955: //λ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:15 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 956: //μ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:16 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 957: //ν
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:17 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 958: //ξ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:13 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 959: //ο
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 960: //π
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:19 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 961: //ρ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:21 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 962: //ς
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:26 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 963: //σ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:22 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 964: //τ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:23 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 965: //υ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 966: //φ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:9 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 967: //χ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:27 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 968: //ψ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:6 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 969: //ω
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:0 deadkey:0 deadkeyModifiers:0];
            break;
        case 970: //ϊ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:12 modifiers:0 deadkey:51 deadkeyModifiers:2];
            break;
        case 971: //ϋ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:51 deadkeyModifiers:2];
            break;
        case 972: //ό
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:18 modifiers:0 deadkey:51 deadkeyModifiers:0];
            break;
        case 973: //ύ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:28 modifiers:0 deadkey:51 deadkeyModifiers:0];
            break;
        case 974: //ώ
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:25 modifiers:0 deadkey:51 deadkeyModifiers:0];
            break;
        case 8364: //€
            keyboardKeyModel = [[InputStickKeyboardKeyModel alloc]initWithUnicodeCharacter:character key:8 modifiers:64 deadkey:0 deadkeyModifiers:0];
            break;
    }
    return keyboardKeyModel;
}

+ (NSArray<NSNumber *> *)getAvailableCharacters {
    NSMutableArray<NSNumber *> *array = [NSMutableArray array];
    [array addObject:[NSNumber numberWithInteger:0]];
    [array addObject:[NSNumber numberWithInteger:9]];
    [array addObject:[NSNumber numberWithInteger:10]];
    [array addObject:[NSNumber numberWithInteger:16]];
    [array addObject:[NSNumber numberWithInteger:27]];
    [array addObject:[NSNumber numberWithInteger:28]];
    [array addObject:[NSNumber numberWithInteger:29]];
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
    [array addObject:[NSNumber numberWithInteger:91]];
    [array addObject:[NSNumber numberWithInteger:92]];
    [array addObject:[NSNumber numberWithInteger:93]];
    [array addObject:[NSNumber numberWithInteger:94]];
    [array addObject:[NSNumber numberWithInteger:95]];
    [array addObject:[NSNumber numberWithInteger:96]];
    [array addObject:[NSNumber numberWithInteger:123]];
    [array addObject:[NSNumber numberWithInteger:124]];
    [array addObject:[NSNumber numberWithInteger:125]];
    [array addObject:[NSNumber numberWithInteger:126]];
    [array addObject:[NSNumber numberWithInteger:163]];
    [array addObject:[NSNumber numberWithInteger:164]];
    [array addObject:[NSNumber numberWithInteger:165]];
    [array addObject:[NSNumber numberWithInteger:166]];
    [array addObject:[NSNumber numberWithInteger:167]];
    [array addObject:[NSNumber numberWithInteger:168]];
    [array addObject:[NSNumber numberWithInteger:169]];
    [array addObject:[NSNumber numberWithInteger:171]];
    [array addObject:[NSNumber numberWithInteger:172]];
    [array addObject:[NSNumber numberWithInteger:174]];
    [array addObject:[NSNumber numberWithInteger:176]];
    [array addObject:[NSNumber numberWithInteger:177]];
    [array addObject:[NSNumber numberWithInteger:178]];
    [array addObject:[NSNumber numberWithInteger:179]];
    [array addObject:[NSNumber numberWithInteger:182]];
    [array addObject:[NSNumber numberWithInteger:187]];
    [array addObject:[NSNumber numberWithInteger:189]];
    [array addObject:[NSNumber numberWithInteger:900]];
    [array addObject:[NSNumber numberWithInteger:901]];
    [array addObject:[NSNumber numberWithInteger:902]];
    [array addObject:[NSNumber numberWithInteger:904]];
    [array addObject:[NSNumber numberWithInteger:905]];
    [array addObject:[NSNumber numberWithInteger:906]];
    [array addObject:[NSNumber numberWithInteger:908]];
    [array addObject:[NSNumber numberWithInteger:910]];
    [array addObject:[NSNumber numberWithInteger:911]];
    [array addObject:[NSNumber numberWithInteger:912]];
    [array addObject:[NSNumber numberWithInteger:913]];
    [array addObject:[NSNumber numberWithInteger:914]];
    [array addObject:[NSNumber numberWithInteger:915]];
    [array addObject:[NSNumber numberWithInteger:916]];
    [array addObject:[NSNumber numberWithInteger:917]];
    [array addObject:[NSNumber numberWithInteger:918]];
    [array addObject:[NSNumber numberWithInteger:919]];
    [array addObject:[NSNumber numberWithInteger:920]];
    [array addObject:[NSNumber numberWithInteger:921]];
    [array addObject:[NSNumber numberWithInteger:922]];
    [array addObject:[NSNumber numberWithInteger:923]];
    [array addObject:[NSNumber numberWithInteger:924]];
    [array addObject:[NSNumber numberWithInteger:925]];
    [array addObject:[NSNumber numberWithInteger:926]];
    [array addObject:[NSNumber numberWithInteger:927]];
    [array addObject:[NSNumber numberWithInteger:928]];
    [array addObject:[NSNumber numberWithInteger:929]];
    [array addObject:[NSNumber numberWithInteger:931]];
    [array addObject:[NSNumber numberWithInteger:932]];
    [array addObject:[NSNumber numberWithInteger:933]];
    [array addObject:[NSNumber numberWithInteger:934]];
    [array addObject:[NSNumber numberWithInteger:935]];
    [array addObject:[NSNumber numberWithInteger:936]];
    [array addObject:[NSNumber numberWithInteger:937]];
    [array addObject:[NSNumber numberWithInteger:938]];
    [array addObject:[NSNumber numberWithInteger:939]];
    [array addObject:[NSNumber numberWithInteger:940]];
    [array addObject:[NSNumber numberWithInteger:941]];
    [array addObject:[NSNumber numberWithInteger:942]];
    [array addObject:[NSNumber numberWithInteger:943]];
    [array addObject:[NSNumber numberWithInteger:944]];
    [array addObject:[NSNumber numberWithInteger:945]];
    [array addObject:[NSNumber numberWithInteger:946]];
    [array addObject:[NSNumber numberWithInteger:947]];
    [array addObject:[NSNumber numberWithInteger:948]];
    [array addObject:[NSNumber numberWithInteger:949]];
    [array addObject:[NSNumber numberWithInteger:950]];
    [array addObject:[NSNumber numberWithInteger:951]];
    [array addObject:[NSNumber numberWithInteger:952]];
    [array addObject:[NSNumber numberWithInteger:953]];
    [array addObject:[NSNumber numberWithInteger:954]];
    [array addObject:[NSNumber numberWithInteger:955]];
    [array addObject:[NSNumber numberWithInteger:956]];
    [array addObject:[NSNumber numberWithInteger:957]];
    [array addObject:[NSNumber numberWithInteger:958]];
    [array addObject:[NSNumber numberWithInteger:959]];
    [array addObject:[NSNumber numberWithInteger:960]];
    [array addObject:[NSNumber numberWithInteger:961]];
    [array addObject:[NSNumber numberWithInteger:962]];
    [array addObject:[NSNumber numberWithInteger:963]];
    [array addObject:[NSNumber numberWithInteger:964]];
    [array addObject:[NSNumber numberWithInteger:965]];
    [array addObject:[NSNumber numberWithInteger:966]];
    [array addObject:[NSNumber numberWithInteger:967]];
    [array addObject:[NSNumber numberWithInteger:968]];
    [array addObject:[NSNumber numberWithInteger:969]];
    [array addObject:[NSNumber numberWithInteger:970]];
    [array addObject:[NSNumber numberWithInteger:971]];
    [array addObject:[NSNumber numberWithInteger:972]];
    [array addObject:[NSNumber numberWithInteger:973]];
    [array addObject:[NSNumber numberWithInteger:974]];
    [array addObject:[NSNumber numberWithInteger:8364]];
    return array;
}

+ (NSArray *)getLUT {
    NSMutableArray *lut = [[NSMutableArray alloc] init];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  49], [NSNumber numberWithInt:  33], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  50], [NSNumber numberWithInt:  64], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 178], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  51], [NSNumber numberWithInt:  35], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 179], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  52], [NSNumber numberWithInt:  36], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 163], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  53], [NSNumber numberWithInt:  37], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 167], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  54], [NSNumber numberWithInt:  94], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 182], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  55], [NSNumber numberWithInt:  38], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  56], [NSNumber numberWithInt:  42], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 164], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  57], [NSNumber numberWithInt:  40], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 166], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  48], [NSNumber numberWithInt:  41], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 176], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  45], [NSNumber numberWithInt:  95], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 177], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  61], [NSNumber numberWithInt:  43], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 189], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  59], [NSNumber numberWithInt:  58], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt: 962], [NSNumber numberWithInt: 901], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 949], [NSNumber numberWithInt: 917], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:8364], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 961], [NSNumber numberWithInt: 929], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 174], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 964], [NSNumber numberWithInt: 932], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 965], [NSNumber numberWithInt: 933], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 165], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 952], [NSNumber numberWithInt: 920], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 953], [NSNumber numberWithInt: 921], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 959], [NSNumber numberWithInt: 927], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 960], [NSNumber numberWithInt: 928], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  91], [NSNumber numberWithInt: 123], [NSNumber numberWithInt:  27], [NSNumber numberWithInt: 171], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  93], [NSNumber numberWithInt: 125], [NSNumber numberWithInt:  29], [NSNumber numberWithInt: 187], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 945], [NSNumber numberWithInt: 913], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 963], [NSNumber numberWithInt: 931], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 948], [NSNumber numberWithInt: 916], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 966], [NSNumber numberWithInt: 934], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 947], [NSNumber numberWithInt: 915], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 951], [NSNumber numberWithInt: 919], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 958], [NSNumber numberWithInt: 926], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 954], [NSNumber numberWithInt: 922], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 955], [NSNumber numberWithInt: 923], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt: 900], [NSNumber numberWithInt: 168], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 901], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  39], [NSNumber numberWithInt:  34], [NSNumber numberWithInt:  28], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  96], [NSNumber numberWithInt: 126], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  92], [NSNumber numberWithInt: 124], [NSNumber numberWithInt:  28], [NSNumber numberWithInt: 172], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 950], [NSNumber numberWithInt: 918], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 967], [NSNumber numberWithInt: 935], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 968], [NSNumber numberWithInt: 936], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt: 169], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 969], [NSNumber numberWithInt: 937], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 946], [NSNumber numberWithInt: 914], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 957], [NSNumber numberWithInt: 925], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   1], [NSNumber numberWithInt: 956], [NSNumber numberWithInt: 924], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  44], [NSNumber numberWithInt:  60], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  46], [NSNumber numberWithInt:  62], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  47], [NSNumber numberWithInt:  63], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], [NSNumber numberWithInt:   0], nil]];
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  32], [NSNumber numberWithInt:  32], [NSNumber numberWithInt:  16], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
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
    [lut addObject:[NSArray arrayWithObjects: [NSNumber numberWithInt:   0], [NSNumber numberWithInt:  60], [NSNumber numberWithInt:  62], [NSNumber numberWithInt:  28], [NSNumber numberWithInt:  -1], [NSNumber numberWithInt:  -1], nil]];
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
