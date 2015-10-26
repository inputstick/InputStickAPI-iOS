/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISDemoConsumerViewController.h"
#import "ISConsumerHandler.h"


@implementation ISDemoConsumerViewController

- (instancetype)initWithConsumerHandler:(ISConsumerHandler *)consumerHandler {
    self = [super init];
    if (self) {
        self.consumerHandler = consumerHandler;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Consumer HID";
}

@end
