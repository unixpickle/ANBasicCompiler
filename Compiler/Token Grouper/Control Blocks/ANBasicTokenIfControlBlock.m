//
//  ANBasicTokenIfControlBlock.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenIfControlBlock.h"

@implementation ANBasicTokenIfControlBlock

@synthesize condition;
@synthesize mainBody, elseBody;

- (id)init {
    if ((self = [super initWithControlType:ANBasicControlTypeIfStatement])) {
    }
    return self;
}

+ (BOOL)isLineIfStatement:(ANBasicTokenBlock *)lineBlock {
    if ([[lineBlock tokens] count] == 0) {
        return NO;
    }
    ANBasicToken * firstToken = [lineBlock.tokens objectAtIndex:0];
    if ([firstToken isKindOfClass:[ANBasicTokenControl class]]) {
        ANBasicTokenControl * control = (ANBasicTokenControl *)firstToken;
        if ([[control controlName] isEqualToString:@"If"]) return YES;
    }
    return NO;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<ANBasicTokenIfControlBlock (condition=%@, body=%@, else=%@)>",
            condition, mainBody, elseBody];
}

@end
