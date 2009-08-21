//
//  Message.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-16.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "Message.h"

@implementation Message
@synthesize nextMessage;
@synthesize arguments;
@synthesize name;

- (id) initWithName: (NSString*) newName 
{
	self = [super init];
	if(self)
	{
		name = newName;
		arguments = nil;
		nextMessage = nil;
	}
	return self;
}

- (NSMutableString*) stringValueWithoutNested
{
	NSMutableString* value = [NSMutableString stringWithString: name];

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

- (NSString*) stringValue
{
	NSMutableString* value = [NSMutableString stringWithString: [self stringValueWithoutNested]];
	if(nextMessage) {
		Message* message = self;
		while (message = [message nextMessage]) {
			[value appendString: @" "];
			[value appendString: [message stringValueWithoutNested]];
		}
	}
	return value;
}

- (void) addArgument: (Message*) argument
{
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
