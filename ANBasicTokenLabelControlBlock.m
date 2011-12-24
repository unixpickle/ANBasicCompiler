//
//  ANBasicTokenLabelControlBlock.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenLabelControlBlock.h"

@implementation ANBasicTokenLabelControlBlock

@synthesize labelNumber;

+ (BOOL)isLineLabelBlock:(ANBasicTokenBlock *)aBlock {
    if ([aBlock.tokens count] != 2) return NO;
    ANBasicToken * firstToken = [aBlock firstToken];
    if (![firstToken isKindOfClass:[ANBasicTokenControl class]]) return NO;
    ANBasicTokenControl * control = (ANBasicTokenControl *)firstToken;
    
    return [[control controlName] isEqualToString:@"Lbl"];
}

- (id)initWithLabelBlock:(ANBasicTokenBlock *)aBlock {
    if ((self = [super initWithControlType:ANBasicControlTypeLabel])) {        
        if (![[self class] isLineLabelBlock:aBlock]) return nil;
        
        ANBasicToken * numberToken = [aBlock.tokens objectAtIndex:1];
        if (![numberToken isKindOfClass:[ANBasicTokenNumber class]]) return nil;
        labelNumber = (ANBasicTokenNumber *)numberToken;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<ANBasicTokenLabelControlBlock (label=%@)>", labelNumber];
}

@end
