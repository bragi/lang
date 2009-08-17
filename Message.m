//
//  Message.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-16.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "Message.h"

@implementation Message

- (id) initWithName: (NSString*) newName 
{
	self = [super init];
	if(self)
	{
		name = [newName retain];
		arguments = nil;
		nextMessage = nil;
	}
	return self;
}

- (void) dealloc
{
	[nextMessage autorelease];
	[arguments autorelease];
	[name autorelease];
	[super dealloc];
}

- (Message*) nextMessage 
{
	return nextMessage;
}

- (NSMutableArray*)arguments 
{
	return arguments;
}

- (void) setNextMessage: (Message*) newNextMessage 
{
	[nextMessage autorelease];
	nextMessage = [newNextMessage retain];
}

- (void) setArguments: (NSMutableArray*) newArguments 
{
	[arguments autorelease];
	arguments = [newArguments retain];
}

- (NSString*) stringValue
{
	NSMutableString* value = [NSMutableString stringWithString: name];
	[value retain];

	if([arguments count] >  0)
	{
		// add (
		[value appendString: @"("];
		
		Message* argument;
		BOOL first = YES;

		for(argument in arguments) {
			// add argument's name
			if(first) {
				first = NO;
			} else {
				[value appendString: @", "];
			}
			[value appendString: [argument stringValue]];
		}
		// add )
		[value appendString: @")"];
	}
	return value;
}

- (void) addArgument: (Message*) argument
{
	[argument retain];
	if(arguments == nil)
	{
		arguments = [NSMutableArray arrayWithObject:argument];
	}
	else
	{
		[arguments addObject: argument];
	}
}

@end

@implementation EolMessage
- (id) init
{
	self = [super initWithName:@"\n"];
	return self;
}
@end
