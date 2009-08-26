//
//  LRuntime.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LRuntime.h"
#import "LExecution.h"
#import "RObject.h"

@interface LRuntime()
- (void) createObjectHierarchy;
- (void) createObjectCells;
@end

@implementation LRuntime

@synthesize currentTarget;
@synthesize topContext;

@synthesize theObject;
@synthesize theTrue;

- (id) init
{
    self = [super init];
    if (self)
    {
        [self createObjectHierarchy];
        [self createObjectCells];
        
        /** For now let's use theObject as top context, later we need another, better tailored object here. */
        topContext = theObject;
    }
    return self;
}

- (void) createObjectHierarchy
{
    theObject = [LObject build];
}

- (void) createObjectCells
{
    [RObject addCellsTo:theObject];
}

- (void) run:(LMessage*) message
{
}

@end
