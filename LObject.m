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
	LObject* cell = [self cellForName: [message name]];
	return [cell activate:execution];
}

- (LObject*) mimicWithExecution: (LExecution*)execution
{
    return [self mimic];
}

@end

