//
//  ANBasicTokenFunction+BasicRuntime.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenFunction+BasicRuntime.h"

static double _func_get_input (ANBasicRuntimeState * state, double input);
static double _func_sin (ANBasicRuntimeState * state, double input);
static double _func_cos (ANBasicRuntimeState * state, double input);
static double _func_tan (ANBasicRuntimeState * state, double input);
static double _func_arcsin (ANBasicRuntimeState * state, double input);
static double _func_arccos (ANBasicRuntimeState * state, double input);
static double _func_arctan (ANBasicRuntimeState * state, double input);
static double _func_log (ANBasicRuntimeState * state, double input);
static double _func_ln (ANBasicRuntimeState * state, double input);
static double _func_sqrt (ANBasicRuntimeState * state, double input);
static double _func_abs (ANBasicRuntimeState * state, double input);
static double _func_rannum (ANBasicRuntimeState * state, double input);
static double _func_int (ANBasicRuntimeState * state, double input);
static double _func_negate (ANBasicRuntimeState * state, double input);

const struct {
    double (*funcMethod)(ANBasicRuntimeState * state, double input);
    __unsafe_unretained NSString * funcName;
} _functions[] = {
    {_func_get_input, @"?"},
    {_func_sin, @"sin"},
    {_func_cos, @"cos"},
    {_func_tan, @"tan"},
    {_func_arcsin, @"arcsin"},
    {_func_arccos, @"arccos"},
    {_func_arctan, @"arctan"},
    {_func_log, @"log"},
    {_func_ln, @"ln"},
    {_func_sqrt, @"sqrt"},
    {_func_abs, @"Abs"},
    {_func_rannum, @"Ran#"},
    {_func_int, @"Int"},
    {_func_negate, @"-"},
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

@end

static double _func_get_input (ANBasicRuntimeState * state, double input) {
    NSString * userInput = [state promptInput];
    return [userInput doubleValue];
}

static double _func_sin (ANBasicRuntimeState * state, double input) {
    return sin(input);
}

static double _func_cos (ANBasicRuntimeState * state, double input) {
    return cos(input);
}

static double _func_tan (ANBasicRuntimeState * state, double input) {
    return tan(input);
}

static double _func_arcsin (ANBasicRuntimeState * state, double input) {
    return asin(input);
}

static double _func_arccos (ANBasicRuntimeState * state, double input) {
    return acos(input);
}

static double _func_arctan (ANBasicRuntimeState * state, double input) {
    return atan(input);
}

static double _func_log (ANBasicRuntimeState * state, double input) {
    return log10(input);
}

static double _func_ln (ANBasicRuntimeState * state, double input) {
    return log(input);
}

static double _func_sqrt (ANBasicRuntimeState * state, double input) {
    return sqrt(input);
}

static double _func_abs (ANBasicRuntimeState * state, double input) {
    return (input < 0 ? -input : input);
}

static double _func_rannum (ANBasicRuntimeState * state, double input) {
    return (double)(arc4random() % 100000) / 100000.0f;
}

static double _func_int (ANBasicRuntimeState * state, double input) {
    return floor(input);
}

static double _func_negate (ANBasicRuntimeState * state, double input) {
    return -input;
}
