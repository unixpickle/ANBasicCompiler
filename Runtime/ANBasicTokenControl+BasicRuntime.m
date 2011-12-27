//
//  ANBasicTokenControl+BasicRuntime.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenControl+BasicRuntime.h"

@implementation ANBasicTokenControl (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state {
    if ([[self controlName] isEqualToString:@"Break"]) {
        [state setReturnType:ANBasicRuntimeReturnTypeBreak];
    } else if ([[self controlName] isEqualToString:@"Stop"]) {
        [state setReturnType:ANBasicRuntimeReturnTypeStop];
    } else return NO;
    return YES;
}

@end
