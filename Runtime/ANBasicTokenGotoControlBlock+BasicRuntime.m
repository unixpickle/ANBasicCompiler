//
//  ANBasicTokenGotoControlBlock+BasicRuntime.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenGotoControlBlock+BasicRuntime.h"

@implementation ANBasicTokenGotoControlBlock (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state {
    if (![jumpLocation executeToken:state]) return NO;
    if ([state returnType] != ANBasicRuntimeReturnTypeValue) return NO;
    [state setReturnType:ANBasicRuntimeReturnTypeGoto];
    [state setGotoLineNumber:(int)[state returnNumber]];
    return YES;
}

@end
