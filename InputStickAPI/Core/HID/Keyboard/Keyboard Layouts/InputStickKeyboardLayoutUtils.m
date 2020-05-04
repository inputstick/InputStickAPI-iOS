/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickKeyboardLayoutUtils.h"

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

@implementation InputStickKeyboardLayoutUtils

#pragma mark - Keyboard layouts

+ (NSArray<id <InputStickKeyboardLayoutProtocol>> *)allAvailableKeyboardLayouts {
    NSMutableArray *layouts = [[NSMutableArray alloc] init];
    [layouts addObject:[[InputStickKeyboardLayoutHrHR alloc] init]];             //+Croatian
    [layouts addObject:[[InputStickKeyboardLayoutCsCZ alloc] init]];             //+Czech
    [layouts addObject:[[InputStickKeyboardLayoutCsCZLinux alloc] init]];        //+Czech, LINUX
    [layouts addObject:[[InputStickKeyboardLayoutCsCZProgrammers alloc] init]];  //+Czech, PROGRAMMERS
    [layouts addObject:[[InputStickKeyboardLayoutDaDK alloc] init]];             //+Dannish
    [layouts addObject:[[InputStickKeyboardLayoutNlNL alloc] init]];             //+Dutch
    [layouts addObject:[[InputStickKeyboardLayoutEnDV alloc] init]];             //+English, Dvorak
    [layouts addObject:[[InputStickKeyboardLayoutEnGB alloc] init]];             //+English, UK
    [layouts addObject:[[InputStickKeyboardLayoutEnUSInt alloc] init]];          //+English, US International
    [layouts addObject:[[InputStickKeyboardLayoutEnUS alloc] init]];             //+English, US
    [layouts addObject:[[InputStickKeyboardLayoutFiFI alloc] init]];             //+Finnish
    [layouts addObject:[[InputStickKeyboardLayoutFrBE alloc] init]];             //+French, Belgium
    [layouts addObject:[[InputStickKeyboardLayoutFrCA alloc] init]];             //+French, Canada
    [layouts addObject:[[InputStickKeyboardLayoutFrFR alloc] init]];             //+French
    [layouts addObject:[[InputStickKeyboardLayoutFrFRLinux alloc] init]];        //+French, LINUX
    [layouts addObject:[[InputStickKeyboardLayoutFrCH alloc] init]];             //+French, Switzerland
    [layouts addObject:[[InputStickKeyboardLayoutDeDE alloc] init]];             //+German
    [layouts addObject:[[InputStickKeyboardLayoutDeDEMac alloc] init]];          //+German, MAC
    [layouts addObject:[[InputStickKeyboardLayoutDeCH alloc] init]];             //+German, Switzerland
    [layouts addObject:[[InputStickKeyboardLayoutElGR alloc] init]];             //+Greek
    [layouts addObject:[[InputStickKeyboardLayoutHeIL alloc] init]];             //+Hebrew
    [layouts addObject:[[InputStickKeyboardLayoutHuHU alloc] init]];             //+Hungarian
    [layouts addObject:[[InputStickKeyboardLayoutItIT alloc] init]];             //Italian
    [layouts addObject:[[InputStickKeyboardLayoutNbNO alloc] init]];             //+Norwegian
    [layouts addObject:[[InputStickKeyboardLayoutPlPL alloc] init]];             //+Polish
    [layouts addObject:[[InputStickKeyboardLayoutPlPLLinux alloc] init]];        //+Polish LINUX
    [layouts addObject:[[InputStickKeyboardLayoutPtBR alloc] init]];             //+Portuguese, Brazil
    [layouts addObject:[[InputStickKeyboardLayoutPtPT alloc] init]];             //+Portuguese
    [layouts addObject:[[InputStickKeyboardLayoutRuRU alloc] init]];             //+Russian
    [layouts addObject:[[InputStickKeyboardLayoutSkSK alloc] init]];             //+Slovak
    [layouts addObject:[[InputStickKeyboardLayoutEsES alloc] init]];             //+Spanish
    [layouts addObject:[[InputStickKeyboardLayoutSvSE alloc] init]];             //+Swedish
    return layouts;
}

+ (id <InputStickKeyboardLayoutProtocol>)keyboardLayoutWithCode:(NSString *)code {
    NSString *cmp = [code lowercaseString];
    NSArray *layouts = [InputStickKeyboardLayoutUtils allAvailableKeyboardLayouts];
    for (id <InputStickKeyboardLayoutProtocol> layout in layouts) {
        if ([cmp isEqualToString:[layout layoutCodeLowercase]]) {
            return layout;
        }
    }
    return [[InputStickKeyboardLayoutEnUS alloc] init];
}

+ (NSArray<NSString *> *)englishNamesOfAllKeyboardLayouts {
    NSMutableArray<NSString *> *codes = [[NSMutableArray alloc] init];
    NSArray *layouts = [InputStickKeyboardLayoutUtils allAvailableKeyboardLayouts];
    for (id <InputStickKeyboardLayoutProtocol> layout in layouts) {
        [codes addObject:[layout layoutEnglishName]];
    }
    return codes;
}

+ (NSArray<NSString *> *)fullNamesOfAllKeyboardLayouts {
    NSMutableArray<NSString *> *codes = [[NSMutableArray alloc] init];
    NSArray *layouts = [InputStickKeyboardLayoutUtils allAvailableKeyboardLayouts];
    for (id <InputStickKeyboardLayoutProtocol> layout in layouts) {
        [codes addObject:[layout layoutFullName]];
    }
    return codes;
}

+ (NSArray<NSString *> *)fullNamesOfKeyboardLayoutsWithLanguageCode:(NSString *)languageCode {
    NSMutableArray<NSString *> *codes = [[NSMutableArray alloc] init];
    NSArray *layouts = [InputStickKeyboardLayoutUtils allAvailableKeyboardLayouts];
    for (id <InputStickKeyboardLayoutProtocol> layout in layouts) {
        if (languageCode == nil) {
            [codes addObject:[layout layoutFullName]];
        } else {
            if ([[layout layoutCode] hasPrefix:languageCode]) {
                [codes addObject:[layout layoutFullName]];
            }
        }
    }
    return codes;
}

+ (NSArray<NSString *> *)codesOfAllKeyboardLayouts {
    NSMutableArray<NSString *> *codes = [[NSMutableArray alloc] init];
    NSArray *layouts = [InputStickKeyboardLayoutUtils allAvailableKeyboardLayouts];
    for (id <InputStickKeyboardLayoutProtocol> layout in layouts) {
        [codes addObject:[layout layoutCode]];
    }
    return codes;
}

+ (NSArray<NSString *> *)codesOfKeyboardLayoutsWithLanguageCode:(NSString *)languageCode {
    NSMutableArray<NSString *> *codes = [[NSMutableArray alloc] init];
    NSArray *layouts = [InputStickKeyboardLayoutUtils allAvailableKeyboardLayouts];
    for (id <InputStickKeyboardLayoutProtocol> layout in layouts) {
        if (languageCode == nil) {
            [codes addObject:[layout layoutCode]];
        } else {
            if ([[layout layoutCode] hasPrefix:languageCode]) {
                [codes addObject:[layout layoutCode]];
            }
        }
    }
    return codes;
}


+ (NSArray<NSString *> *)codesOfAllKeyboardLanguages {
    NSArray<NSString *> *codes = @[
                       @"hr",
                       @"cs",
                       @"da",
                       @"nl",
                       @"en",
                       @"fi",
                       @"fr",
                       @"de",
                       @"el",
                       @"he",
                       @"hu",
                       @"it",
                       @"nb",
                       @"pl",
                       @"pt",
                       @"ru",
                       @"sk",
                       @"es",
                       @"sv",
    ];
    return codes;
}

+ (NSArray<NSString *> *)namesOfAllKeyboardLanguages {
    NSArray<NSString *> *names = @[
                       @"Croatian",
                       @"Czech",
                       @"Dannish",
                       @"Dutch",
                       @"English",
                       @"Finnish",
                       @"French",
                       @"German",
                       @"Greek",
                       @"Hebrew",
                       @"Hungarian",
                       @"Italian",
                       @"Norwegian",
                       @"Polish",
                       @"Portuguese",
                       @"Russian",
                       @"Slovak",
                       @"Spanish",
                       @"Swedish",
    ];
    return names;
}


@end
