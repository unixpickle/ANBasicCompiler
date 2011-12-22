//
//  ANBasicTokenizedScript.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenizedScript.h"

@implementation ANBasicTokenizedScript

@synthesize tokens;

- (id)initWithScript:(NSString *)scriptBody {
    if ((self = [super init])) {
        NSMutableArray * _mutableTokens = [[NSMutableArray alloc] init];
        ANBasicToken * token = nil;
        ANBasicTokenizer * tokenizer = [[ANBasicTokenizer alloc] initWithString:scriptBody offset:0];
        
        BOOL wasLastNewLine = NO;
        while ((token = [tokenizer readNextToken]) != nil) {
            BOOL isNewLine = NO;
            if ([token isKindOfClass:[ANBasicTokenControl class]]) {
                if ([(ANBasicTokenControl *)token isNewBlockControl]) {
                    isNewLine = YES;
                }
            }
            
            // prevent excessive ;\n sequences
            if (!(isNewLine && wasLastNewLine)) [_mutableTokens addObject:token];
            wasLastNewLine = isNewLine;
        }
        tokens = [NSArray arrayWithArray:_mutableTokens];
    }
    return self;
}

@end
