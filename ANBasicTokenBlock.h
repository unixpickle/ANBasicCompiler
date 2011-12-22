//
//  ANBasicTokenBlock.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

@interface ANBasicTokenBlock : ANBasicToken {
    NSMutableArray * tokens;
    BOOL printOutput;
}

@property (readonly) NSMutableArray * tokens;
@property (readwrite) BOOL printOutput;

- (id)initWithTokens:(NSArray *)someTokens;
- (ANBasicToken *)firstToken;
- (void)removeFirstToken;

@end
