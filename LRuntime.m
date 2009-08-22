//
//  LRuntime.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LRuntime.h"
#import "LFrame.h"

@implementation LRuntime

@synthesize currentTarget;
@synthesize topContext;

- (void) run:(Message*) message
{
	currentTarget = topContext;
	while (message) {
		LFrame* frame = [[LFrame alloc] initWithTarget:currentTarget context:topContext andMessage:message];
		currentTarget = [currentTarget send:frame];
		
		message = message.nextMessage;
	}
}

@end
