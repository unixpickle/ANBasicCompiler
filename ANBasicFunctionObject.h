//
//  ANBasicFunctionObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicCodeObject.h"

typedef enum {
    ANBasicFunctionTypeSin = 0,
    ANBasicFunctionTypeCos = 1,
    ANBasicFunctionTypeTan = 2,
    ANBasicFunctionTypeArcsin = 3,
    ANBasicFunctionTypeArccos = 4,
    ANBasicFunctionTypeArctan = 5,
    ANBasicFunctionTypeLog = 6,
    ANBasicFunctionTypeLn = 7,
    ANBasicFunctionTypeSqrt = 8,
    ANBasicFunctionTypeAbs = 9,
    ANBasicFunctionTypeRanNum = 10,
    ANBasicFunctionTypeInt = 11,
    ANBasicFunctionTypeNegate = 12
} ANBasicFunctionType;

@interface ANBasicFunctionObject : ANBasicCodeObject {
    ANBasicFunctionType functionType;
}

@property (readonly) ANBasicFunctionType functionType;

- (id)initWithFunctionName:(NSString *)functionName;
- (id)initWithFunctionType:(ANBasicFunctionType)aType;

@end
