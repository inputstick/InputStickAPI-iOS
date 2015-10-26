/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISDemoKeyboardViewController.h"
#import "ISKeyboardHandler.h"


@implementation ISDemoKeyboardViewController

- (instancetype)initWithKeyboardHandler:(ISKeyboardHandler *)keyboardHandler {
    self = [super init];
    if (self) {
        self.keyboardHandler = keyboardHandler;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Keyboard HID";
}


@end
