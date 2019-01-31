/*
 * InputStickAPI-iOS
 * Copyright (c) 2018 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickKeyboardUtils.h"
#import "InputStickKeyboardKeyModel.h"

#import "InputStickKeyboardHandler.h"
#import "InputStickKeyboardLayoutEnUS.h"
#import "InputStickKeyboardLayoutDaDK.h"
#import "InputStickKeyboardLayoutDeCH.h"
#import "InputStickKeyboardLayoutDeDE.h"
#import "InputStickKeyboardLayoutDeDEMac.h"
#import "InputStickKeyboardLayoutEnDV.h"
#import "InputStickKeyboardLayoutEnGB.h"
#import "InputStickKeyboardLayoutEsES.h"
#import "InputStickKeyboardLayoutFiFI.h"
#import "InputStickKeyboardLayoutFrCH.h"
#import "InputStickKeyboardLayoutFrFR.h"
#import "InputStickKeyboardLayoutHeIL.h"
#import "InputStickKeyboardLayoutItIT.h"
#import "InputStickKeyboardLayoutNbNO.h"
#import "InputStickKeyboardLayoutPlPL.h"
#import "InputStickKeyboardLayoutPtBR.h"
#import "InputStickKeyboardLayoutRuRU.h"
#import "InputStickKeyboardLayoutSkSK.h"
#import "InputStickKeyboardLayoutSvSE.h"
#import "InputStickKeyboardLayoutFrFRLinux.h"
#import "InputStickKeyboardLayoutPlPLLinux.h"
#import "InputStickKeyboardLayoutHuHU.h"
#import "InputStickKeyboardLayoutPtPT.h"
#import "InputStickKeyboardLayoutFrCA.h"
#import "InputStickKeyboardLayoutNlNL.h"
#import "InputStickKeyboardLayoutEnUSInt.h"
#import "InputStickKeyboardLayoutFrBE.h"
#import "InputStickKeyboardLayoutCsCZ.h"
#import "InputStickKeyboardLayoutCsCZProgrammers.h"
#import "InputStickKeyboardLayoutCsCZLinux.h"
#import "InputStickKeyboardLayoutHrHR.h"
#import "InputStickKeyboardLayoutElGR.h"


@implementation InputStickKeyboardUtils

#pragma mark - Keyboard layouts

+ (id <InputStickKeyboardLayoutProtocol>)keyboardLayoutWithCode:(NSString *)code {
    NSString *cmp = [code lowercaseString];
    
    if ([cmp isEqualToString:[InputStickKeyboardLayoutCsCZ layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutCsCZ alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutCsCZLinux layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutCsCZLinux alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutCsCZProgrammers layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutCsCZProgrammers alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutDaDK layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutDaDK alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutDeCH layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutDeCH alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutDeDE layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutDeDE alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutDeDEMac layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutDeDEMac alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutEnDV layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutEnDV alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutEnUS layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutEnUS alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutEnUSInt layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutEnUSInt alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutEnGB layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutEnGB alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutEsES layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutEsES alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutElGR layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutElGR alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutFiFI layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutFiFI alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutFrBE layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutFrBE alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutFrCA layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutFrCA alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutFrCH layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutFrCH alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutFrFR layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutFrFR alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutFrFRLinux layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutFrFRLinux alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutHeIL layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutHeIL alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutHrHR layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutHrHR alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutHuHU layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutHuHU alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutItIT layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutItIT alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutNbNO layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutNbNO alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutNlNL layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutNlNL alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutPlPL layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutPlPL alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutPlPLLinux layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutPlPLLinux alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutPtBR layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutPtBR alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutPtPT layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutPtPT alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutRuRU layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutRuRU alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutSkSK layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutSkSK alloc] init];
    }
    else if ([cmp isEqualToString:[InputStickKeyboardLayoutSvSE layoutCodeLowercase]]) {
        return [[InputStickKeyboardLayoutSvSE alloc] init];
    }
    
    return [[InputStickKeyboardLayoutEnUS alloc] init];
}

+ (NSArray<NSString *> *)getEnglishNamesOfAllKeyboardLayouts {
    NSArray<NSString *> *codes = @[
                       [InputStickKeyboardLayoutHrHR layoutEnglishName],                   //+Croatian
                       [InputStickKeyboardLayoutCsCZ layoutEnglishName],                   //+Czech
                       [InputStickKeyboardLayoutCsCZLinux layoutEnglishName],              //+Czech, LINUX
                       [InputStickKeyboardLayoutCsCZProgrammers layoutEnglishName],        //+Czech, PROGRAMMERS
                       [InputStickKeyboardLayoutCsCZ layoutEnglishName],                   //+Czech
                       [InputStickKeyboardLayoutDaDK layoutEnglishName],                   //+Dannish
                       [InputStickKeyboardLayoutNlNL layoutEnglishName],                   //+Dutch
                       [InputStickKeyboardLayoutEnDV layoutEnglishName],                   //+English, Dvorak
                       [InputStickKeyboardLayoutEnGB layoutEnglishName],                   //+English, UK
                       [InputStickKeyboardLayoutEnUSInt layoutEnglishName],                //+English, US International
                       [InputStickKeyboardLayoutEnUS layoutEnglishName],                   //+English, US
                       [InputStickKeyboardLayoutFiFI layoutEnglishName],                   //+Finnish
                       [InputStickKeyboardLayoutFrBE layoutEnglishName],                   //+French, Belgium
                       [InputStickKeyboardLayoutFrCA layoutEnglishName],                   //+French, Canada
                       [InputStickKeyboardLayoutFrFR layoutEnglishName],                   //+French
                       [InputStickKeyboardLayoutFrFRLinux layoutEnglishName],              //+French, LINUX
                       [InputStickKeyboardLayoutFrCH layoutEnglishName],                   //+French, Switzerland
                       [InputStickKeyboardLayoutDeDE layoutEnglishName],                   //+German
                       [InputStickKeyboardLayoutDeDEMac layoutEnglishName],                //+German, MAC
                       [InputStickKeyboardLayoutDeCH layoutEnglishName],                   //+German, Switzerland
                       [InputStickKeyboardLayoutElGR layoutEnglishName],                   //+Greek
                       [InputStickKeyboardLayoutHeIL layoutEnglishName],                   //+Hebrew
                       [InputStickKeyboardLayoutHuHU layoutEnglishName],                   //+Hungarian
                       [InputStickKeyboardLayoutItIT layoutEnglishName],                   //Italian
                       [InputStickKeyboardLayoutNbNO layoutEnglishName],                   //+Norwegian
                       [InputStickKeyboardLayoutPlPL layoutEnglishName],                   //+Polish
                       [InputStickKeyboardLayoutPlPLLinux layoutEnglishName],              //+Polish LINUX
                       [InputStickKeyboardLayoutPtBR layoutEnglishName],                   //+Portuguese, Brazil
                       [InputStickKeyboardLayoutPtPT layoutEnglishName],                   //+Portuguese
                       [InputStickKeyboardLayoutRuRU layoutEnglishName],                   //+Russian
                       [InputStickKeyboardLayoutSkSK layoutEnglishName],                   //+Slovak
                       [InputStickKeyboardLayoutEsES layoutEnglishName],                   //+Spanish
                       [InputStickKeyboardLayoutSvSE layoutEnglishName],                   //+Swedish
                       ];
    return codes;
}

+ (NSArray<NSString *> *)getFullNamesOfAllKeyboardLayouts {
    NSArray<NSString *> *codes = @[
                       [InputStickKeyboardLayoutHrHR layoutFullName],                   //+Croatian
                       [InputStickKeyboardLayoutCsCZ layoutFullName],                   //+Czech
                       [InputStickKeyboardLayoutCsCZLinux layoutFullName],              //+Czech, LINUX
                       [InputStickKeyboardLayoutCsCZProgrammers layoutFullName],        //+Czech, PROGRAMMERS
                       [InputStickKeyboardLayoutDaDK layoutFullName],                   //+Dannish
                       [InputStickKeyboardLayoutNlNL layoutFullName],                   //+Dutch
                       [InputStickKeyboardLayoutEnDV layoutFullName],                   //+English, Dvorak
                       [InputStickKeyboardLayoutEnGB layoutFullName],                   //+English, UK
                       [InputStickKeyboardLayoutEnUSInt layoutFullName],                //+English, US International
                       [InputStickKeyboardLayoutEnUS layoutFullName],                   //+English, US
                       [InputStickKeyboardLayoutFiFI layoutFullName],                   //+Finnish
                       [InputStickKeyboardLayoutFrBE layoutFullName],                   //+French, Belgium
                       [InputStickKeyboardLayoutFrCA layoutFullName],                   //+French, Canada
                       [InputStickKeyboardLayoutFrFR layoutFullName],                   //+French
                       [InputStickKeyboardLayoutFrFRLinux layoutFullName],              //+French, LINUX
                       [InputStickKeyboardLayoutFrCH layoutFullName],                   //+French, Switzerland
                       [InputStickKeyboardLayoutDeDE layoutFullName],                   //+German
                       [InputStickKeyboardLayoutDeDEMac layoutFullName],                //+German, MAC
                       [InputStickKeyboardLayoutDeCH layoutFullName],                   //+German, Switzerland
                       [InputStickKeyboardLayoutElGR layoutFullName],                   //+Greek
                       [InputStickKeyboardLayoutHeIL layoutFullName],                   //+Hebrew
                       [InputStickKeyboardLayoutHuHU layoutFullName],                   //+Hungarian
                       [InputStickKeyboardLayoutItIT layoutFullName],                   //Italian
                       [InputStickKeyboardLayoutNbNO layoutFullName],                   //+Norwegian
                       [InputStickKeyboardLayoutPlPL layoutFullName],                   //+Polish
                       [InputStickKeyboardLayoutPlPLLinux layoutFullName],              //+Polish LINUX
                       [InputStickKeyboardLayoutPtBR layoutFullName],                   //+Portuguese, Brazil
                       [InputStickKeyboardLayoutPtPT layoutFullName],                   //+Portuguese
                       [InputStickKeyboardLayoutRuRU layoutFullName],                   //+Russian
                       [InputStickKeyboardLayoutSkSK layoutFullName],                   //+Slovak
                       [InputStickKeyboardLayoutEsES layoutFullName],                   //+Spanish
                       [InputStickKeyboardLayoutSvSE layoutFullName],                   //+Swedish
                       ];
    return codes;
}

+ (NSArray<NSString *> *)getCodesOfAllKeyboardLayouts {
    NSArray<NSString *> *codes = @[
                       [InputStickKeyboardLayoutHrHR layoutCode],                   //+Croatian
                       [InputStickKeyboardLayoutCsCZ layoutCode],                   //+Czech
                       [InputStickKeyboardLayoutCsCZLinux layoutCode],              //+Czech, LINUX
                       [InputStickKeyboardLayoutCsCZProgrammers layoutCode],        //+Czech, PROGRAMMERS
                       [InputStickKeyboardLayoutDaDK layoutCode],                   //+Dannish
                       [InputStickKeyboardLayoutNlNL layoutCode],                   //+Dutch
                       [InputStickKeyboardLayoutEnDV layoutCode],                   //+English, Dvorak
                       [InputStickKeyboardLayoutEnGB layoutCode],                   //+English, UK
                       [InputStickKeyboardLayoutEnUSInt layoutCode],                //+English, US International
                       [InputStickKeyboardLayoutEnUS layoutCode],                   //+English, US
                       [InputStickKeyboardLayoutFiFI layoutCode],                   //+Finnish
                       [InputStickKeyboardLayoutFrBE layoutCode],                   //+French, Belgium
                       [InputStickKeyboardLayoutFrCA layoutCode],                   //+French, Canada
                       [InputStickKeyboardLayoutFrFR layoutCode],                   //+French
                       [InputStickKeyboardLayoutFrFRLinux layoutCode],              //+French, LINUX
                       [InputStickKeyboardLayoutFrCH layoutCode],                   //+French, Switzerland
                       [InputStickKeyboardLayoutDeDE layoutCode],                   //+German
                       [InputStickKeyboardLayoutDeDEMac layoutCode],                //+German, MAC
                       [InputStickKeyboardLayoutDeCH layoutCode],                   //+German, Switzerland
                       [InputStickKeyboardLayoutElGR layoutCode],                   //+Greek
                       [InputStickKeyboardLayoutHeIL layoutCode],                   //+Hebrew
                       [InputStickKeyboardLayoutHuHU layoutCode],                   //+Hungarian
                       [InputStickKeyboardLayoutItIT layoutCode],                   //Italian
                       [InputStickKeyboardLayoutNbNO layoutCode],                   //+Norwegian
                       [InputStickKeyboardLayoutPlPL layoutCode],                   //+Polish
                       [InputStickKeyboardLayoutPlPLLinux layoutCode],              //+Polish LINUX
                       [InputStickKeyboardLayoutPtBR layoutCode],                   //+Portuguese, Brazil
                       [InputStickKeyboardLayoutPtPT layoutCode],                   //+Portuguese
                       [InputStickKeyboardLayoutRuRU layoutCode],                   //+Russian
                       [InputStickKeyboardLayoutSkSK layoutCode],                   //+Slovak
                       [InputStickKeyboardLayoutEsES layoutCode],                   //+Spanish
                       [InputStickKeyboardLayoutSvSE layoutCode],                   //+Swedish
    ];
    return codes;
}


#pragma mark - Key labels

+ (NSUInteger)getKeyLabelsLUTIndexForModifiers:(Byte)modifiers {
    switch (modifiers) {
        case SHIFT_LEFT:
        case SHIFT_RIGHT:
            //case (SHIFT_LEFT | SHIFT_RIGHT): windows only
            return 1;
        case CTRL_LEFT:
        case CTRL_RIGHT:
            //case (CTRL_LEFT | CTRL_RIGHT): windwos only
            return 2;
        case ALT_RIGHT:
            //case (ALT_LEFT | CTRL_LEFT): windwos only
            //case (ALT_LEFT | CTRL_RIGHT): windwos only
            return 3;
        case (ALT_RIGHT | SHIFT_LEFT):
        case (ALT_RIGHT | SHIFT_RIGHT):
            //case (ALT_RIGHT | SHIFT_LEFT | SHIFT_RIGHT): windows only!
            //case (ALT_LEFT | CTRL_LEFT | SHIFT_LEFT): windwos only
            //case (ALT_LEFT | CTRL_RIGHT | SHIFT_LEFT): windwos only
            //case (ALT_LEFT | CTRL_LEFT | SHIFT_RIGHT): windwos only
            //case (ALT_LEFT | CTRL_RIGHT | SHIFT_RIGHT): windwos only
            //case (ALT_LEFT | CTRL_RIGHT | SHIFT_LEFT | SHIFT_RIGHT): windwos only
            return 4;
        default:
            return 0;
    }
}

+ (NSString *)getLabelForKey:(Byte)key withModifiers:(Byte)modifiers withKeyLabelsLUT:(NSArray *)lut {
    NSUInteger modIndex = [InputStickKeyboardUtils getKeyLabelsLUTIndexForModifiers:modifiers];
    if (key <= KEY_APPLICATION) {
        NSArray *labels = [lut objectAtIndex:(int)key];
        return [labels objectAtIndex:modIndex];
    } else {
        return @"";
    }
}

+ (NSArray *)getKeyLabelsLUTForLayout:(id <InputStickKeyboardLayoutProtocol>)layout {
    NSArray* lut = [[layout class] getLUT];
    NSMutableArray *labelsLUT = [[NSMutableArray alloc] init];
    [self addLabel:@"" toLUT:labelsLUT];                                 //0x00
    [self addLabel:@"" toLUT:labelsLUT];                                 //0x01
    [self addLabel:@"" toLUT:labelsLUT];                                 //0x02
    [self addLabel:@"" toLUT:labelsLUT];                                 //0x03
    [self addLabelsFromCodes:[lut objectAtIndex:0x1E] toLUT:labelsLUT];  //0x04  HIDKeycodes.KEY_A
    [self addLabelsFromCodes:[lut objectAtIndex:0x30] toLUT:labelsLUT];  //0x05  HIDKeycodes.KEY_B
    [self addLabelsFromCodes:[lut objectAtIndex:0x2E] toLUT:labelsLUT];  //0x06  HIDKeycodes.KEY_C
    [self addLabelsFromCodes:[lut objectAtIndex:0x20] toLUT:labelsLUT];  //0x07  HIDKeycodes.KEY_D
    [self addLabelsFromCodes:[lut objectAtIndex:0x12] toLUT:labelsLUT];  //0x08  HIDKeycodes.KEY_E
    [self addLabelsFromCodes:[lut objectAtIndex:0x21] toLUT:labelsLUT];  //0x09  HIDKeycodes.KEY_F
    [self addLabelsFromCodes:[lut objectAtIndex:0x22] toLUT:labelsLUT];  //0x0A  HIDKeycodes.KEY_G
    [self addLabelsFromCodes:[lut objectAtIndex:0x23] toLUT:labelsLUT];  //0x0B  HIDKeycodes.KEY_H
    [self addLabelsFromCodes:[lut objectAtIndex:0x17] toLUT:labelsLUT];  //0x0C  HIDKeycodes.KEY_I
    [self addLabelsFromCodes:[lut objectAtIndex:0x24] toLUT:labelsLUT];  //0x0D  HIDKeycodes.KEY_J
    [self addLabelsFromCodes:[lut objectAtIndex:0x25] toLUT:labelsLUT];  //0x0E  HIDKeycodes.KEY_K
    [self addLabelsFromCodes:[lut objectAtIndex:0x26] toLUT:labelsLUT];  //0x0F  HIDKeycodes.KEY_L
    
    [self addLabelsFromCodes:[lut objectAtIndex:0x32] toLUT:labelsLUT];  //0x10  HIDKeycodes.KEY_M
    [self addLabelsFromCodes:[lut objectAtIndex:0x31] toLUT:labelsLUT];  //0x11  HIDKeycodes.KEY_N
    [self addLabelsFromCodes:[lut objectAtIndex:0x18] toLUT:labelsLUT];  //0x12  HIDKeycodes.KEY_O
    [self addLabelsFromCodes:[lut objectAtIndex:0x19] toLUT:labelsLUT];  //0x13  HIDKeycodes.KEY_P
    [self addLabelsFromCodes:[lut objectAtIndex:0x10] toLUT:labelsLUT];  //0x14  HIDKeycodes.KEY_Q
    [self addLabelsFromCodes:[lut objectAtIndex:0x13] toLUT:labelsLUT];  //0x15  HIDKeycodes.KEY_R
    [self addLabelsFromCodes:[lut objectAtIndex:0x1F] toLUT:labelsLUT];  //0x16  HIDKeycodes.KEY_S
    [self addLabelsFromCodes:[lut objectAtIndex:0x14] toLUT:labelsLUT];  //0x17  HIDKeycodes.KEY_T
    [self addLabelsFromCodes:[lut objectAtIndex:0x16] toLUT:labelsLUT];  //0x18  HIDKeycodes.KEY_U
    [self addLabelsFromCodes:[lut objectAtIndex:0x2F] toLUT:labelsLUT];  //0x19  HIDKeycodes.KEY_V
    [self addLabelsFromCodes:[lut objectAtIndex:0x11] toLUT:labelsLUT];  //0x1A  HIDKeycodes.KEY_W
    [self addLabelsFromCodes:[lut objectAtIndex:0x2D] toLUT:labelsLUT];  //0x1B  HIDKeycodes.KEY_X
    [self addLabelsFromCodes:[lut objectAtIndex:0x15] toLUT:labelsLUT];  //0x1C  HIDKeycodes.KEY_Y
    [self addLabelsFromCodes:[lut objectAtIndex:0x2C] toLUT:labelsLUT];  //0x1D  HIDKeycodes.KEY_Z
    [self addLabelsFromCodes:[lut objectAtIndex:0x02] toLUT:labelsLUT];  //0x1E  HIDKeycodes.KEY_1
    [self addLabelsFromCodes:[lut objectAtIndex:0x03] toLUT:labelsLUT];  //0x1F  HIDKeycodes.KEY_2
    
    [self addLabelsFromCodes:[lut objectAtIndex:0x04] toLUT:labelsLUT];  //0x20  HIDKeycodes.KEY_3
    [self addLabelsFromCodes:[lut objectAtIndex:0x05] toLUT:labelsLUT];  //0x21  HIDKeycodes.KEY_4
    [self addLabelsFromCodes:[lut objectAtIndex:0x06] toLUT:labelsLUT];  //0x22  HIDKeycodes.KEY_5
    [self addLabelsFromCodes:[lut objectAtIndex:0x07] toLUT:labelsLUT];  //0x23  HIDKeycodes.KEY_6
    [self addLabelsFromCodes:[lut objectAtIndex:0x08] toLUT:labelsLUT];  //0x24  HIDKeycodes.KEY_7
    [self addLabelsFromCodes:[lut objectAtIndex:0x09] toLUT:labelsLUT];  //0x25  HIDKeycodes.KEY_8
    [self addLabelsFromCodes:[lut objectAtIndex:0x0A] toLUT:labelsLUT];  //0x26  HIDKeycodes.KEY_9
    [self addLabelsFromCodes:[lut objectAtIndex:0x0B] toLUT:labelsLUT];  //0x27  HIDKeycodes.KEY_0
    [self addLabel:@"Enter" toLUT:labelsLUT];                            //0x28  HIDKeycodes.KEY_ENTER
    [self addLabel:@"Esc" toLUT:labelsLUT];                              //0x29  HIDKeycodes.KEY_ESCAPE
    [self addLabel:@"Backspace" toLUT:labelsLUT];                        //0x2A  HIDKeycodes.KEY_BACKSPACE
    [self addLabel:@"Tab" toLUT:labelsLUT];                              //0x2B  HIDKeycodes.KEY_TAB
    [self addLabel:@"Space" toLUT:labelsLUT];                            //0x2C  HIDKeycodes.KEY_SPACEBAR
    [self addLabelsFromCodes:[lut objectAtIndex:0x0C] toLUT:labelsLUT];  //0x2D  HIDKeycodes.KEY_MINUS
    [self addLabelsFromCodes:[lut objectAtIndex:0x0D] toLUT:labelsLUT];  //0x2E  HIDKeycodes.KEY_EQUALS
    [self addLabelsFromCodes:[lut objectAtIndex:0x1A] toLUT:labelsLUT];  //0x2F  HIDKeycodes.KEY_LEFT_BRACKET
    
    [self addLabelsFromCodes:[lut objectAtIndex:0x1B] toLUT:labelsLUT];  //0x30  HIDKeycodes.KEY_RIGHT_BRACKET
    [self addLabelsFromCodes:[lut objectAtIndex:0x2B] toLUT:labelsLUT];  //0x31  HIDKeycodes.KEY_BACKSLASH
    [self addLabel:@"" toLUT:labelsLUT];                                 //0x32  HIDKeycodes.KEY_HASH_NON_US //not used
    [self addLabelsFromCodes:[lut objectAtIndex:0x27] toLUT:labelsLUT];  //0x33  HIDKeycodes.KEY_SEMICOLON
    [self addLabelsFromCodes:[lut objectAtIndex:0x28] toLUT:labelsLUT];  //0x34  HIDKeycodes.KEY_APOSTROPHE
    [self addLabelsFromCodes:[lut objectAtIndex:0x29] toLUT:labelsLUT];  //0x35  HIDKeycodes.KEY_GRAVE
    [self addLabelsFromCodes:[lut objectAtIndex:0x33] toLUT:labelsLUT];  //0x36  HIDKeycodes.KEY_COMA
    [self addLabelsFromCodes:[lut objectAtIndex:0x34] toLUT:labelsLUT];  //0x37  HIDKeycodes.KEY_DOT
    [self addLabelsFromCodes:[lut objectAtIndex:0x35] toLUT:labelsLUT];  //0x38  HIDKeycodes.KEY_SLASH
    [self addLabel:@"CapsLock" toLUT:labelsLUT];                         //0x39  HIDKeycodes.KEY_CAPS_LOCK
    [self addLabel:@"F1" toLUT:labelsLUT];                               //0x3A  HIDKeycodes.KEY_F1
    [self addLabel:@"F2" toLUT:labelsLUT];                               //0x3B  HIDKeycodes.KEY_F2
    [self addLabel:@"F3" toLUT:labelsLUT];                               //0x3C  HIDKeycodes.KEY_F3
    [self addLabel:@"F4" toLUT:labelsLUT];                               //0x3A  HIDKeycodes.KEY_F4
    [self addLabel:@"F5" toLUT:labelsLUT];                               //0x3B  HIDKeycodes.KEY_F5
    [self addLabel:@"F6" toLUT:labelsLUT];                               //0x3C  HIDKeycodes.KEY_F6
    
    [self addLabel:@"F7" toLUT:labelsLUT];                               //0x40  HIDKeycodes.KEY_F7
    [self addLabel:@"F8" toLUT:labelsLUT];                               //0x41  HIDKeycodes.KEY_F8
    [self addLabel:@"F9" toLUT:labelsLUT];                               //0x42  HIDKeycodes.KEY_F9
    [self addLabel:@"F10" toLUT:labelsLUT];                              //0x43  HIDKeycodes.KEY_F10
    [self addLabel:@"F11" toLUT:labelsLUT];                              //0x44  HIDKeycodes.KEY_F11
    [self addLabel:@"F12" toLUT:labelsLUT];                              //0x45  HIDKeycodes.KEY_F12
    [self addLabel:@"PrtSc/SysRq" toLUT:labelsLUT];                      //0x46  HIDKeycodes.KEY_PRINT_SCREEN
    [self addLabel:@"ScrollLock" toLUT:labelsLUT];                       //0x47  HIDKeycodes.KEY_SCROLL_LOCK
    [self addLabel:@"Pause/Break" toLUT:labelsLUT];                      //0x48  HIDKeycodes.KEY_PASUE
    [self addLabel:@"Insert" toLUT:labelsLUT];                           //0x49  HIDKeycodes.KEY_INSERT
    [self addLabel:@"Home" toLUT:labelsLUT];                             //0x4A  HIDKeycodes.KEY_HOME
    [self addLabel:@"PageUp" toLUT:labelsLUT];                           //0x4B  HIDKeycodes.KEY_PAGE_UP
    [self addLabel:@"Delete" toLUT:labelsLUT];                           //0x4C  HIDKeycodes.KEY_DELETE
    [self addLabel:@"End" toLUT:labelsLUT];                              //0x4D  HIDKeycodes.KEY_END
    [self addLabel:@"PageDown" toLUT:labelsLUT];                         //0x4E  HIDKeycodes.KEY_PAGE_DOWN
    [self addLabel:@"Right" toLUT:labelsLUT];                            //0x4F  HIDKeycodes.KEY_ARROW_RIGHT
    
    [self addLabel:@"Left" toLUT:labelsLUT];                             //0x50  HIDKeycodes.KEY_ARROW_LEFT
    [self addLabel:@"Down" toLUT:labelsLUT];                             //0x51  HIDKeycodes.KEY_ARROW_DOWN
    [self addLabel:@"Up" toLUT:labelsLUT];                               //0x52  HIDKeycodes.KEY_ARROW_UP
    [self addLabel:@"NumLock" toLUT:labelsLUT];                          //0x53  HIDKeycodes.KEY_NUM_LOCK
    [self addLabel:@"/" toLUT:labelsLUT];                                //0x54  HIDKeycodes.KEY_NUM_SLASH
    [self addLabel:@"*" toLUT:labelsLUT];                                //0x55  HIDKeycodes.KEY_NUM_STAR
    [self addLabel:@"-" toLUT:labelsLUT];                                //0x56  HIDKeycodes.KEY_NUM_MINUS
    [self addLabel:@"+" toLUT:labelsLUT];                                //0x57  HIDKeycodes.KEY_NUM_PLUS
    [self addLabel:@"Enter" toLUT:labelsLUT];                            //0x58  HIDKeycodes.KEY_NUM_ENTER
    [self addLabel:@"1" toLUT:labelsLUT];                                //0x59  HIDKeycodes.KEY_NUM_1
    [self addLabel:@"2" toLUT:labelsLUT];                                //0x5A  HIDKeycodes.KEY_NUM_2
    [self addLabel:@"3" toLUT:labelsLUT];                                //0x5B  HIDKeycodes.KEY_NUM_3
    [self addLabel:@"4" toLUT:labelsLUT];                                //0x5C  HIDKeycodes.KEY_NUM_4
    [self addLabel:@"5" toLUT:labelsLUT];                                //0x5D  HIDKeycodes.KEY_NUM_5
    [self addLabel:@"6" toLUT:labelsLUT];                                //0x5E  HIDKeycodes.KEY_NUM_6
    [self addLabel:@"7" toLUT:labelsLUT];                                //0x5F  HIDKeycodes.KEY_NUM_7
    
    [self addLabel:@"8" toLUT:labelsLUT];                                //0x60  HIDKeycodes.KEY_NUM_8
    [self addLabel:@"9" toLUT:labelsLUT];                                //0x61  HIDKeycodes.KEY_NUM_9
    [self addLabel:@"0" toLUT:labelsLUT];                                //0x62  HIDKeycodes.KEY_NUM_0
    [self addLabel:@"." toLUT:labelsLUT];                                //0x63  HIDKeycodes.KEY_NUM_DOT
    [self addLabelsFromCodes:[lut objectAtIndex:0x56] toLUT:labelsLUT];  //0x64  HIDKeycodes.KEY_BACKSLASH_NON_US
    [self addLabel:@"Ctx" toLUT:labelsLUT];                              //0x65  HIDKeycodes.KEY_APPLICATION
    
    return labelsLUT;
}


//helpers:
+ (NSString *)getLabelForCharCode:(NSNumber *)code defaultCode:(NSNumber *)failSafeCode {
    int intCode = [code intValue];
    if (intCode < 1) {
        intCode = [failSafeCode intValue];
    }
    return [NSString stringWithFormat: @"%C", (unichar)intCode];
}

//when label IS dependent on state of modifier keys
+ (void)addLabelsFromCodes:(NSArray *)codes toLUT:(NSMutableArray *)lut {
    NSArray *labels = [NSArray arrayWithObjects:    [self getLabelForCharCode:[codes objectAtIndex:1] defaultCode:[codes objectAtIndex:1]], //normnal
                                                    [self getLabelForCharCode:[codes objectAtIndex:2] defaultCode:[codes objectAtIndex:1]], //shift
                                                    [self getLabelForCharCode:[codes objectAtIndex:3] defaultCode:[codes objectAtIndex:1]], //ctrl
                                                    [self getLabelForCharCode:[codes objectAtIndex:4] defaultCode:[codes objectAtIndex:1]], //altGr
                                                    [self getLabelForCharCode:[codes objectAtIndex:5] defaultCode:[codes objectAtIndex:1]], //altGr+shift
                                                    nil];
    [lut addObject:labels];
}

//when label is NOT dependent on state of modifier keys
+ (void)addLabel:(NSString *)label toLUT:(NSMutableArray *)lut {
    NSArray *labels = [NSArray arrayWithObjects:    label, label, label, label, label, nil];
    [lut addObject:labels];
}

@end
