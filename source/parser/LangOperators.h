//
//  LangOperators.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-27.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMessage.h"

@interface LangOperators : NSObject {
    LMessage *startMessage;
    LMessage *previousMessage2;
    LMessage *previousMessage;
    LMessage *currentMessage;
}

+ (LangOperators*)langOperators;

/**
 Returns message chain with all operators shuffled.
 */
- (LMessage*)shuffle:(LMessage*)message;

/**
 Returns message with shuffled arguments.
 */
- (LMessage*)shuffleArguments:(LMessage *)message;

/**
 Does the shuffling of assignement operator.
 */
- (void)shuffleAssignement;
@end
