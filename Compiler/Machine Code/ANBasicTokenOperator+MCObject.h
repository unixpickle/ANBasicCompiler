//
//  ANBasicTokenOperator+MCObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenOperator.h"
#import "ANBasicToken+MCObject.h"

#define ANBasicMCObjectOperatorType 1

typedef enum {
    ANBasicTokenOperatorMachineTypeAddition = 0,
    ANBasicTokenOperatorMachineTypeSubtraction = 1,
    ANBasicTokenOperatorMachineTypeMultiplication = 2,
    ANBasicTokenOperatorMachineTypeDivision = 3,
    ANBasicTokenOperatorMachineTypeExponent = 4,
    ANBasicTokenOperatorMachineTypeLessThan = 5,
    ANBasicTokenOperatorMachineTypeGreaterThan = 6,
    ANBasicTokenOperatorMachineTypeEqualTo = 7,
    ANBasicTokenOperatorMachineTypeLessThanEqualTo = 8,
    ANBasicTokenOperatorMachineTypeGreaterThanEqualTo = 9,
    ANBasicTokenOperatorMachineTypeNotEqualTo = 10,
    ANBasicTokenOperatorMachineTypeAnd = 11,
    ANBasicTokenOperatorMachineTypeOr = 12,
    ANBasicTokenOperatorMachineTypeInvalid = 65536
} ANBasicTokenOperatorMachineType;

@interface ANBasicTokenOperator (MCObject) <ANBasicMCObject>

- (ANBasicTokenOperatorMachineType)operatorType;

@end
