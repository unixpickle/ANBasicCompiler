//
//  ANBasicTokenWhileControlBlock+BasicRuntime.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenWhileControlBlock+BasicRuntime.h"

@implementation ANBasicTokenWhileControlBlock (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state {
    [state resetReturnState];
    
    do {
        if (![self.condition executeToken:state]) return NO;
        if ([state returnType] != ANBasicRuntimeReturnTypeValue) return NO;
        if ([state returnNumber] != 1) return YES;
        if (![self.loopBody executeToken:state]) return NO;
    } while ([state returnType] == ANBasicRuntimeReturnTypeValue);
    
    if ([state returnType] == ANBasicRuntimeReturnTypeBreak) {
        // they have successfully broken from a loop!
        [state resetReturnState];
    }
    
    return YES;
}

@end
