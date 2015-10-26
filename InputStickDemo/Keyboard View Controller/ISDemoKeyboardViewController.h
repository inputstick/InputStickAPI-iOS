//
// Created by Marcin Wieclawski on 25/10/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class ISKeyboardHandler;

@interface ISDemoKeyboardViewController : UIViewController
@property(nonatomic, strong) ISKeyboardHandler *keyboardHandler;

- (instancetype)initWithKeyboardHandler:(ISKeyboardHandler *)keyboardHandler;

@end
