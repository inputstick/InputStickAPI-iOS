//
// Created by Marcin Wieclawski on 26/07/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef int (*pointer_to_arrays)[5];

@protocol ISKeyboardLayoutProtocol <NSObject>

- (NSString *)layoutDescription;

- (pointer_to_arrays)lookupTable;

- (NSUInteger)numberOfCharacters;

@end
