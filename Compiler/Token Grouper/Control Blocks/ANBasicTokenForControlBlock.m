//
//  ANBasicTokenForControlBlock.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenForControlBlock.h"

static BOOL _ForBlockGetRanges (ANBasicTokenBlock * aBlock, NSRange * initialRange, NSRange * destinationRange, NSRange * stepRange);

@implementation ANBasicTokenForControlBlock

@synthesize initialBlock;
@synthesize counterVariable;
@synthesize destinationBlock;
@synthesize stepValue;
@synthesize loopBody;

+ (BOOL)isLineForBlock:(ANBasicTokenBlock *)aBlock {
    return _ForBlockGetRanges(aBlock, nil, nil, nil);
}

- (id)initWithForHeader:(ANBasicTokenBlock *)forHeader {
    if ((self = [super initWithControlType:ANBasicControlTypeForLoop])) {
        NSRange initialRange;
        NSRange destinationRange;
        NSRange stepRange;
        if (!_ForBlockGetRanges(forHeader, &initialRange, &destinationRange, &stepRange)) {
            return nil;
        }
        
        initialBlock = [forHeader blockWithTokensInRange:initialRange];
        destinationBlock = [forHeader blockWithTokensInRange:destinationRange];
        if (stepRange.location != NSNotFound) {
            ANBasicTokenBlock * stepBlock = [forHeader blockWithTokensInRange:stepRange];
            // validate step block
            if ([stepBlock.tokens count] != 1) return nil;
            ANBasicToken * stepToken = [stepBlock.tokens objectAtIndex:0];
            if (![stepToken isKindOfClass:[ANBasicTokenNumber class]]) {
                return nil;
            }
            stepValue = (ANBasicTokenNumber *)stepToken;
        }
        
        // make sure that there is a variable and an assignment operator at the end
        // of the initial for statement
        if ([initialBlock.tokens count] < 3) return nil;
        ANBasicToken * _initialVariable = [initialBlock.tokens lastObject];
        ANBasicToken * _initialAssign = [initialBlock.tokens objectAtIndex:([initialBlock.tokens count] - 2)];
        if (![_initialVariable isKindOfClass:[ANBasicTokenVariable class]]) return nil;
        if (![_initialAssign isKindOfClass:[ANBasicTokenOperator class]]) return nil;
        
        ANBasicTokenOperator * _assignOperator = (ANBasicTokenOperator *)_initialAssign;
        if (![[_assignOperator operatorName] isEqualToString:@"->"]) return nil;
        
        // extract the counter variable, and remove it from the initial statement
        counterVariable = (ANBasicTokenVariable *)_initialVariable;
        [initialBlock.tokens removeLastObject];
        [initialBlock.tokens removeLastObject];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<ANBasicTokenForControlBlock (initial=%@, counter=%@, destination=%@, step=%@, body=%@)>",
            initialBlock, counterVariable, destinationBlock, stepValue, loopBody];
}

@end

static BOOL _ForBlockGetRanges (ANBasicTokenBlock * aBlock, NSRange * initialRange, NSRange * destinationRange, NSRange * stepRange) {
    NSUInteger forIndex = NSNotFound;
    NSUInteger toIndex = NSNotFound;
    NSUInteger stepIndex = NSNotFound;
    
    for (NSUInteger i = 0; i < [aBlock.tokens count]; i++) {
        ANBasicToken * token = [aBlock.tokens objectAtIndex:i];
        if ([token isKindOfClass:[ANBasicTokenControl class]]) {
            ANBasicTokenControl * control = (ANBasicTokenControl *)token;
            if ([[control controlName] isEqualToString:@"For"]) {
                forIndex = i;
            } else if ([[control controlName] isEqualToString:@"To"]) {
                toIndex = i;
            } else if ([[control controlName] isEqualToString:@"Step"]) {
                stepIndex = i;
            }
        }
    }
    
    if (toIndex == NSNotFound || forIndex == NSNotFound) return NO;
    if (forIndex > toIndex || (toIndex > stepIndex && stepIndex != NSNotFound)) return NO;
    
    if (initialRange) *initialRange = NSMakeRange(forIndex + 1, (toIndex - forIndex) - 1);
    if (stepIndex != NSNotFound) {
        if (destinationRange) *destinationRange = NSMakeRange(toIndex + 1, (stepIndex - toIndex) - 1);
        if (stepRange) *stepRange = NSMakeRange(stepIndex + 1, ([aBlock.tokens count] - stepIndex) - 1);
    } else {
        if (destinationRange) *destinationRange = NSMakeRange(toIndex + 1, ([aBlock.tokens count] - toIndex) - 1);
        if (stepRange) *stepRange = NSMakeRange(NSNotFound, NSNotFound);
    }
    
    return YES;
}
