//
//  LRuntime.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LRuntime.h"
#import "LExecution.h"
#import "LangParser.h"

#import "RBaseContext.h"
#import "RBoolean.h"
#import "RNil.h"
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
@synthesize theNumber;
@synthesize theList;

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
    theTrue = [LObject buildWithAncestor:theObject];
    theFalse = [LObject buildWithAncestor:theObject];
    theNil = [LObject buildWithAncestor:theObject];
    theNumber = [LNumber buildWithAncestor:theObject];
    theList = [LList buildWithAncestor:theObject];
}

- (void) createObjectCells
{
    [RBaseContext addCellsTo:theBaseContext inRuntime:self];
    [RObject addCellsTo:theObject inRuntime:self];
    [RText addCellsTo:theText inRuntime:self];
    [RTrue addCellsTo:theTrue inRuntime:self];
    [RFalse addCellsTo:theFalse inRuntime:self];
    [RNil addCellsTo:theNil inRuntime:self];
}

- (LText*) makeTextWithString:(NSString*)string
{
    return [theText mimicWithString:string];
}

- (LNumber*) makeNumberWithString:(NSString*)string
{
    return [theNumber mimicWithString:string];
}

- (LRuntime*) bootstrap
{
    // BOGUS: this is trully HARDcoded :(
    NSString* codeText = [NSString stringWithContentsOfFile:@"/Users/bragi/projects/lang-objective-c/system/boot.lang" encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"Parsing bootstrap code");
    LMessage* code = [LangParser parse:codeText];
    NSLog(@"Executing bootstrap code");
    [[LExecution buildWithRuntime:self] runMessage:code withContext:theBaseContext];
    return self;
}

@end
