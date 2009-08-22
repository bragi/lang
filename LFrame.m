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

- (id) initWithTarget:(LObject*)newTarget context:(LObject*)newContext andLMessage:(LMessage*)newLMessage
{
	self = [super init];
	if(self)
	{
		self.target = newTarget;
		self.context = newContext;
		self.message = newLMessage;
	}
	return self;
}

@end
