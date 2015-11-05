//
// Created by Marcin Wieclawski on 05/11/15.
// Copyright (c) 2015 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISConsumerHandler.h"


@interface ISDemoConsumerCellDefinition : NSObject
@property(nonatomic, readonly) ISConsumerActions consumerAction;
@property(nonatomic, readonly) ISSystemActions systemAction;
@property(nonatomic, strong) NSString *title;

- (instancetype)initWithConsumerAction:(ISConsumerActions)consumerAction title:(NSString *)title;

- (instancetype)initWithSystemAction:(ISSystemActions)systemAction title:(NSString *)title;

@end
