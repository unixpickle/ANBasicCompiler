//
//  ANBasicTokenString+BasicRuntime.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenString+BasicRuntime.h"

@implementation ANBasicTokenString (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state {
    [state print:[self string] requireNewLine:YES];
    return YES;
}

@end
