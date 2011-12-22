//
//  ANBasicOperatorHeader.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicCodeObject.h"

typedef enum {
    ANBasicOperatorTypeAdd = 0,
    ANBasicOperatorTypeSubtract = 1,
    ANBasicOperatorTypeMultiply = 2,
    ANBasicOperatorTypeDivide = 3,
    ANBasicOperatorTypePower = 4,
    ANBasicOperatorTypeLessThanEqualTo = 5,
    ANBasicOperatorTypeGreaterThanEqualTo = 6,
    ANBasicOperatorTypeLessThan = 7,
    ANBasicOperatorTypeGreaterThan = 8,
    ANBasicOperatorTypeEqualTo = 9,
    ANBasicOperatorTypeNotEqualTo = 10
} ANBasicOperatorType;

@interface ANBasicOperatorObject : ANBasicCodeObject {
    ANBasicOperatorType operatorType;
}

@property (readonly) ANBasicOperatorType operatorType;

- (id)initWithOperatorString:(NSString *)opString;
- (id)initWithOperatorType:(ANBasicOperatorType)aType;

@end
