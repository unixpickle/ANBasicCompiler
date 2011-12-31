//
//  ANBasicTokenIfControlBlock+BasicRuntime.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenIfControlBlock+BasicRuntime.h"

@implementation ANBasicTokenIfControlBlock (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state {
    if (![self.condition executeToken:state]) {
        return NO;
    }
    
    if ([state returnType] != ANBasicRuntimeReturnTypeValue) return NO;
    
    if ([state returnNumber] == 1) {
        return [self.mainBody executeToken:state];
    } else if (self.elseBody) {
        return [self.elseBody executeToken:state];
    }
    
    return YES;
}

@end
