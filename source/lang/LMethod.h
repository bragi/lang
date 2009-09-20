//
//  LMethod.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-21.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LMessage.h"

/** Base class for all executable code. */
@interface LExecutable : LObject {}
@end

/** 
 Base class for methods. Evaluates parameters and binds their values
 to names.
 */
@interface LMethod : LExecutable {}
@end

/** Represents methods created in runtime using method(). */
@interface LLangMethod : LExecutable {
    LMessage *code;
}

/** Initializes LLangMethod object and stores code to execute when activated. */
- (id)initWithCode:(LMessage*)newCode;

/** Builds context that keeps locals throughout method execution. */
- (id)methodContextWithExecution:(LExecution*)execution;
@end


/** Represents macros created in runtime using macro(). */
@interface LLangMacro : LExecutable {
    LMessage *code;
}

- (id)initWithCode:(LMessage*)newCode;

@end
