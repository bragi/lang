
#line 1 "LangScanner.rl"

#line 49 "LangScanner.rl"


//
//  LangScanner.m
//  lang-grammar
//
//  Created by Łukasz Piestrzeniewicz on 09-09-02.
//  Copyright 2009 Ragnarson. All rights reserved.
//
#import "LangScanner.h"


#line 18 "LangScanner.m"
static const char _Lang_actions[] = {
	0, 1, 2, 1, 6, 1, 7, 1, 
	8, 1, 9, 1, 10, 1, 11, 1, 
	12, 1, 13, 1, 14, 1, 15, 1, 
	16, 1, 17, 2, 0, 1, 2, 3, 
	4, 2, 3, 5
};

static const char _Lang_key_offsets[] = {
	0, 0, 4, 5, 7, 7, 26, 30, 
	35, 37, 39, 40
};

static const char _Lang_trans_keys[] = {
	10, 32, 41, 44, 10, 34, 92, 10, 
	32, 34, 40, 41, 44, 46, 58, 61, 
	92, 95, 43, 45, 48, 57, 65, 90, 
	97, 122, 10, 32, 41, 44, 10, 32, 
	41, 44, 92, 32, 92, 48, 57, 61, 
	95, 48, 57, 65, 90, 97, 122, 0
};

static const char _Lang_single_lengths[] = {
	0, 4, 1, 2, 0, 11, 4, 5, 
	2, 0, 1, 1
};

static const char _Lang_range_lengths[] = {
	0, 0, 0, 0, 0, 4, 0, 0, 
	0, 1, 0, 3
};

static const char _Lang_index_offsets[] = {
	0, 0, 5, 7, 10, 11, 27, 32, 
	38, 41, 43, 45
};

static const char _Lang_indicies[] = {
	1, 1, 2, 3, 0, 4, 0, 6, 
	7, 5, 5, 8, 10, 5, 11, 2, 
	3, 13, 12, 15, 17, 16, 12, 14, 
	16, 16, 9, 1, 1, 2, 3, 18, 
	1, 10, 2, 3, 17, 19, 4, 17, 
	19, 14, 20, 12, 21, 16, 16, 16, 
	16, 22, 0
};

static const char _Lang_trans_targs[] = {
	5, 1, 5, 5, 8, 3, 5, 4, 
	6, 0, 7, 5, 5, 5, 9, 10, 
	11, 2, 5, 5, 5, 5, 5
};

static const char _Lang_trans_actions[] = {
	25, 0, 9, 11, 30, 0, 5, 0, 
	33, 0, 30, 7, 3, 13, 0, 0, 
	0, 0, 23, 21, 19, 17, 15
};

static const char _Lang_to_state_actions[] = {
	0, 0, 0, 0, 0, 27, 0, 0, 
	0, 0, 0, 0
};

static const char _Lang_from_state_actions[] = {
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0
};

static const char _Lang_eof_trans[] = {
	0, 1, 1, 0, 0, 0, 19, 20, 
	20, 21, 22, 23
};

static const int Lang_start = 5;
static const int Lang_error = 0;

static const int Lang_en_main = 5;


#line 61 "LangScanner.rl"

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
  NSLog(@"Scan: , ");
  [builder nextArgument];
}

- (void) endMessage
{
  NSLog(@"Scan: .\n");
  [builder endMessage];
}

- (void) argumentsStart
{
  NSLog(@"Scan: (");
  [builder argumentsStart];
}

- (void) argumentsEnd
{
  NSLog(@"Scan: )");
  [builder argumentsEnd];
}

- (void) identifier:(char*)start length:(int)length
{
  NSString* name = [[NSString alloc] initWithBytes:start length:length encoding:NSUTF8StringEncoding];
  NSLog(@"Scan: identifier '%@'", name);
  [builder identifier:name];
}

- (void) textLiteral:(char*)start length:(int)length
{
  NSString* name = [[NSString alloc] initWithBytes:start+1 length:length-1 encoding:NSUTF8StringEncoding];
  NSLog(@"Scan: string '%@'", name);
  [builder textLiteral:name];
}

- (void) numberLiteral:(char*)start length:(int)length
{
  NSString* name = [[NSString alloc] initWithBytes:start length:length encoding:NSUTF8StringEncoding];
  NSLog(@"Scan: number %@", name);
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

    
#line 176 "LangScanner.m"
	{
	cs = Lang_start;
	ts = 0;
	te = 0;
	act = 0;
	}

#line 137 "LangScanner.rl"
    
#line 186 "LangScanner.m"
	{
	int _klen;
	unsigned int _trans;
	const char *_acts;
	unsigned int _nacts;
	const char *_keys;

	if ( p == pe )
		goto _test_eof;
	if ( cs == 0 )
		goto _out;
_resume:
	_acts = _Lang_actions + _Lang_from_state_actions[cs];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 ) {
		switch ( *_acts++ ) {
	case 2:
#line 1 "LangScanner.rl"
	{ts = p;}
	break;
#line 207 "LangScanner.m"
		}
	}

	_keys = _Lang_trans_keys + _Lang_key_offsets[cs];
	_trans = _Lang_index_offsets[cs];

	_klen = _Lang_single_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + _klen - 1;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + ((_upper-_lower) >> 1);
			if ( (*p) < *_mid )
				_upper = _mid - 1;
			else if ( (*p) > *_mid )
				_lower = _mid + 1;
			else {
				_trans += (_mid - _keys);
				goto _match;
			}
		}
		_keys += _klen;
		_trans += _klen;
	}

	_klen = _Lang_range_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + (_klen<<1) - 2;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + (((_upper-_lower) >> 1) & ~1);
			if ( (*p) < _mid[0] )
				_upper = _mid - 2;
			else if ( (*p) > _mid[1] )
				_lower = _mid + 2;
			else {
				_trans += ((_mid - _keys)>>1);
				goto _match;
			}
		}
		_trans += _klen;
	}

_match:
	_trans = _Lang_indicies[_trans];
_eof_trans:
	cs = _Lang_trans_targs[_trans];

	if ( _Lang_trans_actions[_trans] == 0 )
		goto _again;

	_acts = _Lang_actions + _Lang_trans_actions[_trans];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 )
	{
		switch ( *_acts++ )
		{
	case 3:
#line 1 "LangScanner.rl"
	{te = p+1;}
	break;
	case 4:
#line 30 "LangScanner.rl"
	{act = 5;}
	break;
	case 5:
#line 44 "LangScanner.rl"
	{act = 9;}
	break;
	case 6:
#line 18 "LangScanner.rl"
	{te = p+1;{
      [self identifier:ts length:te-ts];
    }}
	break;
	case 7:
#line 22 "LangScanner.rl"
	{te = p+1;{
      [self textLiteral:ts length:te-ts-1];
    }}
	break;
	case 8:
#line 32 "LangScanner.rl"
	{te = p+1;{
      [self argumentsStart];
    }}
	break;
	case 9:
#line 36 "LangScanner.rl"
	{te = p+1;{
      [self argumentsEnd];
    }}
	break;
	case 10:
#line 40 "LangScanner.rl"
	{te = p+1;{
      [self nextArgument];
    }}
	break;
	case 11:
#line 44 "LangScanner.rl"
	{te = p+1;{
      [self endMessage];
    }}
	break;
	case 12:
#line 14 "LangScanner.rl"
	{te = p;p--;{
      [self identifier:ts length:te-ts];
    }}
	break;
	case 13:
#line 18 "LangScanner.rl"
	{te = p;p--;{
      [self identifier:ts length:te-ts];
    }}
	break;
	case 14:
#line 26 "LangScanner.rl"
	{te = p;p--;{
      [self numberLiteral:ts length:te-ts];
    }}
	break;
	case 15:
#line 30 "LangScanner.rl"
	{te = p;p--;}
	break;
	case 16:
#line 44 "LangScanner.rl"
	{te = p;p--;{
      [self endMessage];
    }}
	break;
	case 17:
#line 1 "LangScanner.rl"
	{	switch( act ) {
	case 0:
	{{cs = 0; goto _again;}}
	break;
	case 9:
	{{p = ((te))-1;}
      [self endMessage];
    }
	break;
	default:
	{{p = ((te))-1;}}
	break;
	}
	}
	break;
#line 366 "LangScanner.m"
		}
	}

_again:
	_acts = _Lang_actions + _Lang_to_state_actions[cs];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 ) {
		switch ( *_acts++ ) {
	case 0:
#line 1 "LangScanner.rl"
	{ts = 0;}
	break;
	case 1:
#line 1 "LangScanner.rl"
	{act = 0;}
	break;
#line 383 "LangScanner.m"
		}
	}

	if ( cs == 0 )
		goto _out;
	if ( ++p != pe )
		goto _resume;
	_test_eof: {}
	if ( p == eof )
	{
	if ( _Lang_eof_trans[cs] > 0 ) {
		_trans = _Lang_eof_trans[cs] - 1;
		goto _eof_trans;
	}
	}

	_out: {}
	}

#line 138 "LangScanner.rl"
}
@end
