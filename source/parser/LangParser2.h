//
//  LangParser2.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-10-04.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMessage.h"
#import "LRuntime.h"

/** Allows to parse given string returning LMessage chain. */
@interface LangParser2 : NSObject {
    NSString *codeText;
    NSUInteger currentPosition;
    NSUInteger lineNumber;
    NSUInteger columnNumber;
    LRuntime *runtime;
}

/**
 Parses given string and returns a message object.
 */
+ (LMessage*)parse:(NSString*)codeText inRuntime:(LRuntime*)runtime;

- (id)initWithCode:(NSString*)codeText andRuntime:(LRuntime*)runtime;

- (LMessage*)parse;
- (LMessage*)parseExpressions;
- (LMessage*)parseExpression;

- (unichar)read;
- (unichar)peek;
- (unichar)peek2;

@end
