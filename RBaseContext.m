//
//  RBaseContext.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-05.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RBaseContext.h"
#import "CommonMethods.h"

@implementation RBaseContext

+ (void) addCellsTo: (LObject*)object inRuntime:(LRuntime*)runtime
{
    /* Add methods */
	[object setCell:[[SelfMethod alloc] init] withName:@"self"];
	[object setCell:[[ForwardingMethod alloc] initWithName:@"assignment"] withName:@"="];
	[object setCell:[[MethodMethod alloc] init] withName:@"method"];
	[object setCell:runtime.theObject withName:@"Object"];
}

@end
