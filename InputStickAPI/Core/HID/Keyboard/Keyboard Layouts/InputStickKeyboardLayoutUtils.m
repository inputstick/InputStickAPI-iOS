/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickKeyboardLayoutUtils.h"
#import "InputStickKeyboardLayoutCsCZ.h"
#import "InputStickKeyboardLayoutCsCZProgrammers.h"
#import "InputStickKeyboardLayoutCsCZLinux.h"
#import "InputStickKeyboardLayoutCsCZMac.h"
#import "InputStickKeyboardLayoutDaDK.h"
#import "InputStickKeyboardLayoutDaDKLinux.h"
#import "InputStickKeyboardLayoutDaDKMac.h"
#import "InputStickKeyboardLayoutDeCH.h"
#import "InputStickKeyboardLayoutDeCHLinux.h"
#import "InputStickKeyboardLayoutDeCHMac.h"
#import "InputStickKeyboardLayoutDeDE.h"
#import "InputStickKeyboardLayoutDeDELinux.h"
#import "InputStickKeyboardLayoutDeDEMac.h"
#import "InputStickKeyboardLayoutElGR.h"
#import "InputStickKeyboardLayoutElGRLinux.h"
#import "InputStickKeyboardLayoutElGRMac.h"
#import "InputStickKeyboardLayoutEnDV.h"
#import "InputStickKeyboardLayoutEnGB.h"
#import "InputStickKeyboardLayoutEnGBLinux.h"
#import "InputStickKeyboardLayoutEnGBMac.h"
#import "InputStickKeyboardLayoutEnUS.h"
#import "InputStickKeyboardLayoutEnUSMac.h"
#import "InputStickKeyboardLayoutEnUSLinux.h"
#import "InputStickKeyboardLayoutEnUSInt.h"
#import "InputStickKeyboardLayoutEnUSIntLinux.h"
#import "InputStickKeyboardLayoutEnUSIntMac.h"
#import "InputStickKeyboardLayoutEsES.h"
#import "InputStickKeyboardLayoutEsESLinux.h"
#import "InputStickKeyboardLayoutEsESMac.h"
#import "InputStickKeyboardLayoutFiFI.h"
#import "InputStickKeyboardLayoutFiFILinux.h"
#import "InputStickKeyboardLayoutFiFIMac.h"
#import "InputStickKeyboardLayoutFrBE.h"
#import "InputStickKeyboardLayoutFrBELinux.h"
#import "InputStickKeyboardLayoutFrBEMac.h"
#import "InputStickKeyboardLayoutFrCA.h"
#import "InputStickKeyboardLayoutFrCALinux.h"
#import "InputStickKeyboardLayoutFrCAMac.h"
#import "InputStickKeyboardLayoutFrCH.h"
#import "InputStickKeyboardLayoutFrCHLinux.h"
#import "InputStickKeyboardLayoutFrCHMac.h"
#import "InputStickKeyboardLayoutFrFR.h"
#import "InputStickKeyboardLayoutFrFRLinux.h"
#import "InputStickKeyboardLayoutFrFRMac.h"
#import "InputStickKeyboardLayoutHeIL.h"
#import "InputStickKeyboardLayoutHeILLinux.h"
#import "InputStickKeyboardLayoutHeILMac.h"
#import "InputStickKeyboardLayoutHrHR.h"
#import "InputStickKeyboardLayoutHrHRLinux.h"
#import "InputStickKeyboardLayoutHrHRMac.h"
#import "InputStickKeyboardLayoutHuHU.h"
#import "InputStickKeyboardLayoutHuHULinux.h"
#import "InputStickKeyboardLayoutHuHUMac.h"
#import "InputStickKeyboardLayoutItIT.h"
#import "InputStickKeyboardLayoutItITLinux.h"
#import "InputStickKeyboardLayoutItITMac.h"
#import "InputStickKeyboardLayoutNbNO.h"
#import "InputStickKeyboardLayoutNbNOLinux.h"
#import "InputStickKeyboardLayoutNbNOMac.h"
#import "InputStickKeyboardLayoutNlNL.h"
#import "InputStickKeyboardLayoutNlNLLinux.h"
#import "InputStickKeyboardLayoutNlNLMac.h"
#import "InputStickKeyboardLayoutPlPL.h"
#import "InputStickKeyboardLayoutPlPLLinux.h"
#import "InputStickKeyboardLayoutPlPLMac.h"
#import "InputStickKeyboardLayoutPtBR.h"
#import "InputStickKeyboardLayoutPtBRLinux.h"
#import "InputStickKeyboardLayoutPtBRMac.h"
#import "InputStickKeyboardLayoutPtPT.h"
#import "InputStickKeyboardLayoutPtPTLinux.h"
#import "InputStickKeyboardLayoutPtPTMac.h"
#import "InputStickKeyboardLayoutRuRU.h"
#import "InputStickKeyboardLayoutRuRULinux.h"
#import "InputStickKeyboardLayoutRuRUMac.h"
#import "InputStickKeyboardLayoutSkSK.h"
#import "InputStickKeyboardLayoutSkSKMac.h"
#import "InputStickKeyboardLayoutSkSKLinux.h"
#import "InputStickKeyboardLayoutSvSE.h"
#import "InputStickKeyboardLayoutSvSELinux.h"
#import "InputStickKeyboardLayoutSvSEMac.h"


@implementation InputStickKeyboardLayoutUtils

#pragma mark - Keyboard layouts

+ (NSArray<id <InputStickKeyboardLayoutProtocol>> *)allAvailableKeyboardLayouts {
    NSMutableArray *layouts = [[NSMutableArray alloc] init];
    [layouts addObject:[[InputStickKeyboardLayoutHrHR alloc] init]];             //Croatian
    [layouts addObject:[[InputStickKeyboardLayoutHrHRLinux alloc] init]];        //Croatian, Linux
    [layouts addObject:[[InputStickKeyboardLayoutHrHRMac alloc] init]];          //Croatian, macOS
    [layouts addObject:[[InputStickKeyboardLayoutCsCZ alloc] init]];             //Czech
    [layouts addObject:[[InputStickKeyboardLayoutCsCZLinux alloc] init]];        //Czech, Linux
    [layouts addObject:[[InputStickKeyboardLayoutCsCZMac alloc] init]];          //Czech, macOS
    [layouts addObject:[[InputStickKeyboardLayoutCsCZProgrammers alloc] init]];  //Czech, PROGRAMMERS
    [layouts addObject:[[InputStickKeyboardLayoutDaDK alloc] init]];             //Dannish
    [layouts addObject:[[InputStickKeyboardLayoutDaDKLinux alloc] init]];        //Dannish, Linux
    [layouts addObject:[[InputStickKeyboardLayoutDaDKMac alloc] init]];          //Dannish, macOS
    [layouts addObject:[[InputStickKeyboardLayoutNlNL alloc] init]];             //Dutch
    [layouts addObject:[[InputStickKeyboardLayoutNlNLLinux alloc] init]];        //Dutch, Linux
    [layouts addObject:[[InputStickKeyboardLayoutNlNLMac alloc] init]];          //Dutch, macOS
    [layouts addObject:[[InputStickKeyboardLayoutEnGB alloc] init]];             //English, UK
    [layouts addObject:[[InputStickKeyboardLayoutEnGBLinux alloc] init]];        //English, UK, Linux
    [layouts addObject:[[InputStickKeyboardLayoutEnGBMac alloc] init]];          //English, UK, macOS
    [layouts addObject:[[InputStickKeyboardLayoutEnUSInt alloc] init]];          //English, US International
    [layouts addObject:[[InputStickKeyboardLayoutEnUSIntLinux alloc] init]];     //English, US International, Linux
    [layouts addObject:[[InputStickKeyboardLayoutEnUSIntMac alloc] init]];       //English, US International, macOS
    [layouts addObject:[[InputStickKeyboardLayoutEnUS alloc] init]];             //English, US
    [layouts addObject:[[InputStickKeyboardLayoutEnUSLinux alloc] init]];        //English, US, Linux
    [layouts addObject:[[InputStickKeyboardLayoutEnUSMac alloc] init]];          //English, US, macOS
    [layouts addObject:[[InputStickKeyboardLayoutEnDV alloc] init]];             //English, US, Dvorak
    [layouts addObject:[[InputStickKeyboardLayoutFiFI alloc] init]];             //Finnish
    [layouts addObject:[[InputStickKeyboardLayoutFiFILinux alloc] init]];        //Finnish, Linux
    [layouts addObject:[[InputStickKeyboardLayoutFiFIMac alloc] init]];          //Finnish, macOS
    [layouts addObject:[[InputStickKeyboardLayoutFrBE alloc] init]];             //French, Belgium
    [layouts addObject:[[InputStickKeyboardLayoutFrBELinux alloc] init]];        //French, Belgium, Linux
    [layouts addObject:[[InputStickKeyboardLayoutFrBEMac alloc] init]];          //French, Belgium, macOS
    [layouts addObject:[[InputStickKeyboardLayoutFrCA alloc] init]];             //French, Canada
    [layouts addObject:[[InputStickKeyboardLayoutFrCALinux alloc] init]];        //French, Canada, Linux
    [layouts addObject:[[InputStickKeyboardLayoutFrCAMac alloc] init]];          //French, Canada, macOS
    [layouts addObject:[[InputStickKeyboardLayoutFrFR alloc] init]];             //French
    [layouts addObject:[[InputStickKeyboardLayoutFrFRLinux alloc] init]];        //French, Linux
    [layouts addObject:[[InputStickKeyboardLayoutFrFRMac alloc] init]];          //French, macOS
    [layouts addObject:[[InputStickKeyboardLayoutFrCH alloc] init]];             //French, Switzerland
    [layouts addObject:[[InputStickKeyboardLayoutFrCHLinux alloc] init]];        //French, Switzerland, Linux
    [layouts addObject:[[InputStickKeyboardLayoutFrCHMac alloc] init]];          //French, Switzerland, macOS
    [layouts addObject:[[InputStickKeyboardLayoutDeDE alloc] init]];             //German
    [layouts addObject:[[InputStickKeyboardLayoutDeDELinux alloc] init]];        //German, Linux
    [layouts addObject:[[InputStickKeyboardLayoutDeDEMac alloc] init]];          //German, macOS
    [layouts addObject:[[InputStickKeyboardLayoutDeCH alloc] init]];             //German, Switzerland
    [layouts addObject:[[InputStickKeyboardLayoutDeCHLinux alloc] init]];        //German, Switzerland, Linux
    [layouts addObject:[[InputStickKeyboardLayoutDeCHMac alloc] init]];          //German, Switzerland, macOS
    [layouts addObject:[[InputStickKeyboardLayoutElGR alloc] init]];             //Greek
    [layouts addObject:[[InputStickKeyboardLayoutElGRLinux alloc] init]];        //Greek, Linux
    [layouts addObject:[[InputStickKeyboardLayoutElGRMac alloc] init]];          //Greek, macOS
    [layouts addObject:[[InputStickKeyboardLayoutHeIL alloc] init]];             //Hebrew
    [layouts addObject:[[InputStickKeyboardLayoutHeILLinux alloc] init]];        //Hebrew, Linux
    [layouts addObject:[[InputStickKeyboardLayoutHeILMac alloc] init]];          //Hebrew, macOS
    [layouts addObject:[[InputStickKeyboardLayoutHuHU alloc] init]];             //Hungarian
    [layouts addObject:[[InputStickKeyboardLayoutHuHULinux alloc] init]];        //Hungarian, Linux
    [layouts addObject:[[InputStickKeyboardLayoutHuHUMac alloc] init]];          //Hungarian, macOS
    [layouts addObject:[[InputStickKeyboardLayoutItIT alloc] init]];             //Italian
    [layouts addObject:[[InputStickKeyboardLayoutItITLinux alloc] init]];        //Italian, Linux
    [layouts addObject:[[InputStickKeyboardLayoutItITMac alloc] init]];          //Italian, macOS
    [layouts addObject:[[InputStickKeyboardLayoutNbNO alloc] init]];             //Norwegian
    [layouts addObject:[[InputStickKeyboardLayoutNbNOLinux alloc] init]];        //Norwegian, Linux
    [layouts addObject:[[InputStickKeyboardLayoutNbNOMac alloc] init]];          //Norwegian, macOS
    [layouts addObject:[[InputStickKeyboardLayoutPlPL alloc] init]];             //Polish
    [layouts addObject:[[InputStickKeyboardLayoutPlPLLinux alloc] init]];        //Polish, Linux
    [layouts addObject:[[InputStickKeyboardLayoutPlPLMac alloc] init]];          //Polish, macOS
    [layouts addObject:[[InputStickKeyboardLayoutPtBR alloc] init]];             //Portuguese, Brazil
    [layouts addObject:[[InputStickKeyboardLayoutPtBRLinux alloc] init]];        //Portuguese, Brazil, Linux
    [layouts addObject:[[InputStickKeyboardLayoutPtBRMac alloc] init]];          //Portuguese, Brazil, macOS
    [layouts addObject:[[InputStickKeyboardLayoutPtPT alloc] init]];             //Portuguese
    [layouts addObject:[[InputStickKeyboardLayoutPtPTLinux alloc] init]];        //Portuguese, Linux
    [layouts addObject:[[InputStickKeyboardLayoutPtPTMac alloc] init]];          //Portuguese, macOS
    [layouts addObject:[[InputStickKeyboardLayoutRuRU alloc] init]];             //Russian
    [layouts addObject:[[InputStickKeyboardLayoutRuRULinux alloc] init]];        //Russian, Linux
    [layouts addObject:[[InputStickKeyboardLayoutRuRUMac alloc] init]];          //Russian, macOS
    [layouts addObject:[[InputStickKeyboardLayoutSkSK alloc] init]];             //Slovak
    [layouts addObject:[[InputStickKeyboardLayoutSkSKMac alloc] init]];          //Slovak, macOS
    [layouts addObject:[[InputStickKeyboardLayoutSkSKLinux alloc] init]];        //Slovak, Linux
    [layouts addObject:[[InputStickKeyboardLayoutEsES alloc] init]];             //Spanish
    [layouts addObject:[[InputStickKeyboardLayoutEsESLinux alloc] init]];        //Spanish, Linux
    [layouts addObject:[[InputStickKeyboardLayoutEsESMac alloc] init]];          //Spanish, macOS
    [layouts addObject:[[InputStickKeyboardLayoutSvSE alloc] init]];             //Swedish
    [layouts addObject:[[InputStickKeyboardLayoutSvSELinux alloc] init]];        //Swedish, Linux
    [layouts addObject:[[InputStickKeyboardLayoutSvSEMac alloc] init]];          //Swedish, macOS
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
