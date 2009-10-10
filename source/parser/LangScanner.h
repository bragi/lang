//
//  LangScanner.h
//  lang-grammar
//
//  Created by Łukasz Piestrzeniewicz on 09-09-02.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LangBuilder.h"

@interface LangScanner : NSObject {
    LangBuilder *builder;
    NSUInteger line;
    NSUInteger column;
}

- (id)initWithBuilder:(LangBuilder*)builder;
- (void)scan:(NSString*)code;
@end
