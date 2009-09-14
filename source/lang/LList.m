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

+ (id) buildWithAncestor:(LObject*)ancestor
{
    LList* theList = [[LList alloc] initWithEntries:[NSMutableArray arrayWithCapacity:0]];
    [theList addAncestor:ancestor];
    return theList;
}

- (id) initWithEntries:(NSMutableArray*)entries
{
    self = [super init];
    list = entries;
    return self;
}

- (LList*) mimicWithEntries:(NSMutableArray*)entries
{
    LList* mimic = [[LList alloc] initWithEntries:entries];
    [mimic addAncestor:self];
    return mimic;
}

- (LNumber*) lengthWithExecution:(LExecution*)execution
{
    return [execution.runtime makeNumberWithInteger:[list count]];
}

@end
