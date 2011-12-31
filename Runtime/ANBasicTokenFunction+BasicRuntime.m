//
//  ANBasicTokenFunction+BasicRuntime.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenFunction+BasicRuntime.h"

static double _func_get_input (ANBasicRuntimeState * state, double input);
const struct {
    double (*funcMethod)(ANBasicRuntimeState * state, double input);
    __unsafe_unretained NSString * funcName;
} _functions[] = {
    {_func_get_input, @"?"},
    {NULL, nil}
};

@implementation ANBasicTokenFunction (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state {
    double inputValue = 0;
    if (self.groupedToken) {
        if (![self.groupedToken executeToken:state]) return NO;
        if ([state returnType] != ANBasicRuntimeReturnTypeValue) return NO;
        inputValue = [state returnNumber];
    }
    
    for (int i = 0; _functions[i].funcMethod != NULL; i++) {
        if ([_functions[i].funcName isEqualToString:self.functionName]) {
            double retVal = _functions[i].funcMethod(state, inputValue);
            [state returnNumeric:retVal];
            return YES;
        }
    }
    
    return NO;
}

static double _func_get_input (ANBasicRuntimeState * state, double input) {
    NSString * userInput = [state promptInput];
    return [userInput doubleValue];
}

@end
