//
//  ANBasicOperatorHeader.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicOperatorObject.h"

@implementation ANBasicOperatorObject

@synthesize operatorType;

- (id)initWithOperatorString:(NSString *)opString {
    struct {
        __unsafe_unretained NSString * anOpString;
        ANBasicOperatorType opType;
    } operatorToString[] = {
        {@"+", ANBasicOperatorTypeAdd},
        {@"-", ANBasicOperatorTypeSubtract},
        {@"*", ANBasicOperatorTypeMultiply},
        {@"/", ANBasicOperatorTypeDivide},
        {@"<", ANBasicOperatorTypeLessThan},
        {@">", ANBasicOperatorTypeGreaterThan},
        {@"<=", ANBasicOperatorTypeLessThanEqualTo},
        {@">=", ANBasicOperatorTypeGreaterThanEqualTo},
        {@"=", ANBasicOperatorTypeEqualTo},
        {@"!=", ANBasicOperatorTypeNotEqualTo},
        {@"^", ANBasicOperatorTypePower}
    };
    for (NSUInteger i = 0; i < (sizeof(operatorToString) / sizeof(NSString *)); i++) {
        if ([operatorToString[i].anOpString isEqualToString:opString]) {
            self = [self initWithOperatorType:operatorToString[i].opType];
            return self;
        }
    }
    return nil;
}

- (id)initWithOperatorType:(ANBasicOperatorType)aType {
    if ((self = [super init])) {
        [self setObjectType:ANBasicCodeObjectTypeOperator];
        operatorType = aType;
        [self setAdditionalInfo:operatorType];
    }
    return self;
}

@end
