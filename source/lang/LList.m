//
//  LList.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-13.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LList.h"
#import "LExecution.h"
#import "LRuntime.h"

@implementation LList

@synthesize list;

+ (id)listWithAncestor:(LObject*)ancestor entries:(NSMutableArray*)entries
{
    LList *theList = [[LList alloc] initWithEntries:entries];
    [theList addAncestor:ancestor];
    return theList;
}

- (id)initWithEntries:(NSMutableArray*)entries
{
    self = [super init];
    list = entries;
    return self;
}

- (LNumber*)lengthWithExecution:(LExecution*)execution
{
    return [execution.runtime makeNumberWithInteger:[list count]];
}

@end
