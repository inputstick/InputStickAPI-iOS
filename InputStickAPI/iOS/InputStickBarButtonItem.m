/*
 * InputStickAPI-iOS
 * Copyright (c) 2019 Jakub Zawadzki, www.inputstick.com
 */

#import "InputStickBarButtonItem.h"
#import "InputStickUI.h"
#import "InputStickTheme.h"
#import "InputStickManager.h"
#import "InputStickManager+Protected.h"
#import "InputStickError.h"
#import "InputStickConst.h"


@interface InputStickBarButtonItem () {
    InputStickManager *_inputStickManager;
    NSString *_identifier;
}

@end


@implementation InputStickBarButtonItem

- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager withIdentifier:(NSString *)identifier allowClick:(BOOL)allowClick {
    UIImage *img = [[UIImage imageNamed:InputStickConnectionIcon] init];
    self = [super initWithImage:img style:UIBarButtonItemStylePlain target:nil action:nil];
    if (self) {
        _inputStickManager = inputStickManager;
        _identifier = [identifier copy];
        [[NSNotificationCenter defaultCenter] registerForInputStickConnectionNotificationsWithObserver:self];
        if (allowClick) {
            self.target = self;
            self.action = @selector(clickAction:);
        }
        [self updateColor];
    }
    return self;
}

- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager allowClick:(BOOL)allowClick {
    return [self initWithInputStickManager:inputStickManager withIdentifier:nil allowClick:YES];
}

- (instancetype)initWithInputStickManager:(InputStickManager *)inputStickManager {
    return [self initWithInputStickManager:inputStickManager allowClick:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] unregisterFromInputStickConnectionNotificationsWithObserver:self]; //pre iOS9
}

- ( IBAction )clickAction:(id)sender {
    if (_inputStickManager.connectionState == InputStickDisconnected) {
        if (_identifier == nil) {
            if ([_inputStickManager hasStoredDeviceIdentifier]) {
                [_inputStickManager connectToLastInputStick];
            } else {
                //no stored devices, can't connect to most recent one
                [_inputStickManager showErrorMessage:[InputStickError getNSErrorWithCode:INPUTSTICK_ERROR_APP_NO_DEVICES_STORED]];
                [self updateColor];
            }
        } else {
            [_inputStickManager connectToInputStickWithIdentifier:_identifier];
        }
    } else {
        [_inputStickManager disconnectFromInputStick];
    }
}


#pragma mark - InputStickConnectionNotifications Observer

- (void)didUpdateInputStickConnectionState:(NSNotification *)notification {
    [self updateColor];
}


#pragma mark - Helpers

- (void)updateColor {
    UIColor *c =[InputStickUI colorForInputStickConnectionState:_inputStickManager.connectionState];
    c = [InputStickTheme themeNotificationColor:c];
    //special case: use red color if an error occurred withing last 30 seconds
    if ([[NSDate date] timeIntervalSince1970] < _inputStickManager.lastErrorTime + 30) {
        c = [UIColor redColor];
    }
    [self setTintColor:c];
}

@end
