//
//  LangParser.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-09.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMessage.h"
#import "LRuntime.h"

/** Allows to parse given string returning LMessage chain. */
@interface LangParser : NSObject {
    NSString *codeText;
    NSUInteger length;
    NSUInteger currentPosition;
    NSUInteger lineNumber;
    NSUInteger columnNumber;
    LRuntime *runtime;
}

/**
 Parses given string and returns a message object.
 */
+ (LMessage*)parse:(NSString*)codeText inRuntime:(LRuntime*)runtime;

- (id)initWithCode:(NSString*)codeText andRuntime:(LRuntime*)runtime;

- (LMessage*)parse;
- (LMessage*)parseExpression;
- (LMessage*)parseExpressions;
- (NSMutableArray*)parseExpressionChain;

- (LMessage*)parseComment;
- (void)parseCharacter:(unichar)ch;
- (LMessage*)parseCurlyMessageSend;
- (LMessage*)parseEmptyMessageSend;
- (LMessage*)parseOperatorChars:(unichar)start;
- (LMessage*)parseNumber:(unichar)start;
- (LMessage*)parseRange;
- (LMessage*)parseRegexpLiteral:(unichar)start;
- (LMessage*)parseRegularMessageSend:(unichar)start;
- (LMessage*)parseSquareMessageSend;
- (LMessage*)parseSetMessageSend;
- (LMessage*)parseTerminator:(unichar)start;
- (LMessage*)parseText:(unichar)start;

- (void)readWhiteSpace;
- (void)fail:(NSString*)message;
- (void)fail:(NSString*)message line:(NSUInteger)line column:(NSUInteger)column;
- (LMessage*)message:(LMessage*)message withLine:(NSUInteger)line andColumn:(NSUInteger)column;
- (unichar)read;
- (unichar)peek;
- (unichar)peek2;
- (BOOL)isLetter:(unichar)ch;
- (BOOL)isIDDigit:(unichar)ch;
@end
