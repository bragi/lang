//
//  LText.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-27.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LText.h"
#import "LExecution.h"
#import "LRuntime.h"

@implementation LText

@synthesize text;

+ (id)textWithAncestor:(LObject*)ancestor string:(NSString*)string
{
    LText *theText = [[LText alloc] initWithString:string];
    [theText addAncestor:ancestor];
    return theText;
}

- (id)initWithString:(NSString*)newText
{
    self = [super init];
    text = newText;
    return self;
}

- (LText*)upcaseWithExecution:(LExecution*)execution
{
    return [execution.runtime makeTextWithString:[self.text uppercaseString]];
}

- (LObject*)putsWithExecution:(LExecution*)execution
{
    NSLog(@"%@", text);
    return self;
}
@end
