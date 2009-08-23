//
//  RObject.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RObject.h"


@implementation RObject
+ (RObject*) buildWithRuntime:(Runtime*)runtime
{
	RObject* object = [[RObject alloc] init];
    object.runtime = runtime;
    /* Add cells... */
    /* Add methods */
	[object setCell:[[SelfMethod alloc] init] withName:@"self"];
	return object;
}
@end

@implementation SelfMethod

- (LObject*) activate: (LFrame*)frame
{
	return [frame target];
}

@end
