/*
 * Copyright (c) 2015 JZ. All rights reserved.
 */
#import "ISKeyboardKeyModel.h"
#import "ISKeyboardLayoutProtocol.h"
#import "ISReport.h"


@implementation ISKeyboardKeyModel

- (instancetype)initWithUnicodeCharacter:(unichar)unicodeCharacter {
    self = [super init];
    if (self) {
        _unicodeCode = unicodeCharacter;
    }

    return self;
}

+ (ISKeyboardKeyModel *)modelForCharacter:(unichar)character withKeyboardLayout:(id <ISKeyboardLayoutProtocol>)keyboardLayout {
    ISKeyboardKeyModel *keyboardKeyModel = [[ISKeyboardKeyModel alloc] initWithUnicodeCharacter:character];
    int foundKeyboardReportIndex = -1;
    for (int i = 0; i < keyboardLayout.numberOfCharacters; ++i) {
        int test = keyboardLayout.lookupTable[i][0];
        if (test == character) {
            foundKeyboardReportIndex = i;
            break;
        }
    }
    if (foundKeyboardReportIndex == -1) {
        return nil;
    }
    keyboardKeyModel.modifier = (Byte) keyboardLayout.lookupTable[foundKeyboardReportIndex][1];
    keyboardKeyModel.key = (Byte) keyboardLayout.lookupTable[foundKeyboardReportIndex][2];
    keyboardKeyModel.deadkeyModified = (Byte) keyboardLayout.lookupTable[foundKeyboardReportIndex][3];
    keyboardKeyModel.deadkey = (Byte) keyboardLayout.lookupTable[foundKeyboardReportIndex][4];
    return keyboardKeyModel;
}

#pragma mark - Keyboard reports

- (NSArray *)keyboardReports {
    NSMutableArray *keyboardReportsArray = [NSMutableArray array];
    if (self.deadkey > 0) {
        [keyboardReportsArray addObject:[ISReport shortKeyboardReportWithBytes:(Byte[]) {self.deadkeyModified, 0x00}]];
        [keyboardReportsArray addObject:[ISReport shortKeyboardReportWithBytes:(Byte[]) {self.deadkeyModified, self.deadkey}]];
        [keyboardReportsArray addObject:[ISReport shortKeyboardReportWithBytes:(Byte[]) {0x00, 0x00}]];
    }
    [keyboardReportsArray addObject:[ISReport shortKeyboardReportWithBytes:(Byte[]) {self.modifier, 0x00}]];
    [keyboardReportsArray addObject:[ISReport shortKeyboardReportWithBytes:(Byte[]) {self.modifier, self.key}]];
    [keyboardReportsArray addObject:[ISReport shortKeyboardReportWithBytes:(Byte[]) {0x00, 0x00}]];
    return [keyboardReportsArray copy];
}

- (NSInteger)numberOfKeyboardReports {
    return self.deadkey > 0 ? 6 : 3;
}
@end
