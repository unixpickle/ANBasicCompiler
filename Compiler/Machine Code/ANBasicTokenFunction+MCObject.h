//
//  ANBasicTokenFunction+MCObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenFunction.h"
#import "ANBasicToken+MCObject.h"

#define ANBasicMCObjectFunctionType 6

typedef enum {
    ANBasicTokenFunctionIDSin = 0,
    ANBasicTokenFunctionIDCos = 1,
    ANBasicTokenFunctionIDTan = 2,
    ANBasicTokenFunctionIDArcsin = 3,
    ANBasicTokenFunctionIDArccos = 4,
    ANBasicTokenFunctionIDArctan = 5,
    ANBasicTokenFunctionIDLog = 6,
    ANBasicTokenFunctionIDLn = 7,
    ANBasicTokenFunctionIDSqrt = 8,
    ANBasicTokenFunctionIDAbs = 9,
    ANBasicTokenFunctionIDRanNumber = 10,
    ANBasicTokenFunctionIDInt = 11,
    ANBasicTokenFunctionIDNegate = 12,
    ANBasicTokenFunctionIDInput = 13,
    ANBasicTokenFunctionIDNotFound = 14
} ANBasicTokenFunctionID;

@interface ANBasicTokenFunction (MCObject) <ANBasicMCObject>

+ (ANBasicTokenFunctionID)functionIDForName:(NSString *)functionName;
+ (NSString *)functionNameForID:(ANBasicTokenFunctionID)functionID;

@end
