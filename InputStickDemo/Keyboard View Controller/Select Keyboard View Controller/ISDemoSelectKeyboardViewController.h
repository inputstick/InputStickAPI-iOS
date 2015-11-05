//
// Created by Marcin Wieclawski on 04/11/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class ISDemoSelectKeyboardViewController;
@protocol ISKeyboardLayoutProtocol;

@protocol ISDemoSelectKeyboardProtocol
- (void)selectKeyboardViewController:(ISDemoSelectKeyboardViewController *)viewController selectedKeyboardLayout:(id <ISKeyboardLayoutProtocol>)keyboardLayout;

@end

@interface ISDemoSelectKeyboardViewController : UITableViewController
@property(nonatomic, weak) id <ISDemoSelectKeyboardProtocol> delegate;
@property(nonatomic, readonly) id <ISKeyboardLayoutProtocol> selectedLayout;

- (id)initWithCurrentKeyboardLayout:(id <ISKeyboardLayoutProtocol>)layout;
@end
