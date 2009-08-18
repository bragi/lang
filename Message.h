//
//  Message.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-16.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Message : NSObject {
	NSString* name;
	Message* nextMessage;
	NSMutableArray* arguments;
}

- (id) initWithName: (NSString*)newName;
- (void) dealloc;

- (Message*) nextMessage;
- (NSMutableArray*) arguments;

- (void) setNextMessage: (Message*)newNextMessage;
- (void) setArguments: (NSMutableArray*)newArguments;

- (void) addArgument: (Message*)argument;
- (NSString*) stringValue;
- (NSMutableString*) stringValueWithoutNested;
@end

@interface EolMessage : Message {
}

- (id) init;
@end
