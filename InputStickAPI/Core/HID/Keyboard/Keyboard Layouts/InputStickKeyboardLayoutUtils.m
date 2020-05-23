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
#import "InputStickKeyboardLayoutEnUSDvorak.h"
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

+ (NSArray<id <InputStickKeyboardLayoutProtocol>> *)keyboardLayouts {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [result addObject:[[InputStickKeyboardLayoutHrHR alloc] init]];             //Croatian
    [result addObject:[[InputStickKeyboardLayoutHrHRLinux alloc] init]];        //Croatian, Linux
    [result addObject:[[InputStickKeyboardLayoutHrHRMac alloc] init]];          //Croatian, macOS
    [result addObject:[[InputStickKeyboardLayoutCsCZ alloc] init]];             //Czech
    [result addObject:[[InputStickKeyboardLayoutCsCZLinux alloc] init]];        //Czech, Linux
    [result addObject:[[InputStickKeyboardLayoutCsCZMac alloc] init]];          //Czech, macOS
    [result addObject:[[InputStickKeyboardLayoutCsCZProgrammers alloc] init]];  //Czech, PROGRAMMERS
    [result addObject:[[InputStickKeyboardLayoutDaDK alloc] init]];             //Dannish
    [result addObject:[[InputStickKeyboardLayoutDaDKLinux alloc] init]];        //Dannish, Linux
    [result addObject:[[InputStickKeyboardLayoutDaDKMac alloc] init]];          //Dannish, macOS
    [result addObject:[[InputStickKeyboardLayoutNlNL alloc] init]];             //Dutch
    [result addObject:[[InputStickKeyboardLayoutNlNLLinux alloc] init]];        //Dutch, Linux
    [result addObject:[[InputStickKeyboardLayoutNlNLMac alloc] init]];          //Dutch, macOS
    [result addObject:[[InputStickKeyboardLayoutEnUS alloc] init]];             //English, US
    [result addObject:[[InputStickKeyboardLayoutEnUSLinux alloc] init]];        //English, US, Linux
    [result addObject:[[InputStickKeyboardLayoutEnUSMac alloc] init]];          //English, US, macOS
    [result addObject:[[InputStickKeyboardLayoutEnUSInt alloc] init]];          //English, US International
    [result addObject:[[InputStickKeyboardLayoutEnUSIntLinux alloc] init]];     //English, US International, Linux
    [result addObject:[[InputStickKeyboardLayoutEnUSIntMac alloc] init]];       //English, US International, macOS
    [result addObject:[[InputStickKeyboardLayoutEnUSDvorak alloc] init]];       //English, US, Dvorak
    [result addObject:[[InputStickKeyboardLayoutEnGB alloc] init]];             //English, UK
    [result addObject:[[InputStickKeyboardLayoutEnGBLinux alloc] init]];        //English, UK, Linux
    [result addObject:[[InputStickKeyboardLayoutEnGBMac alloc] init]];          //English, UK, macOS
    [result addObject:[[InputStickKeyboardLayoutFiFI alloc] init]];             //Finnish
    [result addObject:[[InputStickKeyboardLayoutFiFILinux alloc] init]];        //Finnish, Linux
    [result addObject:[[InputStickKeyboardLayoutFiFIMac alloc] init]];          //Finnish, macOS
    [result addObject:[[InputStickKeyboardLayoutFrFR alloc] init]];             //French
    [result addObject:[[InputStickKeyboardLayoutFrFRLinux alloc] init]];        //French, Linux
    [result addObject:[[InputStickKeyboardLayoutFrFRMac alloc] init]];          //French, macOS
    [result addObject:[[InputStickKeyboardLayoutFrBE alloc] init]];             //French, Belgium
    [result addObject:[[InputStickKeyboardLayoutFrBELinux alloc] init]];        //French, Belgium, Linux
    [result addObject:[[InputStickKeyboardLayoutFrBEMac alloc] init]];          //French, Belgium, macOS
    [result addObject:[[InputStickKeyboardLayoutFrCA alloc] init]];             //French, Canada
    [result addObject:[[InputStickKeyboardLayoutFrCALinux alloc] init]];        //French, Canada, Linux
    [result addObject:[[InputStickKeyboardLayoutFrCAMac alloc] init]];          //French, Canada, macOS
    [result addObject:[[InputStickKeyboardLayoutFrCH alloc] init]];             //French, Switzerland
    [result addObject:[[InputStickKeyboardLayoutFrCHLinux alloc] init]];        //French, Switzerland, Linux
    [result addObject:[[InputStickKeyboardLayoutFrCHMac alloc] init]];          //French, Switzerland, macOS
    [result addObject:[[InputStickKeyboardLayoutDeDE alloc] init]];             //German
    [result addObject:[[InputStickKeyboardLayoutDeDELinux alloc] init]];        //German, Linux
    [result addObject:[[InputStickKeyboardLayoutDeDEMac alloc] init]];          //German, macOS
    [result addObject:[[InputStickKeyboardLayoutDeCH alloc] init]];             //German, Switzerland
    [result addObject:[[InputStickKeyboardLayoutDeCHLinux alloc] init]];        //German, Switzerland, Linux
    [result addObject:[[InputStickKeyboardLayoutDeCHMac alloc] init]];          //German, Switzerland, macOS
    [result addObject:[[InputStickKeyboardLayoutElGR alloc] init]];             //Greek
    [result addObject:[[InputStickKeyboardLayoutElGRLinux alloc] init]];        //Greek, Linux
    [result addObject:[[InputStickKeyboardLayoutElGRMac alloc] init]];          //Greek, macOS
    [result addObject:[[InputStickKeyboardLayoutHeIL alloc] init]];             //Hebrew
    [result addObject:[[InputStickKeyboardLayoutHeILLinux alloc] init]];        //Hebrew, Linux
    [result addObject:[[InputStickKeyboardLayoutHeILMac alloc] init]];          //Hebrew, macOS
    [result addObject:[[InputStickKeyboardLayoutHuHU alloc] init]];             //Hungarian
    [result addObject:[[InputStickKeyboardLayoutHuHULinux alloc] init]];        //Hungarian, Linux
    [result addObject:[[InputStickKeyboardLayoutHuHUMac alloc] init]];          //Hungarian, macOS
    [result addObject:[[InputStickKeyboardLayoutItIT alloc] init]];             //Italian
    [result addObject:[[InputStickKeyboardLayoutItITLinux alloc] init]];        //Italian, Linux
    [result addObject:[[InputStickKeyboardLayoutItITMac alloc] init]];          //Italian, macOS
    [result addObject:[[InputStickKeyboardLayoutNbNO alloc] init]];             //Norwegian
    [result addObject:[[InputStickKeyboardLayoutNbNOLinux alloc] init]];        //Norwegian, Linux
    [result addObject:[[InputStickKeyboardLayoutNbNOMac alloc] init]];          //Norwegian, macOS
    [result addObject:[[InputStickKeyboardLayoutPlPL alloc] init]];             //Polish
    [result addObject:[[InputStickKeyboardLayoutPlPLLinux alloc] init]];        //Polish, Linux
    [result addObject:[[InputStickKeyboardLayoutPlPLMac alloc] init]];          //Polish, macOS
    [result addObject:[[InputStickKeyboardLayoutPtPT alloc] init]];             //Portuguese
    [result addObject:[[InputStickKeyboardLayoutPtPTLinux alloc] init]];        //Portuguese, Linux
    [result addObject:[[InputStickKeyboardLayoutPtPTMac alloc] init]];          //Portuguese, macOS
    [result addObject:[[InputStickKeyboardLayoutPtBR alloc] init]];             //Portuguese, Brazil
    [result addObject:[[InputStickKeyboardLayoutPtBRLinux alloc] init]];        //Portuguese, Brazil, Linux
    [result addObject:[[InputStickKeyboardLayoutPtBRMac alloc] init]];          //Portuguese, Brazil, macOS
    [result addObject:[[InputStickKeyboardLayoutRuRU alloc] init]];             //Russian
    [result addObject:[[InputStickKeyboardLayoutRuRULinux alloc] init]];        //Russian, Linux
    [result addObject:[[InputStickKeyboardLayoutRuRUMac alloc] init]];          //Russian, macOS
    [result addObject:[[InputStickKeyboardLayoutSkSK alloc] init]];             //Slovak
    [result addObject:[[InputStickKeyboardLayoutSkSKMac alloc] init]];          //Slovak, macOS
    [result addObject:[[InputStickKeyboardLayoutSkSKLinux alloc] init]];        //Slovak, Linux
    [result addObject:[[InputStickKeyboardLayoutEsES alloc] init]];             //Spanish
    [result addObject:[[InputStickKeyboardLayoutEsESLinux alloc] init]];        //Spanish, Linux
    [result addObject:[[InputStickKeyboardLayoutEsESMac alloc] init]];          //Spanish, macOS
    [result addObject:[[InputStickKeyboardLayoutSvSE alloc] init]];             //Swedish
    [result addObject:[[InputStickKeyboardLayoutSvSELinux alloc] init]];        //Swedish, Linux
    [result addObject:[[InputStickKeyboardLayoutSvSEMac alloc] init]];          //Swedish, macOS
    return result;
}

+ (NSArray<id <InputStickKeyboardLayoutProtocol>> *)keyboardLayoutsWithCodePrefix:(NSString *)codePrefix {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *layouts = [InputStickKeyboardLayoutUtils keyboardLayouts];
    for (id <InputStickKeyboardLayoutProtocol> layout in layouts) {
        if ([[layout layoutCode] hasPrefix:codePrefix]) {
            [result addObject:layout];
        }
    }
    return result;
}

+ (id <InputStickKeyboardLayoutProtocol>)keyboardLayoutWithCode:(NSString *)code {
    NSString *cmp = [code lowercaseString];
    NSArray *layouts = [InputStickKeyboardLayoutUtils keyboardLayouts];
    for (id <InputStickKeyboardLayoutProtocol> layout in layouts) {
        if ([cmp isEqualToString:[layout layoutCodeLowercase]]) {
            return layout;
        }
    }
    
    //backwards compatibility:
    if ([cmp isEqualToString:@"en-dv"]) {
        return [[InputStickKeyboardLayoutEnUSDvorak alloc] init];
    }
    //failsafe:
    return [[InputStickKeyboardLayoutEnUS alloc] init];
}


#pragma mark - Keyboard layout names

+ (NSArray<NSString *> *)keyboardLayoutDisplayNames {
    NSMutableArray<NSString *> *result = [[NSMutableArray alloc] init];
    NSArray *layouts = [InputStickKeyboardLayoutUtils keyboardLayouts];
    for (id <InputStickKeyboardLayoutProtocol> layout in layouts) {
        [result addObject:[layout layoutFullName]];
    }
    return result;
}

+ (NSArray<NSString *> *)keyboardLayoutDisplayNamesWithCodePrefix:(NSString *)codePrefix {
    NSMutableArray<NSString *> *result = [[NSMutableArray alloc] init];
    NSArray *layouts = [InputStickKeyboardLayoutUtils keyboardLayouts];
    for (id <InputStickKeyboardLayoutProtocol> layout in layouts) {
        if ([[layout layoutCode] hasPrefix:codePrefix]) {
            [result addObject:[layout layoutFullName]];
        }
    }
    return result;
}


#pragma mark - Keyboard layout codes

+ (NSArray<NSString *> *)keyboardLayoutCodes {
    NSMutableArray<NSString *> *result = [[NSMutableArray alloc] init];
    NSArray *layouts = [InputStickKeyboardLayoutUtils keyboardLayouts];
    for (id <InputStickKeyboardLayoutProtocol> layout in layouts) {
        [result addObject:[layout layoutCode]];
    }
    return result;
}

+ (NSArray<NSString *> *)keyboardLayoutCodesWithCodePrefix:(NSString *)codePrefix {
    NSMutableArray<NSString *> *result = [[NSMutableArray alloc] init];
    NSArray *layouts = [InputStickKeyboardLayoutUtils keyboardLayouts];
    for (id <InputStickKeyboardLayoutProtocol> layout in layouts) {
        if ([[layout layoutCode] hasPrefix:codePrefix]) {
            [result addObject:[layout layoutCode]];
        }
    }
    return result;
}


#pragma mark - Keyboard layout languages

+ (NSArray<NSString *> *)keyboardLayoutLanguageCodes {
    NSArray<NSString *> *result = @[
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
    return result;
}

+ (NSArray<NSString *> *)keyboardLayoutLanguageNames {
    NSArray<NSString *> *result = @[
                       @"Croatian (Hrvatski)",
                       @"Czech (Čeština)",
                       @"Dannish (Dansk)",
                       @"Dutch (Nederlands)",
                       @"English",
                       @"Finnish (Suomi)",
                       @"French (Français)",
                       @"German (Deutsch)",
                       @"Greek (Ελληνικά)",
                       @"Hebrew (עִבְרִית)",
                       @"Hungarian (Magyar)",
                       @"Italian (Italiano)",
                       @"Norwegian (Norsk)",
                       @"Polish (Polish)",
                       @"Portuguese (Português)",
                       @"Russian (Русский)",
                       @"Slovak (Slovenëina)",
                       @"Spanish (Español)",
                       @"Swedish (Svenska)",
    ];
    return result;
}


#pragma mark - Keyboard layout groups

+ (NSArray<NSString *> *)groupCodesWithLanguageCode:(NSString *)languageCode {
    languageCode = [languageCode lowercaseString];
    if ([languageCode isEqualToString:@"hr"]) {
        return @[@"hr-HR"];
    }
    if ([languageCode isEqualToString:@"cs"]) {
        return @[@"cs-CZ"];
    }
    if ([languageCode isEqualToString:@"da"]) {
        return @[@"da-DK"];
    }
    if ([languageCode isEqualToString:@"nl"]) {
        return @[@"nl-NL"];
    }
    if ([languageCode isEqualToString:@"en"]) {
        return @[@"en-US", @"en-GB"];
    }
    if ([languageCode isEqualToString:@"fi"]) {
        return @[@"fi-FI"];
    }
    if ([languageCode isEqualToString:@"fr"]) {
        return @[@"fr-FR", @"fr-BE", @"fr-CA", @"fr-CH"];
    }
    if ([languageCode isEqualToString:@"de"]) {
        return @[@"de-DE", @"de-CH"];
    }
    if ([languageCode isEqualToString:@"el"]) {
        return @[@"el-GR"];
    }
    if ([languageCode isEqualToString:@"he"]) {
        return @[@"he-IL"];
    }
    if ([languageCode isEqualToString:@"hu"]) {
        return @[@"hu-HU"];
    }
    if ([languageCode isEqualToString:@"it"]) {
        return @[@"it-IT"];
    }
    if ([languageCode isEqualToString:@"nb"]) {
        return @[@"nb-NO"];
    }
    if ([languageCode isEqualToString:@"pl"]) {
        return @[@"pl-PL"];
    }
    if ([languageCode isEqualToString:@"pt"]) {
        return @[@"pt-PT", @"pt-BR"];
    }
    if ([languageCode isEqualToString:@"ru"]) {
        return @[@"ru-RU"];
    }
    if ([languageCode isEqualToString:@"sk"]) {
        return @[@"sk-SK"];
    }
    if ([languageCode isEqualToString:@"es"]) {
        return @[@"es-ES"];
    }
    if ([languageCode isEqualToString:@"sv"]) {
        return @[@"sv-SE"];
    }
    return nil;
}

+ (NSString *)groupNameWithGroupCode:(NSString *)groupCode {
    groupCode = [groupCode lowercaseString];
    if ([groupCode isEqualToString:@"hr-hr"]) {
        return @"Croatian";
    }
    if ([groupCode isEqualToString:@"cs-cz"]) {
        return @"Czech";
    }
    if ([groupCode isEqualToString:@"da-dk"]) {
        return @"Dannish";
    }
    if ([groupCode isEqualToString:@"nl-nl"]) {
        return @"Dutch";
    }
    if ([groupCode isEqualToString:@"en-gb"]) {
        return @"English (United Kingdom)";
    }
    if ([groupCode isEqualToString:@"en-us"]) {
        return @"English (United States)";
    }
    if ([groupCode isEqualToString:@"fi-fi"]) {
        return @"Finnish";
    }
    if ([groupCode isEqualToString:@"fr-be"]) {
        return @"French (Belgium)";
    }
    if ([groupCode isEqualToString:@"fr-ca"]) {
        return @"French (Canada)";
    }
    if ([groupCode isEqualToString:@"fr-ch"]) {
        return @"French (Switzerland)";
    }
    if ([groupCode isEqualToString:@"fr-fr"]) {
        return @"French (France)";
    }
    if ([groupCode isEqualToString:@"de-ch"]) {
        return @"German (Switzerland)";
    }
    if ([groupCode isEqualToString:@"de-de"]) {
        return @"German (Germany)";
    }
    if ([groupCode isEqualToString:@"el-gr"]) {
        return @"Greek";
    }
    if ([groupCode isEqualToString:@"he-il"]) {
        return @"Hebrew";
    }
    if ([groupCode isEqualToString:@"hu-hu"]) {
        return @"Hungarian";
    }
    if ([groupCode isEqualToString:@"it-it"]) {
        return @"Italian";
    }
    if ([groupCode isEqualToString:@"nb-no"]) {
        return @"Norwegian";
    }
    if ([groupCode isEqualToString:@"pl-pl"]) {
        return @"Polish";
    }
    if ([groupCode isEqualToString:@"pt-br"]) {
        return @"Portuguese (Brazil)";
    }
    if ([groupCode isEqualToString:@"pt-pt"]) {
        return @"Portuguese (Portugal)";
    }
    if ([groupCode isEqualToString:@"ru-ru"]) {
        return @"Russian";
    }
    if ([groupCode isEqualToString:@"sk-sk"]) {
        return @"Slovak";
    }
    if ([groupCode isEqualToString:@"es-es"]) {
        return @"Spanish";
    }
    if ([groupCode isEqualToString:@"se-sv"]) {
        return @"Swedish";
    }
    return @"";
}

+ (NSString *)groupInfoWithGroupCode:(NSString *)groupCode {    
    groupCode = [groupCode lowercaseString];
    return @"";
}


@end
