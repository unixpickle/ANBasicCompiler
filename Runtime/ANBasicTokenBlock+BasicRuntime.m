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
    for (NSUInteger i = 0; i < [self.tokens count]; i++) {
        ANBasicToken * token = [self.tokens objectAtIndex:i];
        if (![token executeToken:state]) {
            return NO;
        }
        if ([state returnType] != ANBasicRuntimeReturnTypeValue) return NO;
    }
    if ([self printOutput]) {
        NSString * result = [NSString stringWithFormat:@"%0.0f", [state returnNumber]];
        [state print:result requireNewLine:YES];
        [state promptMore];
    }
    return YES;
}

@end
