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

/** Base class for all methods. */
@interface LMethod : LObject {}
@end

/** Represents methods created in runtime using method(). */
@interface LLangMethod : LMethod {
    LMessage* code;
}
- (id) initWithCode:(LMessage*)newCode;
@end
