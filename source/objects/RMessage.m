//
//  RMessage.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-25.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RMessage.h"
#import "LExecution.h"
#import "LList.h"
#import "CommonMethods.h"


@implementation RMessage

+ (void)addCellsTo: (LObject*)object inRuntime:(LRuntime*)runtime
{
    /* Add methods */
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"next"]] withName:@"next"];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"arguments"]] withName:@"arguments"];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"name"]] withName:@"name"];
}

@end
