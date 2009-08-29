//
//  RObject.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LMethod.h"

/**
 Adds cells and methods to Object.
 */
@interface RObject : NSObject {}

/** Sets all necessary cells and methods. */
+ (void) addCellsTo:(LObject*)object;
@end

/**
 Returns the receiver.
 */
@interface SelfMethod : LMethod {}
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
