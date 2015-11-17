/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISDemoGamepadViewController.h"
#import "ISGamepadHandler.h"


@implementation ISDemoGamepadViewController

#pragma mark - Object lifecycle

- (instancetype)initWithGamepadHandler:(ISGamepadHandler *)gamepadHandler {
    self = [super init];
    if (self) {
        self.gamepadHandler = gamepadHandler;
    }
    return self;
}

#pragma mark - UIView

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];

    self.xButton = [self newButtonWithTitle:@"X"];
    [self.xButton addTarget:self action:@selector(xButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    self.yButton = [self newButtonWithTitle:@"Y"];
    [self.yButton addTarget:self action:@selector(yButtonAction:)
           forControlEvents:UIControlEventTouchUpInside];

    self.aButton = [self newButtonWithTitle:@"A"];
    [self.aButton addTarget:self action:@selector(aButtonAction:)
           forControlEvents:UIControlEventTouchUpInside];

    self.bButton = [self newButtonWithTitle:@"B"];
    [self.bButton addTarget:self action:@selector(bButtonAction:)
           forControlEvents:UIControlEventTouchUpInside];

    self.topButton = [self newButtonWithTitle:@"TOP"];
    [self.topButton addTarget:self action:@selector(topButtonAction:)
             forControlEvents:UIControlEventTouchUpInside];

    self.leftButton = [self newButtonWithTitle:@"LEFT"];
    [self.leftButton addTarget:self action:@selector(leftButtonAction:)
              forControlEvents:UIControlEventTouchUpInside];

    self.downButton = [self newButtonWithTitle:@"DOWN"];
    [self.downButton addTarget:self action:@selector(downButtonAction:)
              forControlEvents:UIControlEventTouchUpInside];

    self.rightButton = [self newButtonWithTitle:@"RIGHT"];
    [self.rightButton addTarget:self action:@selector(rightButtonAction:)
               forControlEvents:UIControlEventTouchUpInside];
}

- (UIButton *)newButtonWithTitle:(NSString *)title {
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundColor:[UIColor blueColor]];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setTitle:title forState:UIControlStateNormal];
    [self.view addSubview:button];
    return button;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    [self setupGamepadButtons:@[self.topButton, self.leftButton, self.downButton, self.rightButton]
                     withSize:CGSizeMake(45, 55)
                      atPoint:CGPointMake(CGRectGetMidX(self.view.frame), 170)
       withDistanceFromCenter:70];

    [self setupGamepadButtons:@[self.yButton, self.xButton, self.aButton, self.bButton]
                     withSize:CGSizeMake(45, 55)
                      atPoint:CGPointMake(CGRectGetMidX(self.view.frame), 375)
       withDistanceFromCenter:70];
}

#pragma mark - Button Actions

- (void)xButtonAction:(UIButton *)button {
    [self sendButtonPress:GAMEPAD_BUTTON_01];
}

- (void)yButtonAction:(UIButton *)button {
    [self sendButtonPress:GAMEPAD_BUTTON_02];
}

- (void)aButtonAction:(UIButton *)button {
    [self sendButtonPress:GAMEPAD_BUTTON_04];
}

- (void)bButtonAction:(UIButton *)button {
    [self sendButtonPress:GAMEPAD_BUTTON_03];
}

- (void)topButtonAction:(UIButton *)button {
    [self sendYAxisValue:-80];
}

- (void)leftButtonAction:(UIButton *)button {
    [self sendXAxisValue:-80];
}

- (void)downButtonAction:(UIButton *)button {
    [self sendYAxisValue:80];
}

- (void)rightButtonAction:(UIButton *)button {
    [self sendXAxisValue:80];
}

#pragma mark - Helpers

- (void)setupGamepadButtons:(NSArray *)buttonsArray withSize:(CGSize)buttonSize atPoint:(CGPoint)contentCenter withDistanceFromCenter:(CGFloat)distanceFromCenter {
    UIButton *firstButton = buttonsArray[0];
    UIButton *secondButton = buttonsArray[1];
    UIButton *thirdButton = buttonsArray[2];
    UIButton *forthButton = buttonsArray[3];

    [firstButton setFrame:CGRectMake(0, 0, buttonSize.width, buttonSize.height)];
    [secondButton setFrame:CGRectMake(0, 0, buttonSize.height, buttonSize.width)];
    [thirdButton setFrame:CGRectMake(0, 0, buttonSize.width, buttonSize.height)];
    [forthButton setFrame:CGRectMake(0, 0, buttonSize.height, buttonSize.width)];

    [firstButton setCenter:CGPointMake(contentCenter.x, contentCenter.y - distanceFromCenter)];
    [secondButton setCenter:CGPointMake(contentCenter.x - distanceFromCenter, contentCenter.y)];
    [thirdButton setCenter:CGPointMake(contentCenter.x, contentCenter.y + distanceFromCenter)];
    [forthButton setCenter:CGPointMake(contentCenter.x + distanceFromCenter, contentCenter.y)];
}

- (void)sendButtonPress:(GamepadButtons)button {
    [self.gamepadHandler sendCustomReportWithButtons:button axisX:0x00
                                               axisY:0x00 axisZ:0x00 axisRX:0x00];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        [self.gamepadHandler sendCustomReportWithButtons:GAMEPAD_BUTTON_NONE axisX:0x00
                                                   axisY:0x00 axisZ:0x00 axisRX:0x00];
    });
}

- (void)sendXAxisValue:(SignedByte)xAxis {
    [self.gamepadHandler sendCustomReportWithButtons:GAMEPAD_BUTTON_NONE axisX:xAxis
                                               axisY:0x00 axisZ:0x00 axisRX:0x00];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        [self.gamepadHandler sendCustomReportWithButtons:GAMEPAD_BUTTON_NONE axisX:0x00
                                                   axisY:0x00 axisZ:0x00 axisRX:0x00];
    });
}

- (void)sendYAxisValue:(SignedByte)yAxis {
    [self.gamepadHandler sendCustomReportWithButtons:GAMEPAD_BUTTON_NONE axisX:0x00
                                               axisY:yAxis axisZ:0x00 axisRX:0x00];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        [self.gamepadHandler sendCustomReportWithButtons:GAMEPAD_BUTTON_NONE axisX:0x00
                                                   axisY:0x00 axisZ:0x00 axisRX:0x00];
    });
}

@end
