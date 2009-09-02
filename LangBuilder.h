//
//  LangBuilder.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-02.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMessage.h"

@interface LangBuilder : NSObject {
    LMessage* message;
    LMessage* currentMessage;
    Boolean argumentStarted;
    NSMutableArray* messages;
}

- (LMessage*) message;
- (id) init;
- (void) identifier:(NSString*)name;
- (void) argumentsStart;
- (void) argumentsEnd;
- (void) nextArgument;
- (void) endMessage;
- (void) textLiteral:(NSString*)name;
- (void) numberLiteral:(NSString*)name;

- (void) addMessage:(LMessage*) newMessage;
@end
