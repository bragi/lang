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

- (LMessage*)parseCharacter:(unichar)ch
{
    return nil;
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
    LMessage *message = [self messageWithName:@"" line:line column:column];
    message.arguments = arguments;
    
    return message;
}

- (LMessage*)parseOperatorChars:(unichar)start
{
    return nil;
}

- (LMessage*)parseNumber:(unichar)start
{
    return nil;
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
    return nil;
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
    return nil;
}

- (LMessage*)parseText:(unichar)start
{
    return nil;
}

- (LMessage*)readWhiteSpace
{
    return nil;
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
    if (currentPosition > 0) {
        return [codeText characterAtIndex:(currentPosition - 1)];
    } else {
        return -1;
    }

}
     
- (LMessage*)messageWithName:(NSString*)name line:(NSUInteger)line column:(NSUInteger)column
{
    LMessage *message = [[LMessage alloc] initWithName:name];
    message.line = line;
    message.column = column;
    [message addAncestor:runtime.theMessage];
    return message;
}


- (void)fail:(NSString*)message
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
