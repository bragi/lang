//
//  RObject.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RObject.h"


@implementation RObject
+ (RObject*) build
{
	RObject* object = [[RObject alloc] init];
	[object setCell:[[SelfMethod alloc] init] withName:@"self"];
	return object;
}
@end

@end

@implementation SelfMethod

- (LObject*) activate: (LFrame*)frame
{
	return [frame target];
}

@end
