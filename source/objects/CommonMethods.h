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
@interface SelfMethod : LExecutable {}
@end


/** Executes Objective-C method called *name*WithExecution: */
@interface ForwardingMethod : LMethod
{
    SEL name;
}

- (id)initWithName:(NSString*)newName;

@end


/** 
 Creates new instance of LLangMethod with code provided in argument.
 Represents method() in runtime.
 */
@interface MethodMethod : LExecutable {}
@end


/** 
 Creates new instance of LLangMacro with code provided in argument.
 Represents macro() in runtime.
 */
@interface MacroMethod : LExecutable {}
@end


/** 
 Creates new instance of LList with evaluated arguments as list entries.
 Represents list() in runtime.
 */
@interface ListMethod : LExecutable {}
@end


/**
 Evaluates first argument and returns it.
 */
@interface EvaluateFirstArgumentMethod : LExecutable {}
@end

/**
 Forces execution to return evaulated argument and stop processing subsequent messages.
 */
@interface ReturnMethod : EvaluateFirstArgumentMethod {}
@end
