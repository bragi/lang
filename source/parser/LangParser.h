//
//  LangParser.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-09.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMessage.h"

/** Allows to parse given string returning LMessage chain. */
@interface LangParser : NSObject {
}
/**
 Parses given string and returns a message object.
 */
+ (LMessage*)parse:(NSString*)codeText inRuntime:(LRuntime*)runtime;

@end
