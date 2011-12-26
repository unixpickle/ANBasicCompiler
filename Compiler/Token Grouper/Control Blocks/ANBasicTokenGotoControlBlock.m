//
//  ANBasicTokenGotoControlBlock.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenGotoControlBlock.h"

@implementation ANBasicTokenGotoControlBlock

@synthesize jumpLocation;

+ (BOOL)isLineGotoBlock:(ANBasicTokenBlock *)aBlock {
    if ([aBlock.tokens count] < 2) return NO;
    ANBasicToken * firstToken = [aBlock firstToken];
    if (![firstToken isKindOfClass:[ANBasicTokenControl class]]) return NO;
    ANBasicTokenControl * control = (ANBasicTokenControl *)firstToken;
    
    return [[control controlName] isEqualToString:@"Goto"];
}

- (id)init {
    if ((self = [super initWithControlType:ANBasicControlTypeGoto])) {
    }
    return self;
}

- (id)initWithGotoBlock:(ANBasicTokenBlock *)aBlock {
    if ((self = [super initWithControlType:ANBasicControlTypeGoto])) {        
        if (![[self class] isLineGotoBlock:aBlock]) return nil;
        
        jumpLocation = [aBlock blockWithTokensInRange:NSMakeRange(1, [aBlock.tokens count] - 1)];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<ANBasicTokenGotoControlBlock (jump=%@)>", jumpLocation];
}

@end
