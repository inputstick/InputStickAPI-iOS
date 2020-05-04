/*
* InputStickAPI-iOS
* Copyright (c) 2020 Jakub Zawadzki, www.inputstick.com
*/

#import "InputStickKeyLabels.h"
#import "InputStickKeyboardHandler.h"


static NSUInteger const MaxHIDKeyCode = 232;


@interface InputStickKeyLabels () {
    NSMutableArray *_lut;
}

@end


@implementation InputStickKeyLabels


#pragma mark - Object lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _lut = [[NSMutableArray alloc] initWithCapacity:MaxHIDKeyCode];
        for (NSUInteger i = 0; i < MaxHIDKeyCode; i++) {
            [_lut addObject:[NSNull null]];
        }
        
        [self setupKey:0x28 withLabel:@"↵"];
        [self setupKey:0x29 withLabel:@"Esc"];
        [self setupKey:0x2A withLabel:@"⌫"];
        [self setupKey:0x2B withLabel:@"Tab"];
        [self setupKey:0x2C withLabel:@"␣"];
        [self setupKey:0x39 withLabel:@"CapsLk"];
        [self setupKey:0x3A withLabel:@"F1"];
        [self setupKey:0x3B withLabel:@"F2"];
        [self setupKey:0x3C withLabel:@"F3"];
        [self setupKey:0x3D withLabel:@"F4"];
        [self setupKey:0x3E withLabel:@"F5"];
        [self setupKey:0x3F withLabel:@"F6"];
        [self setupKey:0x40 withLabel:@"F7"];
        [self setupKey:0x41 withLabel:@"F8"];
        [self setupKey:0x42 withLabel:@"F9"];
        [self setupKey:0x43 withLabel:@"F10"];
        [self setupKey:0x44 withLabel:@"F11"];
        [self setupKey:0x45 withLabel:@"F12"];
        [self setupKey:0x46 withLabel:@"PrtSc"];
        [self setupKey:0x47 withLabel:@"ScrLk"];
        [self setupKey:0x48 withLabel:@"Pause"];
        [self setupKey:0x49 withLabel:@"Ins"];
        [self setupKey:0x4A withLabel:@"Home"];
        [self setupKey:0x4B withLabel:@"PgUp"];
        [self setupKey:0x4C withLabel:@"Del"];
        [self setupKey:0x4D withLabel:@"End"];
        [self setupKey:0x4E withLabel:@"PgDn"];
        [self setupKey:0x4F withLabel:@"→"];
        [self setupKey:0x50 withLabel:@"←"];
        [self setupKey:0x51 withLabel:@"↓"];
        [self setupKey:0x52 withLabel:@"↑"];
        [self setupKey:0x53 withLabel:@"NumLk"];
        [self setupKey:0x54 withLabel:@"/"];
        [self setupKey:0x55 withLabel:@"*"];
        [self setupKey:0x56 withLabel:@"-"];
        [self setupKey:0x57 withLabel:@"+"];
        [self setupKey:0x58 withLabel:@"Enter"];
        [self setupKey:0x59 withNumLockOffLabel:@"End" numLockOnLabel:@"1"];
        [self setupKey:0x5A withNumLockOffLabel:@"↓" numLockOnLabel:@"2"];
        [self setupKey:0x5B withNumLockOffLabel:@"Pg Dn" numLockOnLabel:@"3"];
        [self setupKey:0x5C withNumLockOffLabel:@"←" numLockOnLabel:@"4"];
        [self setupKey:0x5D withNumLockOffLabel:@"" numLockOnLabel:@"5"];
        [self setupKey:0x5E withNumLockOffLabel:@"→" numLockOnLabel:@"6"];
        [self setupKey:0x5F withNumLockOffLabel:@"Home" numLockOnLabel:@"7"];
        [self setupKey:0x60 withNumLockOffLabel:@"↑" numLockOnLabel:@"8"];
        [self setupKey:0x61 withNumLockOffLabel:@"Pg Up" numLockOnLabel:@"9"];
        [self setupKey:0x62 withNumLockOffLabel:@"Ins" numLockOnLabel:@"0"];
        [self setupKey:0x63 withNumLockOffLabel:@"Del" numLockOnLabel:@"."];
    }
    return self;
}


#pragma mark - Key setup

- (void)setupKey:(Byte)key withCharCodesArray:(NSArray *)charCodeArray {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    [tmp addObject:[NSNumber numberWithInt:KEY_LABEL_LAYOUT_DEPENDENT]];
    //[no modifiers][Shift][AltGr][Shift+AltGt][CapsLock, no modifiers][CapsLock, Shift][CapsLock, AltGr][CapsLock, Shift+AltGt]
    for (NSUInteger i = 1; i < 9; i++) {
        unichar c = (unichar)[[charCodeArray objectAtIndex:i] integerValue];
        if (c == 0) {
            [tmp addObject:@""];
        } else {
            [tmp addObject:[NSString stringWithFormat:@"%C", c]];
        }
    }
    [_lut replaceObjectAtIndex:key withObject:tmp];
}

- (void)setupKey:(Byte)key withLabel:(NSString *)label {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    [tmp addObject:[NSNumber numberWithInt:KEY_LABEL_LAYOUT_INDEPENDENT]];
    [tmp addObject:label];
    [_lut replaceObjectAtIndex:key withObject:tmp];
}

- (void)setupKey:(Byte)key withNumLockOffLabel:(NSString *)numLockOffLabel numLockOnLabel:(NSString *)numLockOnLabel {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    [tmp addObject:[NSNumber numberWithInt:KEY_LABEL_NUMPAD]];
    [tmp addObject:numLockOffLabel];
    [tmp addObject:numLockOnLabel];
    [_lut replaceObjectAtIndex:key withObject:tmp];
}


#pragma mark - Key labels

- (NSString *)labelForKey:(Byte)keyCode {
    return [self labelForKey:keyCode withModifiers:0x00 capsLock:FALSE numLock:FALSE defaultIfNotFound:TRUE];
}

- (NSString *)labelForKey:(Byte)keyCode withModifiers:(Byte)modifiers {
    return [self labelForKey:keyCode withModifiers:modifiers capsLock:FALSE numLock:FALSE defaultIfNotFound:TRUE];
}

- (NSString *)labelForKey:(Byte)keyCode withModifiers:(Byte)modifiers capsLock:(BOOL)capsLock numLock:(BOOL)numLock defaultIfNotFound:(BOOL)defaultIfNotFound {
    if (keyCode >= MaxHIDKeyCode) {
        return nil;
    }
    NSArray *tmp = [_lut objectAtIndex:keyCode];
    if ([tmp isEqual:[NSNull null]]) {
        return nil;
    }
        
    InputStickKeyLabelType keyLabelType = [((NSNumber *)[tmp objectAtIndex:0]) intValue];
    if (keyLabelType == KEY_LABEL_LAYOUT_DEPENDENT) {
        NSUInteger index = 0;
        //for all other states of modifier keys, key label is NOT defined
        switch (modifiers) {
            case 0x00:
                index = 1;
                break;
            case SHIFT_LEFT:
            case SHIFT_RIGHT:
                //case (SHIFT_LEFT | SHIFT_RIGHT): windows only
                index = 2;
                break;
            case ALT_RIGHT:
                index = 3;
                break;
            case (ALT_RIGHT | SHIFT_LEFT):
            case (ALT_RIGHT | SHIFT_RIGHT):
                //case (ALT_RIGHT | SHIFT_LEFT | SHIFT_RIGHT): windows only!
                index = 4;
                break;
        }
        if (capsLock && (index > 0)) {
            index += 4;
        }
        
        NSString *label;
        if (index == 0) {
            label = @"";
        } else {
            label = [tmp objectAtIndex:index]; //may be empty string if label is not defined for provided parameters
        }
        if (([label length] == 0) && defaultIfNotFound) {
            //if label is not defined for current set of parameters, return default label to avoid blank keys
            label = [tmp objectAtIndex:1];
        }
        return label;
    } else if (keyLabelType == KEY_LABEL_NUMPAD) {
        if (numLock) {
            return [tmp objectAtIndex:2];
        } else {
            return [tmp objectAtIndex:1];
        }
    } else if (keyLabelType == KEY_LABEL_LAYOUT_INDEPENDENT) {
        return [tmp objectAtIndex:1];
    }
    
    return nil;
}

@end
