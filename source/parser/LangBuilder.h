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
- (void)identifier:(NSString*)name withLine:(NSUInteger)line andColumn:(NSUInteger)column;
- (void)identifierWithArguments:(NSString*)name withLine:(NSUInteger)line andColumn:(NSUInteger)column;
- (void)argumentsEnd;
- (void)nextArgument;
- (void)endMessageWithLine:(NSUInteger)line andColumn:(NSUInteger)column;
- (void)textLiteral:(NSString*)name withLine:(NSUInteger)line andColumn:(NSUInteger)column;
- (void)numberLiteral:(NSString*)name withLine:(NSUInteger)line andColumn:(NSUInteger)column;
- (void)addMessage:(LMessage*)newMessage;

@end
