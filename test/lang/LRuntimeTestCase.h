//
//  LRuntimeTestCase.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "LRuntime.h"

@interface LRuntimeTestCase : SenTestCase {
    LRuntime *runtime;
    LExecution *execution;
    LMessage *code;
    LObject *result;
}

- (LObject*)executeCode;
- (LObject*)executeText:(NSString*)codeText;

@end
