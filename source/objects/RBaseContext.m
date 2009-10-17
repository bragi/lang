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

    /* Basic methods */
    [object setCell:[runtime withExecutableAncestor:[[ESelf alloc] init]] withName:@"self"];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"assignment"]] withName:@"="];
    [object setCell:[runtime withExecutableAncestor:[[ECreateMethod alloc] init]] withName:@"method"];
    [object setCell:[runtime withExecutableAncestor:[[ECreateMacro alloc] init]] withName:@"macro"];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"toText"]] withName:@"toText"];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"cell"]] withName:@"cell"];
    [object setCell:[runtime withExecutableAncestor:[[EEvaluateFirstArgument alloc] init]] withName:@""];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"equalsTo"]] withName:@"=="];

    /* Basic Objects Cell */
    [object setCell:object withName:@"BaseContext"];
    [object setCell:runtime.theCall withName:@"Call"];
    [object setCell:runtime.theExecutable withName:@"Executable"];
    [object setCell:runtime.theFalse withName:@"false"];
    [object setCell:runtime.theLangExecutable withName:@"LangExecutable"];
    [object setCell:runtime.theList withName:@"List"];
    [object setCell:runtime.theObject withName:@"Object"];
    [object setCell:runtime.theMacro withName:@"Macro"];
    [object setCell:runtime.theMessage withName:@"Message"];
    [object setCell:runtime.theMethod withName:@"Method"];
    [object setCell:runtime.theNil withName:@"nil"];
    [object setCell:runtime.theNumber withName:@"Number"];
    [object setCell:runtime.theText withName:@"Text"];
    [object setCell:runtime.theTrue withName:@"true"];

    /* List cell */
    [object setCell:[runtime withExecutableAncestor:[[ECreateList alloc] init]] withName:@"list"];
    [object setCell:[runtime withExecutableAncestor:[[ECreateList alloc] init]] withName:@"[]"];
}

@end
