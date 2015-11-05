/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISDemoKeyboardViewController.h"
#import "ISKeyboardHandler.h"
#import "ISKeyboardLayoutEnUS.h"
#import "ISKeyCodesTable.h"
#import "UIColor+ISDemo.h"


@implementation ISDemoKeyboardViewController

#pragma mark - Object lifecycle

- (instancetype)initWithKeyboardHandler:(ISKeyboardHandler *)keyboardHandler {
    self = [super init];
    if (self) {
        _keyboardHandler = keyboardHandler;

        self.selectedKeyboardLayout = [[ISKeyboardLayoutEnUS alloc] init];

        self.currentKeyboardLayoutLabel = [[UILabel alloc] init];
        self.currentKeyboardLayoutLabel.textColor = [UIColor blackColor];
        self.currentKeyboardLayoutLabel.font = [UIFont systemFontOfSize:18];
        self.currentKeyboardLayoutLabel.textAlignment = NSTextAlignmentLeft;

        self.selectKeyboardButton = [[UIButton alloc] init];
        [self.selectKeyboardButton setTitle:@"Select layout" forState:UIControlStateNormal];
        [self.selectKeyboardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.selectKeyboardButton setBackgroundColor:[UIColor demoButtonColor]];
        [self.selectKeyboardButton addTarget:self action:@selector(selectKeyboardAction:)
                            forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - UIView

- (void)loadView {
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Keyboard HID";

    [self updateLayoutLabel];
    [self.view addSubview:self.currentKeyboardLayoutLabel];
    [self.view addSubview:self.selectKeyboardButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self becomeFirstResponder];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    [self.currentKeyboardLayoutLabel sizeToFit];
    [self.currentKeyboardLayoutLabel setFrame:CGRectMake(10, 66 + 15, CGRectGetWidth(self.view.frame) - 20, CGRectGetHeight(self.currentKeyboardLayoutLabel.frame))];
    [self.selectKeyboardButton setFrame:CGRectMake(10, CGRectGetMaxY(self.currentKeyboardLayoutLabel.frame) + 15, CGRectGetWidth(self.view.frame) - 20, 44)];
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - Select Keyboard

- (void)selectKeyboardAction:(id)selectKeyboardAction {
    ISDemoSelectKeyboardViewController *selectKeyboardViewController = [[ISDemoSelectKeyboardViewController alloc] initWithCurrentKeyboardLayout:self.selectedKeyboardLayout];
    selectKeyboardViewController.delegate = self;
    [self.navigationController pushViewController:selectKeyboardViewController animated:YES];
}

- (void)selectKeyboardViewController:(ISDemoSelectKeyboardViewController *)viewController selectedKeyboardLayout:(id <ISKeyboardLayoutProtocol>)keyboardLayout {
    self.selectedKeyboardLayout = keyboardLayout;
    [self updateLayoutLabel];
}

#pragma mark - UIKeyInput

- (BOOL)hasText {
    return YES;
}

- (void)insertText:(NSString *)text {
    [self.keyboardHandler sendText:text withKeyboardLayout:self.selectedKeyboardLayout multiplier:1];
}

- (void)deleteBackward {
    [self.keyboardHandler pressKeyAndReleaseWithModifier:0x00 key:KEY_BACKSPACE
                                              multiplier:1 sendASAP:YES];
}

#pragma mark - Helpers

- (void)updateLayoutLabel {
    NSString *layoutString = [NSString stringWithFormat:@"Keyboard layout: %@", self.selectedKeyboardLayout.layoutDescription];
    self.currentKeyboardLayoutLabel.text = layoutString;
}

@end
