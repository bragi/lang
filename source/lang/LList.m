//
//  LList.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-13.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LList.h"


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

@end
