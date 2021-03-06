//
//  LangParserTestCase.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-09.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "LMessage.h"

@interface LangParserTestCase : SenTestCase {
    LRuntime *runtime;
    LMessage *message;
    LMessage *argument;
}

@end
