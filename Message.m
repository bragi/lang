//
//  Message.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-16.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "Message.h"


@implementation Message

- (Message*) next {
	return next;
}

- (Message*[])arguments {
	return arguments;
}

- (void) setNext: (Message*) input {
	[next autorelease];
	next = [input retain];
}

- (void) setArguments: (NSArray*) input {
	[next autorelease];
	next = [input retain];
}

@end
