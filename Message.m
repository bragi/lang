//
//  Message.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-16.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "Message.h"

@implementation Message

- (Message*) nextMessage {
	return nextMessage;
}

- (NSArray*)arguments {
	return arguments;
}

- (void) setNextMessage: (Message*) newNextMessage {
	[nextMessage autorelease];
	nextMessage = [newNextMessage retain];
}

- (void) setArguments: (NSArray*) newArguments {
	[arguments autorelease];
	arguments = [newArguments retain];
}

@end
