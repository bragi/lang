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
#import "RList.h"
#import "RMessage.h"

@interface LRuntime()
- (void)createObjectHierarchy;
- (void)createObjectCells;
- (NSString*)bootstrapPath;
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
@synthesize theExecutable;
@synthesize theLangExecutable;
@synthesize theMethod;
@synthesize theMacro;
@synthesize theMessage;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self createObjectHierarchy];
        [self createObjectCells];
    }
    return self;
}

- (void)createObjectHierarchy
{
    theBaseContext = [LObject build];
    theObject = [LObject objectWithAncestor:theBaseContext];
    theText = [LText textWithAncestor:theObject string:@""];
    theTrue = [LObject objectWithAncestor:theObject];
    theFalse = [LObject objectWithAncestor:theObject];
    theNil = [LObject objectWithAncestor:theObject];
    theNumber = [LNumber numberWithAncestor:theObject integer:0];
    theList = [LList listWithAncestor:theObject entries:[NSMutableArray arrayWithCapacity:0]];
    theExecutable = [LObject objectWithAncestor:theObject];
    theLangExecutable = [LObject objectWithAncestor:theExecutable];
    theMethod = [LObject objectWithAncestor:theLangExecutable];
    theMacro = [LObject objectWithAncestor:theLangExecutable];
    theMessage = [LMessage messageWithName:@""];
    [theMessage addAncestor:theObject];
}

- (void)createObjectCells
{
    [RBaseContext addCellsTo:theBaseContext inRuntime:self];
    [RObject addCellsTo:theObject inRuntime:self];
    [RText addCellsTo:theText inRuntime:self];
    [RTrue addCellsTo:theTrue inRuntime:self];
    [RFalse addCellsTo:theFalse inRuntime:self];
    [RNil addCellsTo:theNil inRuntime:self];
    [RList addCellsTo:theList inRuntime:self];
    [RMessage addCellsTo:theMessage inRuntime:self];
}

- (LText*)makeTextWithString:(NSString*)string
{
    return [LText textWithAncestor:theText string:string];
}

- (LNumber*)makeNumberWithString:(NSString*)string
{
    return [LNumber numberWithAncestor:theNumber string:string];
}

- (LNumber*)makeNumberWithInteger:(NSInteger)integer
{
    return [LNumber numberWithAncestor:theNumber integer:integer];
}

- (LList*)makeListWithEntries:(NSMutableArray*)entries
{
    return [LList listWithAncestor:theList entries:entries];
}

- (LObject*)withExecutableAncestor:(LObject*)method
{
    [method addAncestor:theExecutable];
    return method;
}

- (LRuntime*)bootstrap
{
    // BOGUS: this is trully HARDcoded :(
    NSString *codeText = [NSString stringWithContentsOfFile:[self bootstrapPath] encoding:NSUTF8StringEncoding error:nil];

    LMessage *code = [LangParser parse:codeText inRuntime:self];

    [[LExecution buildWithRuntime:self] runMessage:code withContext:theBaseContext];
    NSLog(@"Bootstrapped");
    return self;
}

- (NSString*)bootstrapPath
{
    char *pathBuffer = "";
    uint32_t pathSize = strlen(pathBuffer);
    
    _NSGetExecutablePath(pathBuffer, &pathSize);
    pathBuffer = malloc(pathSize+1);
    pathBuffer[pathSize]=0;
    _NSGetExecutablePath(pathBuffer, &pathSize);
    
    NSString *path = [NSString stringWithCString:pathBuffer encoding:NSUTF8StringEncoding];
    free(pathBuffer);
    
    path = [path stringByAppendingPathComponent:@"../../../system/boot.lang"];
    path = [path stringByStandardizingPath];

    return path;
}

@end
