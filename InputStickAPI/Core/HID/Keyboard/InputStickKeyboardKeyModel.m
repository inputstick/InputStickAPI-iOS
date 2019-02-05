/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickKeyboardKeyModel.h"
#import "InputStickKeyboardLayoutProtocol.h"
#import "InputStickHIDReport.h"

@implementation InputStickKeyboardKeyModel

- (instancetype)initWithUnicodeCharacter:(unichar)unicodeCharacter key:(Byte)key modifiers:(Byte)modifiers deadkey:(Byte)deadkey deadkeyModifiers:(Byte)deadkeyModifiers {
    self = [super init];
    if (self) {
        _unicodeCode = unicodeCharacter;
        _key = key;
        _modifiers = modifiers;
        _deadkey = deadkey;
        _deadkeyModifiers = deadkeyModifiers;
    }
    return self;
}

+ (InputStickKeyboardKeyModel *)modelForCharacter:(unichar)character withKeyboardLayout:(id <InputStickKeyboardLayoutProtocol>)keyboardLayout {
    InputStickKeyboardKeyModel *keyboardKeyModel;
    keyboardKeyModel = [[keyboardLayout class] getKeyModelForCharacter:character];    
    return keyboardKeyModel;
}


#pragma mark - Keyboard reports

- (NSArray<InputStickHIDReport *> *)keyboardReports {
    NSMutableArray<InputStickHIDReport *> *keyboardReportsArray = [NSMutableArray array];
    if (self.deadkey > 0) {
        [keyboardReportsArray addObject:[InputStickHIDReport shortKeyboardReportWithBytes:(Byte[]) {self.deadkeyModifiers, 0x00}]];
        [keyboardReportsArray addObject:[InputStickHIDReport shortKeyboardReportWithBytes:(Byte[]) {self.deadkeyModifiers, self.deadkey}]];
        [keyboardReportsArray addObject:[InputStickHIDReport shortKeyboardReportWithBytes:(Byte[]) {0x00, 0x00}]];
    }
    [keyboardReportsArray addObject:[InputStickHIDReport shortKeyboardReportWithBytes:(Byte[]) {self.modifiers, 0x00}]];
    [keyboardReportsArray addObject:[InputStickHIDReport shortKeyboardReportWithBytes:(Byte[]) {self.modifiers, self.key}]];
    [keyboardReportsArray addObject:[InputStickHIDReport shortKeyboardReportWithBytes:(Byte[]) {0x00, 0x00}]];
    return [keyboardReportsArray copy];
}

- (NSUInteger)numberOfKeyboardReports {
    return self.deadkey > 0 ? 6 : 3;
}
@end
