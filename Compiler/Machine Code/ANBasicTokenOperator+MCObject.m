//
//  ANBasicTokenOperator+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenOperator+MCObject.h"

const struct {
    __unsafe_unretained NSString * operatorName;
    ANBasicTokenOperatorMachineType machineType;
} _operators[] = {
    {@"+", ANBasicTokenOperatorMachineTypeAddition},
    {@"-", ANBasicTokenOperatorMachineTypeSubtraction},
    {@"*", ANBasicTokenOperatorMachineTypeMultiplication},
    {@"/", ANBasicTokenOperatorMachineTypeDivision},
    {@"^", ANBasicTokenOperatorMachineTypeExponent},
    {@"<", ANBasicTokenOperatorMachineTypeLessThan},
    {@">", ANBasicTokenOperatorMachineTypeGreaterThan},
    {@"=", ANBasicTokenOperatorMachineTypeEqualTo},
    {@"<=", ANBasicTokenOperatorMachineTypeLessThanEqualTo},
    {@">=", ANBasicTokenOperatorMachineTypeGreaterThanEqualTo},
    {@"!=", ANBasicTokenOperatorMachineTypeNotEqualTo},
    {@"And", ANBasicTokenOperatorMachineTypeAnd},
    {@"Or", ANBasicTokenOperatorMachineTypeOr}
};

@implementation ANBasicTokenOperator (MCObject)

- (ANBasicTokenOperatorMachineType)operatorType {
    for (int i = 0; i < 13; i++) {
        if ([_operators[i].operatorName isEqualToString:[self operatorName]]) {
            return _operators[i].machineType;
        }
    }
    return ANBasicTokenOperatorMachineTypeInvalid;
}

- (UInt8)machineCodeType {
    return ANBasicMCObjectOperatorType;
}

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    ANBasicTokenOperatorMachineType machineType = [self operatorType];
    if (machineType == ANBasicTokenOperatorMachineTypeInvalid) return NO;
    [super encodeToBuffer:buffer];
    [buffer writeByte:machineType];
    return YES;
}

+ (id<ANBasicMCObject>)decodeFromBuffer:(ANBasicByteBuffer *)buffer type:(UInt8)readType {
    UInt8 operatorType = [buffer readByte];
    for (int i = 0; i < 13; i++) {
        if (_operators[i].machineType == operatorType) {
            return [[ANBasicTokenOperator alloc] initWithOperatorName:_operators[i].operatorName];
        }
    }
    return nil;
}

@end
