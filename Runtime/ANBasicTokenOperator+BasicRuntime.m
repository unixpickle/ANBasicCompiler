//
//  ANBasicTokenOperator+BasicRuntime.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenOperator+BasicRuntime.h"

static double _anbr_operator_add (double val1, double val2);
static double _anbr_operator_mul (double val1, double val2);
static double _anbr_operator_sub (double val1, double val2);
static double _anbr_operator_div (double val1, double val2);
static double _anbr_operator_pow (double val1, double val2);
static double _anbr_operator_and (double val1, double val2);
static double _anbr_operator_or (double val1, double val2);
static double _anbr_operator_equal (double val1, double val2);
static double _anbr_operator_less (double val1, double val2);
static double _anbr_operator_greater (double val1, double val2);
static double _anbr_operator_lessequal (double val1, double val2);
static double _anbr_operator_greaterequal (double val1, double val2);
static double _anbr_operator_notequal (double val1, double val2);

@implementation ANBasicTokenOperator (BasicRuntime)

- (BOOL)executeOperator:(double)leftValue state:(ANBasicRuntimeState *)state {
    const struct {
        __unsafe_unretained NSString * operatorName;
        double (*function)(double val1, double val2);
    } operators[] = {
        {@"+", _anbr_operator_add},
        {@"*", _anbr_operator_mul},
        {@"-", _anbr_operator_sub},
        {@"/", _anbr_operator_div},
        {@"^", _anbr_operator_pow},
        {@"And", _anbr_operator_and},
        {@"Or", _anbr_operator_or},
        {@"=", _anbr_operator_equal},
        {@"<", _anbr_operator_less},
        {@">", _anbr_operator_greater},
        {@"<=", _anbr_operator_lessequal},
        {@">=", _anbr_operator_greaterequal},
        {@"!=", _anbr_operator_notequal},
        {nil, NULL}
    };
    double (*theFunction)(double val1, double val2);
    for (int i = 0; operators[i].function != NULL; i++) {
        if ([operators[i].operatorName isEqualToString:self.operatorName]) {
            theFunction = operators[i].function;
            break;
        }
    }
    if (!theFunction) return NO;
    [state returnNumeric:theFunction(leftValue, [state returnNumber])];
    return YES;
}

@end

static double _anbr_operator_add (double val1, double val2) {
    return val1+val2;
}

static double _anbr_operator_mul (double val1, double val2) {
    return val1*val2;
}

static double _anbr_operator_sub (double val1, double val2) {
    return val1 - val2;
}

static double _anbr_operator_div (double val1, double val2) {
    return val1 / val2;
}

static double _anbr_operator_pow (double val1, double val2) {
    return pow(val1, val2);
}

static double _anbr_operator_and (double val1, double val2) {
    return ((val1 != 0) && (val2 != 0));
}

static double _anbr_operator_or (double val1, double val2) {
    return ((val1 != 0) || (val2 != 0));
}

static double _anbr_operator_equal (double val1, double val2) {
    return (val1 == val2);
}

static double _anbr_operator_less (double val1, double val2) {
    return (val1 < val2);
}

static double _anbr_operator_greater (double val1, double val2) {
    return (val1 > val2);
}

static double _anbr_operator_lessequal (double val1, double val2) {
    return (val1 <= val2);
}

static double _anbr_operator_greaterequal (double val1, double val2) {
    return (val1 >= val2);
}

static double _anbr_operator_notequal (double val1, double val2) {
    return (val1 != val2);
}
