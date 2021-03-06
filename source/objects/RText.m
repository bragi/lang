//
//  RText.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-27.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RText.h"
#import "LExecution.h"
#import "LText.h"
#import "CommonMethods.h"

@implementation RText

+ (void)addCellsTo: (LObject*)object inRuntime:(LRuntime*)runtime
{
    /* Add methods */
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"upcase"]] withName:@"upcase"];
    [object setCell:[runtime withExecutableAncestor:[[ESelf alloc] init]] withName:@"toText"];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"puts"]] withName:@"puts"];
}

@end
