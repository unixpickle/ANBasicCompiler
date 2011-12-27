//
//  ANBasicTokenBlock+BasicRuntime.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenBlock+BasicRuntime.h"

@implementation ANBasicTokenBlock (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state {
    ANBasicTokenOperator * lastOperator = nil;
    for (NSUInteger i = 0; i < [self.tokens count]; i++) {
        ANBasicToken * token = [self.tokens objectAtIndex:i];
        if ([token isKindOfClass:[ANBasicTokenOperator class]]) {
            lastOperator = (ANBasicTokenOperator *)token;
            continue;
        }
        
        double previousValue = [state returnNumber];
        if (![token executeToken:state]) {
            return NO;
        }
        if ([state returnType] != ANBasicRuntimeReturnTypeValue) return NO;
        
        if (lastOperator) {
            [lastOperator executeOperator:previousValue state:state];
            lastOperator = nil;
        }
    }
    if ([self printOutput]) {
        NSString * result = [NSString stringWithFormat:@"%0.0f", [state returnNumber]];
        [state print:result requireNewLine:YES];
        [state promptMore];
    }
    return YES;
}

@end
