//
//  CommonMethods.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-05.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMethod.h"

/**
 Returns the receiver.
 */
@interface SelfMethod : LMethod {}
@end

/**
 Returns theTrue object
 */
@interface TrueMethod : LMethod {}
@end

/**
 Returns theFalse object
 */
@interface FalseMethod : LMethod {}
@end

/** Executes Objective-C method called *name*WithExecution: */
@interface ForwardingMethod : LMethod
{
    SEL name;
}

- (id) initWithName:(NSString*)newName;

@end

/** 
 Creates new instance of LLangMethod with code provided in argument.
 Represents method() in runtime.
 */
@interface MethodMethod : LMethod {}
@end
