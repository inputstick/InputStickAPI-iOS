//
// Created by Marcin Wieclawski on 25/10/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "ISDemoSelectKeyboardViewController.h"

@class ISKeyboardHandler;
@protocol ISKeyboardLayoutProtocol;

@interface ISDemoKeyboardViewController : UIViewController <UIKeyInput, ISDemoSelectKeyboardProtocol>
@property(nonatomic, readonly) ISKeyboardHandler *keyboardHandler;
@property(nonatomic, strong) UILabel *currentKeyboardLayoutLabel;
@property(nonatomic, strong) UIButton *selectKeyboardButton;
@property(nonatomic, strong) id <ISKeyboardLayoutProtocol> selectedKeyboardLayout;

- (instancetype)initWithKeyboardHandler:(ISKeyboardHandler *)keyboardHandler;

@end
