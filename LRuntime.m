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

@synthesize currentTarget;
@synthesize topContext;

@synthesize theObject;
@synthesize theTrue;
@synthesize theText;

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
