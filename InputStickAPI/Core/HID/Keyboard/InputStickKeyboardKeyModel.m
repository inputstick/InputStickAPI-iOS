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

@end
