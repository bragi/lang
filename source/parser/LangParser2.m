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
    unichar rr;

    while(true) {
        rr = [self peek];
        switch(rr) {
            case -1:
                [self read];
                return nil;
            case ',':
            case ')':
            case ']':
            case '}':
                return nil;
            case '(':
                [self read];
                return [self parseEmptyMessageSend];
            case '[':
                [self read];
                return [self parseSquareMessageSend];
            case '{':
                [self read];
                return [self parseCurlyMessageSend];
            case '#':
                [self read];
                switch([self peek]) {
                case '{':
                    return [self parseSetMessageSend];
                case '/':
                    return [self parseRegexpLiteral:'/'];
                case '[':
                    return [self parseText:'['];
                case 'r':
                    return [self parseRegexpLiteral:'r'];
                case '!':
                    [self parseComment];
                    break;
                default:
                    return [self parseOperatorChars:'#'];
                }
                break;
            case '"':
                [self read];
                return [self parseText:'"'];
            case '0':
            case '1':
            case '2':
            case '3':
            case '4':
            case '5':
            case '6':
            case '7':
            case '8':
            case '9':
                [self read];
                return [self parseNumber:rr];
            case '.':
                [self read];
                if((rr = [self peek]) == '.') {
                    return [self parseRange];
                } else {
                    return [self parseTerminator:'.'];
                }
            case ';':
                [self read];
                [self parseComment];
                break;
            case ' ':
                [self read];
                [self readWhiteSpace];
                break;
            case '\\':
                [self read];
                if((rr = [self peek]) == '\n') {
                    [self read];
                    break;
                } else {
                    [self fail:@"Expected newline after free-floating escape character"];
                }
                break;
            case '\n':
                [self read];
                return [self parseTerminator:rr];
            case '+':
            case '-':
            case '*':
            case '%':
            case '<':
            case '>':
            case '!':
            case '?':
            case '~':
            case '&':
            case '|':
            case '^':
            case '$':
            case '=':
            case '@':
            case '\'':
            case '`':
            case '/':
                [self read];
                return [self parseOperatorChars:rr];
            case ':':
                [self read];
                if([self isLetter:(rr = [self peek])] || [self isIDDigit:rr]) {
                    return [self parseRegularMessageSend:':'];
                } else {
                    return [self parseOperatorChars:':'];
                }
            default:
                [self read];
                return [self parseRegularMessageSend:rr];
        }
    }
}

- (NSMutableArray*)parseExpressionChain
{
    NSMutableArray *chain = [NSMutableArray array];

    LMessage *currentMessage = [self parseExpressions];
    while(currentMessage) {
        [chain addObject:currentMessage];
        [self readWhiteSpace];

        unichar rr = [self peek];
        if(rr == ',') {
            [self read];
            currentMessage = [self parseExpressions];
            if(!currentMessage) {
              [self fail:@"Expected expression following comma"];
            }
        } else {
            if(currentMessage && [currentMessage isTerminator] && currentMessage.nextMessage == nil) {
                [chain removeLastObject];
            }
            currentMessage = nil;
        }
    }

    return chain;
}

- (void)parseCharacter:(unichar)ch
{
    NSUInteger line = lineNumber;
    NSUInteger column = columnNumber;

    [self readWhiteSpace];
    unichar rr = [self read];
    if(rr != ch) {
        NSString *message = [NSString stringWithFormat:@"Expected %C got %C", ch, rr];
        [self fail:message line:line column:column];
    }
}

- (LMessage*)parseComment
{
    return nil;
}

- (LMessage*)parseCurlyMessageSend
{
    return nil;
}

- (LMessage*)parseEmptyMessageSend
{
    NSUInteger line = lineNumber;
    NSUInteger column = columnNumber-1;
    NSMutableArray *arguments = [self parseExpressionChain];
    [self parseCharacter:')'];
    LMessage *message = [self message:[LMessage messageWithName:@""] withLine:line andColumn:column];
    message.arguments = arguments;
    
    return message;
}

- (LMessage*)parseOperatorChars:(unichar)indicator
{
    NSUInteger line = lineNumber;
    NSUInteger column = columnNumber;

    NSMutableString *name = [NSMutableString string];
    [name appendFormat:@"%C", indicator];
    LMessage *message;

    unichar rr;
    
    if(indicator == '#') {
        while(true) {
            rr = [self peek];
            switch(rr) {
                case '+':
                case '-':
                case '*':
                case '%':
                case '<':
                case '>':
                case '!':
                case '?':
                case '~':
                case '&':
                case '|':
                case '^':
                case '$':
                case '=':
                case '@':
                case '\'':
                case '`':
                case ':':
                case '#':
                    [self read];
                    [name appendFormat:@"%C", rr];
                    break;
                default:
                    message = [self message:[LMessage messageWithName:name] withLine:line andColumn:column];

                    if(rr == '(') {
                        [self read];
                        NSMutableArray *arguments = [self parseExpressionChain];
                        [self parseCharacter:')'];
                        message.arguments = arguments;
                    }
                    return message;
            }
        }
    } else {
        while(true) {
            rr = [self peek];
            switch(rr) {
                case '+':
                case '-':
                case '*':
                case '%':
                case '<':
                case '>':
                case '!':
                case '?':
                case '~':
                case '&':
                case '|':
                case '^':
                case '$':
                case '=':
                case '@':
                case '\'':
                case '`':
                case '/':
                case ':':
                case '#':
                    [self read];
                    [name appendFormat:@"%C", rr];
                    break;
                default:
                    message = [self message:[LMessage messageWithName:name] withLine:line andColumn:column];

                    int rr2 = rr;
                    [self readWhiteSpace];
                    rr = [self peek];

                    if(rr == '(') {
                        [self read];
                        NSMutableArray *arguments = [self parseExpressionChain];
                        [self parseCharacter:')'];
                        message.arguments = arguments;
                        if(rr != rr2) {
                            // Message.SetType(mx, Message.Type.DETACH);
                            // TODO: DETACH message type
                        }
                    }
                    return message;
                }
        }
    }
}

// TODO: include hexadecimal digits and scientific notation
- (LMessage*)parseNumber:(unichar)indicator
{
    NSUInteger line = lineNumber;
    NSUInteger column = columnNumber;

    NSMutableString *name = [NSMutableString string];
    [name appendFormat:@"%C", indicator];
    LMessage *message;
    unichar rr = [self peek];
    
    // Read all decimal digits
    while (rr >= '0' && rr <= '9') {
        [self read];
        [name appendFormat:@"%C", rr];
        rr = [self peek];
    }
    
    // Check for decimal
    if (rr == '.') {
        // Check if there are more digits after decimal or is it simply EndMessage
        unichar rr2 = [self peek2];
        if (rr2 >= '0' && rr2 <= '9' ) {
            [self read];
            [name appendFormat:@"%C", rr];
            
            // Get remaining decimal digits
            while (rr >= '0' && rr <= '9') {
                [self read];
                [name appendFormat:@"%C", rr];
                rr = [self peek];
            }
        }
    }
    
    return [self message:[LNumberLiteral messageWithName:name] withLine:line andColumn:column];
}

- (LMessage*)parseRange
{
    return nil;
}

- (LMessage*)parseRegexpLiteral:(unichar)start
{
    return nil;
}

- (LMessage*)parseRegularMessageSend:(unichar)start
{
    NSUInteger line = lineNumber;
    NSUInteger column = columnNumber;
    
    NSMutableString *name = [NSMutableString string];
    [name appendFormat:@"%C", start];
    
    unichar rr = [self peek];
    
    while([self isLetter:rr] || [self isIDDigit:rr] || rr == ':' || rr == '!' || rr == '?' || rr == '$') {
        [self read];
        [name appendFormat:@"%C", rr];
    }
    
    LMessage *result = [self message:[LMessage messageWithName:name] withLine:line andColumn:column];
    

    unichar rr2 = rr;
    [self readWhiteSpace];
    rr = [self peek];
    if(rr == '(') {
        [self read];
        NSMutableArray *arguments = [self parseExpressionChain];
        [self parseCharacter:')'];
        result.arguments = arguments;

        if(rr != rr2) {
            // Message.SetType(mx, Message.Type.DETACH);
            // TODO: what is detach?!
        }
    }

    return result;
}

- (LMessage*)parseSquareMessageSend
{
    return nil;
}

- (LMessage*)parseSetMessageSend
{
    return nil;
}

- (LMessage*)parseTerminator:(unichar)start
{
    NSUInteger line = lineNumber;
    NSUInteger column = columnNumber;
    
    NSMutableString *name = [NSMutableString string];
    [name appendFormat:@"%C", start];

    unichar rr;
    unichar rr2;

    while(true) {
        rr = [self peek];
        rr2 = [self peek2];
        if((rr == '.' && rr2 != '.') || (rr == '\n')) {
            [self read];
        } else {
            break;
        }
    }

    return [self message:[EndMessage messageWithName:name] withLine:line andColumn:column];
}

- (LMessage*)parseText:(unichar)start
{
    NSUInteger line = lineNumber;
    NSUInteger column = columnNumber;
    
    NSMutableString *name = [NSMutableString string];
    unichar rr;
    unichar rr2;
    
    switch (start) {
        case '"':
            rr = [self peek];
            while (rr != '"') {
                // TODO: add escaping
                [self read];
                [name appendFormat:@"%C", rr];
            }
            break;
        default:
            break;
    }
    return [self message:[LTextLiteral messageWithName:name] withLine:line andColumn:column];
    
}

- (void)readWhiteSpace
{
    unichar ch = [self peek];
    while (ch == ' ') {
        [self read];
        ch = [self peek];
    }
}

- (unichar)read
{
    if (currentPosition < [codeText length]) {
        unichar value = [codeText characterAtIndex:currentPosition];
        currentPosition++;
        if (value == '\n') {
            lineNumber++;
            columnNumber = 0;
        } else {
            columnNumber++;
        }

        return value;
    } else {
        return -1;
    }

}

- (unichar)peek
{
    if (currentPosition < [codeText length]) {
        return [codeText characterAtIndex:currentPosition];
    } else {
        return -1;
    }

}
- (unichar)peek2
{
    if (currentPosition < ([codeText length] -1)) {
        return [codeText characterAtIndex:(currentPosition + 1)];
    } else {
        return -1;
    }

}
     
- (LMessage*)message:(LMessage*)message withLine:(NSUInteger)line andColumn:(NSUInteger)column
{
    message.line = line;
    message.column = column;
    [message addAncestor:runtime.theMessage];
    return message;
}


- (void)fail:(NSString*)message
{
    
}

- (void)fail:(NSString*)message line:(NSUInteger)line column:(NSUInteger)column
{
    
}

- (BOOL)isLetter:(unichar)c
{
    return ((c>='A' && c<='Z') ||
            c=='_' ||
            (c>='a' && c<='z'));
}

- (BOOL)isIDDigit:(unichar)c
{
    return ((c>='0' && c<='9'));
}

@end
