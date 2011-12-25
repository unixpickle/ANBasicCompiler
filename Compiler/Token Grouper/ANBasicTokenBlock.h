//
//  ANBasicTokenBlock.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

/**
 * This is a concrete ANBasicToken subclass that represents a block containing
 * zero or more tokens. Tokens of this type will only exist after grouping, in most cases
 * because of parentheses, or numerical operations that must be grouped in order to support
 * the order of operations.
 *
 * Each lexically separated part of the script (line breaks or : tokens) will be in its own
 * ANBasicTokenBlock. This means that each line of the script will be contained in its own
 * ANBasicTokenBlock object.
 */
@interface ANBasicTokenBlock : ANBasicToken {
    NSMutableArray * tokens;
    BOOL printOutput;
}

@property (readonly) NSMutableArray * tokens;
@property (readwrite) BOOL printOutput;

- (id)initWithTokens:(NSArray *)someTokens;

- (ANBasicToken *)firstToken;
- (void)removeFirstToken;

- (ANBasicTokenBlock *)blockWithTokensInRange:(NSRange)aRange;

@end
