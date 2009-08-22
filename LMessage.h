//
//  LMessage.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-16.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LMessage : NSObject {
	NSString* name;
	LMessage* nextMessage;
	NSMutableArray* arguments;
}

- (id) initWithName: (NSString*)newName;

@property (retain) LMessage* nextMessage;
@property (retain) NSString* name;
@property (retain) NSMutableArray* arguments;


- (void) addArgument: (LMessage*)argument;
- (NSString*) stringValue;
- (NSMutableString*) stringValueWithoutNested;
@end

@interface EolLMessage : LMessage {
}

- (id) init;
@end
