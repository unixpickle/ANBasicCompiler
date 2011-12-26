//
//  ANBasicTokenWhileControlBlock.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenWhileControlBlock.h"

@implementation ANBasicTokenWhileControlBlock

@synthesize condition;
@synthesize loopBody;

- (id)init {
    if ((self = [super initWithControlType:ANBasicControlTypeWhileLoop])) {
    }
    return self;
}

+ (BOOL)isLineWhileBlock:(ANBasicTokenBlock *)codeLine {
    if ([codeLine.tokens count] == 0) return NO;
    ANBasicToken * firstToken = [codeLine firstToken];
    if (![firstToken isKindOfClass:[ANBasicTokenControl class]]) {
        return NO;
    }
    ANBasicTokenControl * control = (ANBasicTokenControl *)firstToken;
    return [[control controlName] isEqualToString:@"While"];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<ANBasicTokenWhileControlBlock (condition=%@, body=%@)>",
            condition, loopBody];
}

@end
