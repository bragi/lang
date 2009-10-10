%%{
  machine Lang;

  newline = '\n' @{
    line += 1;
    column = 0;
  };
  
  newchar = any @{
    column += 1;
  };

  main := |*
    identifier = alpha+;
    
    # Alpha numberic characters or underscore.
    alnum_u = alnum | '_';
    
    # Alpha charactres or underscore.
    alpha_u = alpha | '_';
    
    # Identifier. Upon entering clear the buffer. On all transitions
    # buffer a character. Upon leaving, dump the identifier.
    alpha_u alnum_u* {
      [self identifier:ts length:te-ts];
    };
    
    '=' '='? | '+' | '-' | ':' {
      [self identifier:ts length:te-ts];
    };
    
    '"' ( [^\\"] | '\\' any ) * '"' {
      [self textLiteral:ts length:te-ts-1];
    };
    
    digit+  {
      [self numberLiteral:ts length:te-ts];
    };
    
    (" " | "\\\n")+;
    
    '(' {
      [self argumentsStart];
    };

    ("\n" | " ")* ')' {
      [self argumentsEnd];
    };
    
    ("\n" | " ")* ',' {
      [self nextArgument];
    };

    "." | "\n" {
      [self endMessage];
    };
    
  *|;
}%%

//
//  LangScanner.m
//  lang-grammar
//
//  Created by Łukasz Piestrzeniewicz on 09-09-02.
//  Copyright 2009 Ragnarson. All rights reserved.
//
#import "LangScanner.h"

%% write data nofinal;

@interface LangScanner()
- (void) identifier:(char*)start length:(int)length;
- (void) argumentsStart;
- (void) argumentsEnd;
- (void) nextArgument;
- (void) endMessage;
- (void) textLiteral:(char *)start length:(int)length;
- (void) numberLiteral:(char *)start length:(int)length;
@end

@implementation LangScanner

- (id) initWithBuilder:(LangBuilder*)newBuilder
{
    self = [super init];
    builder = newBuilder;
    return self;
}

- (void) nextArgument
{
    [builder nextArgument];
}

- (void) endMessage
{
    [builder endMessageWithLine:line andColumn:column];
}

- (void) argumentsStart
{
    [builder argumentsStart];
}

- (void) argumentsEnd
{
    [builder argumentsEnd];
}

- (void) identifier:(char*)start length:(int)length
{
    NSString* name = [[NSString alloc] initWithBytes:start length:length encoding:NSUTF8StringEncoding];
    [builder identifier:name withLine:line andColumn:column];
}

- (void) textLiteral:(char*)start length:(int)length
{
    NSString* name = [[NSString alloc] initWithBytes:start+1 length:length-1 encoding:NSUTF8StringEncoding];
    [builder textLiteral:name withLine:line andColumn:column];
}

- (void) numberLiteral:(char*)start length:(int)length
{
    NSString* name = [[NSString alloc] initWithBytes:start length:length encoding:NSUTF8StringEncoding];
    [builder numberLiteral:name withLine:line andColumn:column];
}

- (void) scan:(NSString*)code
{
    char *code_string = (char*)[code UTF8String];
    
    int cs, act;
    char *ts, *te = 0;
    char *p = code_string;
    char *pe = p + strlen(code_string);
    char *eof = pe;

    %% write init;
    %% write exec;
}
@end
