/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISDemoMouseViewController.h"
#import "ISMouseHandler.h"
#import "UIColor+ISDemo.h"
#import "tgmath.h"

#define mouseMoveScale 0.25f

@implementation ISDemoMouseViewController

#pragma mark - Object lifecycle

- (instancetype)initWithMouseHandler:(ISMouseHandler *)mouseHandler {
    self = [super init];
    if (self) {
        self.mouseHandler = mouseHandler;

        self.mouseInputView = [[ISDemoMouseInputView alloc] init];
        self.mouseInputView.backgroundColor = [UIColor demoInputColor];
        self.mouseInputView.delegate = self;

        self.leftMouseButton = [self getMouseButtonWithTitle:@"Left"];
        [self.leftMouseButton addTarget:self action:@selector(leftButtonAction:)
                       forControlEvents:UIControlEventTouchUpInside];
        self.centerMouseButton = [self getMouseButtonWithTitle:@"Center"];
        [self.centerMouseButton addTarget:self action:@selector(centerButtonAction:)
                         forControlEvents:UIControlEventTouchUpInside];
        self.rightMouseButton = [self getMouseButtonWithTitle:@"Right"];
        [self.rightMouseButton addTarget:self action:@selector(rightButtonAction:)
                        forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
#pragma mark - UIView

- (void)loadView {
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Mouse HID";

    [self.view addSubview:self.mouseInputView];
    [self.view addSubview:self.leftMouseButton];
    [self.view addSubview:self.centerMouseButton];
    [self.view addSubview:self.rightMouseButton];
}

- (void)viewDidLayoutSubviews {
    CGFloat contentMargin = 40;
    CGFloat inputContentWidth = CGRectGetWidth(self.view.frame) - 2 * contentMargin;
    CGFloat viewHeight = CGRectGetHeight(self.view.frame);

    [self.mouseInputView setFrame:CGRectMake(contentMargin, contentMargin + 64, inputContentWidth, inputContentWidth)];

    CGFloat mouseButtonWidth = ceil(inputContentWidth / 3);
    CGFloat mouseButtonHeight = mouseButtonWidth * 1.2f;
    NSArray *mouseButtons = @[self.leftMouseButton, self.centerMouseButton, self.rightMouseButton];
    for (NSUInteger i = 0; i < mouseButtons.count; ++i) {
        UIButton *button = mouseButtons[i];

        CGRect buttonFrame = CGRectMake(
                contentMargin + i * mouseButtonWidth,
                viewHeight - mouseButtonHeight - contentMargin,
                mouseButtonWidth,
                mouseButtonHeight
        );
        [button setFrame:buttonFrame];
    }
}

#pragma mark - Mouse Buttons Action

- (void)leftButtonAction:(UIButton *)leftButtonAction {
    [self.mouseHandler sendPressedButtons:MOUSE_BUTTON_LEFT withNumberOfPress:1
                           withMultiplier:1];
}

- (void)centerButtonAction:(UIButton *)centerButtonAction {
    [self.mouseHandler sendPressedButtons:MOUSE_BUTTON_MIDDLE withNumberOfPress:1
                           withMultiplier:1];
}

- (void)rightButtonAction:(UIButton *)rightButtonAction {
    [self.mouseHandler sendPressedButtons:MOUSE_BUTTON_RIGHT withNumberOfPress:1
                           withMultiplier:1];
}

#pragma mark - ISDemoMouseInputViewDelegate

- (void)mouseInputView:(ISDemoMouseInputView *)inputView didReceiveMoveAtPoint:(CGPoint)movePoint {
    CGPoint locationFromCenter = CGPointMake(movePoint.x - CGRectGetWidth(inputView.frame) / 2, movePoint.y - CGRectGetHeight(inputView.frame) / 2);

    SignedByte xChange = (SignedByte) (locationFromCenter.x * mouseMoveScale);
    SignedByte yChange = (SignedByte) (locationFromCenter.y * mouseMoveScale);
    [self.mouseHandler sendMoveWithX:xChange positionY:yChange];
}

- (void)mouseInputView:(ISDemoMouseInputView *)inputView didReceiveScrollValue:(CGFloat)scrollValue {
    SignedByte scrollChange = (SignedByte) (scrollValue > 0 ? 1 : -1);
    [self.mouseHandler sendScroll:scrollChange];
}

#pragma mark - Helpers

- (UIButton *)getMouseButtonWithTitle:(NSString *)title {
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeSystem];
    newButton.layer.borderWidth = 2;
    newButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newButton setTitle:title forState:UIControlStateNormal];
    [newButton setBackgroundColor:[UIColor demoButtonColor]];
    return newButton;
}

@end
