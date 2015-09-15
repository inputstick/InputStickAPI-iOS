//
// Created by Marcin Wieclawski on 26/07/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISKeyboardLayoutProtocol;


@interface ISKeyboardKeyModel : NSObject
@property(nonatomic, readonly) unichar unicodeCode;
@property(nonatomic) Byte modifier;
@property(nonatomic) Byte key;
@property(nonatomic) Byte deadkeyModified;
@property(nonatomic) Byte deadkey;

- (instancetype)initWithUnicodeCharacter:(unichar)unicodeCharacter;

+ (ISKeyboardKeyModel *)modelForCharacter:(unichar)character withKeyboardLayout:(id <ISKeyboardLayoutProtocol>)keyboardLayout;

#pragma mark - Keyboard reports array conversion

- (NSArray *)keyboardReports;

- (NSInteger)numberOfKeyboardReports;

@end
