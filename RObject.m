//
//  RObject.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RObject.h"
#import "LExecution.h"

@implementation RObject

+ (void) addCellsTo: (LObject*)object
{
    /* Add methods */
	[object setCell:[[SelfMethod alloc] init] withName:@"self"];
	[object setCell:[[ForwardingMethod alloc] initWithName:@"mimic"] withName:@"mimic"];
	[object setCell:[[ForwardingMethod alloc] initWithName:@"assignment"] withName:@"="];
	[object setCell:[[MethodMethod alloc] init] withName:@"method"];
}

@end


@implementation SelfMethod

- (LObject*) activate: (LExecution*)execution
{
	return execution.target;
}

@end


@implementation ForwardingMethod
- (id) initWithName:(NSString*)newName
{
    self = [super init];
    name = sel_registerName([[newName stringByAppendingString:@"WithExecution:"] UTF8String]);
    return self;
}

- (LObject*) activate: (LExecution*)execution
{
    return (LObject*)objc_msgSend(execution.target, name, execution);
}

@end


@implementation MethodMethod

- (LObject*)activate:(LExecution*)execution
{
    // Create and return new instance of LLangMethod
    NSArray* arguments = [execution.message arguments];
    LMessage* code = (LMessage*)[arguments lastObject];
    return [[LLangMethod alloc] initWithCode:code];
}

@end
