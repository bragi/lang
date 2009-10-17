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
@interface ESelf : LExecutable {}
@end


/** Executes Objective-C method called *name*WithExecution: */
@interface EForward : LMethod
{
    NSString *name;
    SEL nameSelector;
}

- (id)initWithName:(NSString*)newName;

@end


/** 
 Creates new instance of LLangMethod with code provided in argument.
 Represents method() in runtime.
 */
@interface ECreateMethod : LExecutable {}
@end


/** 
 Creates new instance of LLangMacro with code provided in argument.
 Represents macro() in runtime.
 */
@interface ECreateMacro : LExecutable {}
@end


/** 
 Creates new instance of LList with evaluated arguments as list entries.
 Represents list() in runtime.
 */
@interface ECreateList : LExecutable {}
@end


/**
 Evaluates first argument and returns it.
 */
@interface EEvaluateFirstArgument : LExecutable {}
@end

/**
 Forces execution to return evaulated argument and stop processing subsequent messages.
 */
@interface EReturn : EEvaluateFirstArgument {}
@end
