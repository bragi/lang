//
//  LPair.m
//  lang
//
//  Created by Łukasz Piestrzeniewicz on 09-10-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LPair.h"
#import "LExecution.h"

@implementation LPair

+ (LPair*)pairWithAncestor:(LObject*)ancestor key:(LObject*)key andValue:(LObject*)value
{
    LPair *pair = [[LPair alloc] initWithKey:key andValue:value];
    [pair addAncestor:ancestor];
    return pair;
}

- (id)initWithKey:(LObject*)aKey andValue:(LObject*)aValue
{
    self = [super init];
    key = aKey;
    value = aValue;
    return self;
}

/** Returns key. */
- (LObject*)keyWithExecution:(LExecution*)execution
{
    return key;
}

/** Returns value. */
- (LObject*)valueWithExecution:(LExecution*)execution
{
    return value;
}

@end
