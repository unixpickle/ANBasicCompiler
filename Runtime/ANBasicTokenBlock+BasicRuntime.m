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
        
        switch ([state returnType]) {
            case ANBasicRuntimeReturnTypeValue:
                break;
            case ANBasicRuntimeReturnTypeGoto:
            {
                // goto line number, or return to next block
                NSInteger lineIndex = [self indexOfLabel:[state gotoLineNumber]];
                if (lineIndex < 0) return YES;
                i = lineIndex;
                [state resetReturnState];
                break;
            }
            case ANBasicRuntimeReturnTypeBreak:
                return YES;
                break;
            case ANBasicRuntimeReturnTypeStop:
                return YES;
                break;
            default:
                return NO;
        }
        
        // if this is the second argument of an operator, we must now
        // evaluate that operator
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

- (NSInteger)indexOfLabel:(int)_label {
    for (NSUInteger i = 0; i < [tokens count]; i++) {
        ANBasicToken * token = [tokens objectAtIndex:i];
        if ([token isKindOfClass:[ANBasicTokenLabelControlBlock class]]) {
            ANBasicTokenLabelControlBlock * label = (ANBasicTokenLabelControlBlock *)token;
            if ([[[label labelNumber] numberValue] intValue] == _label) return (NSInteger)i;
        }
    }
    return -1;
}

@end
