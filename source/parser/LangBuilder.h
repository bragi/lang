//
//  LangBuilder.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-02.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMessage.h"
#import "LRuntime.h"

@interface LangBuilder : NSObject {
    LRuntime *runtime;
    LMessage *message;
    LMessage *currentMessage;
    BOOL argumentStarted;
    NSMutableArray *messages;
}

@property (readonly) LMessage *message;

- (id)initWithRuntime:(LRuntime*)runtime;
- (void)identifier:(NSString*)name;
- (void)argumentsStart;
- (void)argumentsEnd;
- (void)nextArgument;
- (void)endMessage;
- (void)textLiteral:(NSString*)name;
- (void)numberLiteral:(NSString*)name;
- (void)addMessage:(LMessage*) newMessage;

@end
