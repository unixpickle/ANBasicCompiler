//
//  ANBasicTokenVariable+BasicRuntime.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenVariable+BasicRuntime.h"

@implementation ANBasicTokenVariable (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state {
    if (self.isAssignment) {
        [state setValue:[state returnNumber] forVariableName:self.variableName];
    } else {
        double theNumber = [state valueForVariableName:self.variableName];
        [state setReturnNumber:theNumber];
    }
    return YES;
}

@end
