//
//  MethodTestCase.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-28.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "LExecution.h"
#import "LRuntime.h"
#import "LObject.h"


@interface MethodTestCase : SenTestCase {
    LExecution* execution;
    LObject* context;
    LObject* result;
    LRuntime* runtime;
}

@end
