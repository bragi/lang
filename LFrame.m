//
//  LFrame.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-21.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LFrame.h"


@implementation LFrame
@synthesize target;
@synthesize context;
@synthesize message;

- (id) initWithTarget:(LObject*)newTarget context:(LObject*)newContext andMessage:(LMessage*)newMessage
{
	self = [super init];
	if(self)
	{
		self.target = newTarget;
		self.context = newContext;
		self.message = newMessage;
	}
	return self;
}

@end
