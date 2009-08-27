//
//  LLiteral.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-27.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMessage.h"

/** Base class for all literals. */
@interface LLiteral : LMessage {}
@end

/** Text literal. */
@interface LTextLiteral : LLiteral {
    NSString* text;
}
@end
