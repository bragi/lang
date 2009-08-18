//
//  LangObject.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LangObject.h"


@implementation LangObject
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

- (void) setCell: (LangObject*) object withName: (NSString*) name
{
	[name retain];
	[object retain];
	[cells setValue: object forKey: name];
}

- (LangObject*) cellForName: (NSString*) name
{
	return [cells valueForKey:name];
}

- (void) addAncestor: (LangObject*)ancestor
{
	[ancestors addObject:ancestor];
}
@end
