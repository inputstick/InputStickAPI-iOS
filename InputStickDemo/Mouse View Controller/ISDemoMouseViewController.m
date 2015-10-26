/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISDemoMouseViewController.h"
#import "ISMouseHandler.h"


@implementation ISDemoMouseViewController

- (instancetype)initWithMouseHandler:(ISMouseHandler *)mouseHandler {
    self = [super init];
    if (self) {
        self.mouseHandler = mouseHandler;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Mouse HID";
}

@end
