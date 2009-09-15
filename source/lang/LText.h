//
//  LText.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-27.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"

@interface LText : LObject {
    NSString* text;  
}

@property (readonly, retain) NSString* text;

+ (id) textWithAncestor:(LObject*)ancestor string:(NSString*)string;
- (id) initWithString:(NSString*)newText;

// Messages forwarded by runtime execution.

/** Return text with upcase content. */
- (LText*) upcaseWithExecution:(LExecution*)execution;

@end
