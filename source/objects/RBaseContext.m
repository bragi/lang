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

+ (void)addCellsTo:(LObject*)object inRuntime:(LRuntime*)runtime
{
    /* Self in BaseContext */
    [object setCell:object withName:@"BaseContext"];

    /* Basic methods */
    [object setCell:[runtime withExecutableAncestor:[[ESelf alloc] init]] withName:@"self"];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"assignment"]] withName:@"="];
    [object setCell:[runtime withExecutableAncestor:[[ECreateMethod alloc] init]] withName:@"method"];
    [object setCell:[runtime withExecutableAncestor:[[ECreateMacro alloc] init]] withName:@"macro"];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"toText"]] withName:@"toText"];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"cell"]] withName:@"cell"];
    [object setCell:[runtime withExecutableAncestor:[[EEvaluateFirstArgument alloc] init]] withName:@""];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"equalsTo"]] withName:@"=="];

    /* Object cell */
    [object setCell:runtime.theObject withName:@"Object"];
    
    /* True cell */
    [object setCell:runtime.theTrue withName:@"true"];

    /* False cell */
    [object setCell:runtime.theFalse withName:@"false"];

    /* Nil cell */
    [object setCell:runtime.theNil withName:@"nil"];

    /* Text cell */
    [object setCell:runtime.theText withName:@"Text"];

    /* Number cell */
    [object setCell:runtime.theNumber withName:@"Number"];

    /* List cell */
    [object setCell:runtime.theList withName:@"List"];
    [object setCell:[runtime withExecutableAncestor:[[ECreateList alloc] init]] withName:@"list"];
    [object setCell:[runtime withExecutableAncestor:[[ECreateList alloc] init]] withName:@"[]"];
}

@end
