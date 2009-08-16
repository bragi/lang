//
//  Message.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-16.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Message : NSObject {
	Message* nextMessage;
	NSArray* arguments;
}

- (Message*) nextMessage;
- (NSArray*) arguments;

- (void) setNextMessage: (Message*)newNextMessage;
- (void) setArguments: (NSArray*)newArguments;

@end
