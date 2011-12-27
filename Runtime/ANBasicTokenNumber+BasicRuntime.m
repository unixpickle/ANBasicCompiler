//
//  ANBasicTokenNumber+BasicRuntime.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenNumber+BasicRuntime.h"

@implementation ANBasicTokenNumber (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state {
    [state setReturnNumber:[self.numberValue doubleValue]];
    return YES;
}

@end
