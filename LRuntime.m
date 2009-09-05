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
#import "RText.h"

@interface LRuntime()
- (void) createObjectHierarchy;
- (void) createObjectCells;
@end

@implementation LRuntime

@synthesize theBaseContext;

@synthesize theObject;
@synthesize theTrue;
@synthesize theFalse;
@synthesize theNil;
@synthesize theText;

- (id) init
{
    self = [super init];
    if (self)
    {
        [self createObjectHierarchy];
        [self createObjectCells];
    }
    return self;
}

- (void) createObjectHierarchy
{
    theBaseContext = [LObject build];
    theObject = [LObject buildWithAncestor:theBaseContext];
    theText = [LText buildWithAncestor:theObject];
}

- (void) createObjectCells
{
    [RObject addCellsTo:theObject];
    [RText addCellsTo:theText];
}

- (LText*) makeTextWithString:(NSString*)string
{
    return [theText mimicWithString:string];
}

@end
