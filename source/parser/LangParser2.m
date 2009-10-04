//
//  LangParser2.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-10-04.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LangParser2.h"


@implementation LangParser2

+ (LMessage*)parse:(NSString*)codeText inRuntime:(LRuntime*)runtime
{
    LangParser2 *parser = [[LangParser2 alloc] initWithCode:codeText andRuntime:runtime];
    return [parser parse];
}

- (id)initWithCode:(NSString*)aCodeText andRuntime:(LRuntime*)aRuntime
{
    self = [super init];
    runtime = aRuntime;
    codeText = aCodeText;
    currentPosition = 0;
    lineNumber = 0;
    columnNumber = 0;
    return self;
}

- (LMessage*)parse
{
    return [self parseExpressions];
}

- (LMessage*)parseExpressions
{
    LMessage *current;
    LMessage *last;
    LMessage *head;
    while (current = [self parseExpression]) {
        if(head)
        {
            last.nextMessage = current;
            last = current;
        }
        else {
            head = current;
            last = current;
        }
    }
    
    // TODO: skip terminators
    return head;
}

- (LMessage*)parseExpression
{
    return nil;
}

- (unichar)read
{
    unichar value = [codeText characterAtIndex:currentPosition];
    currentPosition++;
    if (value == '\n') {
        lineNumber++;
        columnNumber = 0;
    } else {
        columnNumber++;
    }

    return value;
}

- (unichar)peek
{
    if (currentPosition > 0) {
        return [codeText characterAtIndex:(currentPosition - 1)];
    } else {
        return nil;
    }

}
- (unichar)peek2
{
    if (currentPosition > 1) {
        return [codeText characterAtIndex:(currentPosition - 2)];
    } else {
        return nil;
    }

}
@end
