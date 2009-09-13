//
//  LObject.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LObject.h"
#import "LMessage.h"
#import "LExecution.h"

@implementation LObject

+ (id) build
{
    return [[LObject alloc] init];
}

+ (id) buildWithAncestor:(LObject*)ancestor
{
    LObject* object = [LObject build];
    [object addAncestor:ancestor];
    return object;
}

- (id) init
{
	self = [super init];
	if (self)
	{
		cells = [NSMutableDictionary dictionary];
		ancestors = [NSMutableArray array];
	}
	return self;
}

- (void) setCell: (LObject*) object withName: (NSString*) name
{
	[cells setValue: object forKey: name];
}

- (LObject*) cellForName: (NSString*) name
{
	LObject* cell = [cells valueForKey:name];
	if (cell) return cell;
	LObject* ancestor;
	for(ancestor in [ancestors reverseObjectEnumerator])
	{
		cell = [ancestor cellForName:name];
		if (cell) return cell;
	}
	return nil;
}

- (void) addAncestor: (LObject*)ancestor
{
	[ancestors addObject:ancestor];
}

- (LObject*) activate: (LExecution*)execution
{
	return self;
}

- (LObject*) mimic
{
    LObject* mimic = [[LObject alloc] init];
    [mimic addAncestor:self];
    return mimic;
}

- (LObject*) send: (LExecution*)execution
{
    LMessage* message = execution.message;
    NSString* name = [message name];
	LObject* cell = [self cellForName: name];
	return [cell activate:execution];
}

- (LObject*) assignmentWithExecution: (LExecution*) execution
{
    // TODO: validate number of arguments
    NSArray* arguments = [[execution message] arguments];
    NSString* name = [(LMessage*)[arguments objectAtIndex:0] name];
    LObject* value = [execution evaluateWithCurrentContext:[arguments objectAtIndex:1]];
    [self setCell:value withName:name];
    
    return value;
}

- (LObject*) mimicWithExecution: (LExecution*)execution
{
    return [self mimic];
}

@end

