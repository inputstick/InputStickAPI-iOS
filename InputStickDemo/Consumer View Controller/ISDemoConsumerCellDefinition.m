/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import "ISDemoConsumerCellDefinition.h"


@implementation ISDemoConsumerCellDefinition

- (instancetype)initWithConsumerAction:(ISConsumerActions)consumerAction title:(NSString *)title {
    self = [super init];
    if (self) {
        _consumerAction = consumerAction;
        _title = title;
    }
    return self;
}

- (instancetype)initWithSystemAction:(ISSystemActions)systemAction title:(NSString *)title {
    self = [super init];
    if (self) {
        _systemAction = systemAction;
        _title = title;
    }

    return self;
}


@end
