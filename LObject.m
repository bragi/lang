//
//  LObject.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LObject.h"


@implementation LObject
- (id) init
{
	self = [super init];
	if (self)
	{
		cells = [[NSMutableDictionary dictionary] retain];
		ancestors = [[NSMutableArray array] retain];
	}
	return self;
}

- (void) dealloc
{
	[ancestors release];
	[cells release];
	[super dealloc];
}

- (void) setCell: (LObject*) object withName: (NSString*) name
{
	[name retain];
	[object retain];
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
@end
