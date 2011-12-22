//
//  ANBasicFunctionObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicFunctionObject.h"

@implementation ANBasicFunctionObject

@synthesize functionType;

- (id)initWithFunctionName:(NSString *)functionName {
    struct {
        __unsafe_unretained NSString * functionName;
        ANBasicFunctionType functionType;
    } functionToString[] = {
        {@"sin", ANBasicFunctionTypeSin},
        {@"cos", ANBasicFunctionTypeCos},
        {@"tan", ANBasicFunctionTypeTan},
        {@"arcsin", ANBasicFunctionTypeArcsin},
        {@"arccos", ANBasicFunctionTypeArccos},
        {@"arctan", ANBasicFunctionTypeArctan},
        {@"log", ANBasicFunctionTypeLog},
        {@"ln", ANBasicFunctionTypeLn},
        {@"sqrt", ANBasicFunctionTypeSqrt},
        {@"Abs", ANBasicFunctionTypeAbs},
        {@"Ran#", ANBasicFunctionTypeRanNum},
        {@"Int", ANBasicFunctionTypeInt},
        {@"-", ANBasicFunctionTypeNegate}
    };
    for (NSUInteger i = 0; i < (sizeof(functionToString) / sizeof(NSString *)); i++) {
        if ([functionToString[i].functionName isEqualToString:functionName]) {
            self = [self initWithFunctionType:functionToString[i].functionType];
            return self;
        }
    }
    return nil;
}

- (id)initWithFunctionType:(ANBasicFunctionType)aType {
    if ((self = [super init])) {
        [self setObjectType:ANBasicCodeObjectTypeFunction];
        functionType = aType;
        [self setAdditionalInfo:functionType];
    }
    return self;
}

@end
