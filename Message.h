//
//  Message.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-16.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Message : NSObject {
	Message* next;
	Message*[] arguments;
}

- (Message*) next;
- (Message*[]) arguments;

- (void) setNext: (Message*)next;
- (void) setArguments: (Message*[])arguments;

@end
