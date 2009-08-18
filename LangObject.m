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
	LangObject* cell = [cells valueForKey:name];
	if (cell) return cell;
	LangObject* ancestor;
	for(ancestor in [ancestors reverseObjectEnumerator])
	{
		cell = [ancestor cellForName:name];
		if (cell) return cell;
	}
	return nil;
}

- (void) addAncestor: (LangObject*)ancestor
{
	[ancestors addObject:ancestor];
}
@end
