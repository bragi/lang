%%{
  machine Lang;
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
    
    "." | "\n" {
      [self endMessage];
    };
    
    '(' {
      [self argumentsStart];
    };

    ')' {
      [self argumentsEnd];
    };
    
    ',' {
      [self nextArgument];
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
  NSLog(@", ");
  [builder nextArgument];
}

- (void) endMessage
{
  NSLog(@".\n");
  [builder endMessage];
}

- (void) argumentsStart
{
  NSLog(@"(");
  [builder argumentsStart];
}

- (void) argumentsEnd
{
  NSLog(@")");
  [builder argumentsEnd];
}

- (void) identifier:(char*)start length:(int)length
{
  NSString* name = [[NSString alloc] initWithBytes:start length:length encoding:NSUTF8StringEncoding];
  NSLog(@"putting identifier: %@", name);
  [builder identifier:name];
}

- (void) textLiteral:(char*)start length:(int)length
{
  NSString* name = [[NSString alloc] initWithBytes:start+1 length:length-1 encoding:NSUTF8StringEncoding];
  NSLog(@"string: %@", name);
  [builder textLiteral:name];
}

- (void) numberLiteral:(char*)start length:(int)length
{
  NSString* name = [[NSString alloc] initWithBytes:start length:length encoding:NSUTF8StringEncoding];
  NSLog(@"number: %@", name);
  [builder numberLiteral:name];
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
