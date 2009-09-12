//
//  Lang.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-09.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LMessage.h"
#import "LRuntime.h"
#import "LExecution.h"

/** Represents language. */
@interface Lang : NSObject {
    LExecution* execution;
    LMessage* code;
    LRuntime* runtime;

}

@property (readonly) LRuntime* runtime;

- (LObject*)run:(NSString*)codeText;
@end
