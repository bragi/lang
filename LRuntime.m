//
//  LRuntime.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LRuntime.h"
#import "LFrame.h"
#import "RObject.h"

@implementation LRuntime

@synthesize currentTarget;
@synthesize topContext;

@synthesize theObject;
@synthesize theTrue;

- (id) init
{
    self = [super init];
    if (self)
    {
        theObject = [RObject buildWithRuntime: self];
        /** For now let's use theObject as top context, later we need another, better tailored object here. */
        topContext = theObject;
    }
    return self;
}

- (void) run:(LMessage*) message
{
	currentTarget = topContext;
	while (message) {
		LFrame* frame = [[LFrame alloc] initWithTarget:currentTarget context:topContext andMessage:message];
		currentTarget = [currentTarget send:frame];
		
		message = message.nextMessage;
	}
}

@end
