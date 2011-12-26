//
//  ANBasicTokenFunction+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenFunction+MCObject.h"

const struct {
    __unsafe_unretained NSString * functionName;
    __unsafe_unretained ANBasicTokenFunctionID functionID;
} functionNames[] = {
    {@"sin", ANBasicTokenFunctionIDSin},
    {@"cos", ANBasicTokenFunctionIDCos},
    {@"tan", ANBasicTokenFunctionIDTan},
    {@"arcsin", ANBasicTokenFunctionIDArcsin},
    {@"arccos", ANBasicTokenFunctionIDArccos},
    {@"arctan", ANBasicTokenFunctionIDArctan},
    {@"log", ANBasicTokenFunctionIDLog},
    {@"ln", ANBasicTokenFunctionIDLn},
    {@"sqrt", ANBasicTokenFunctionIDSqrt},
    {@"Abs", ANBasicTokenFunctionIDAbs},
    {@"Ran#", ANBasicTokenFunctionIDRanNumber},
    {@"Int", ANBasicTokenFunctionIDInt},
    {@"-", ANBasicTokenFunctionIDNegate},
    {@"?", ANBasicTokenFunctionIDInput},
    {nil, 0}
};

@implementation ANBasicTokenFunction (MCObject)

+ (ANBasicTokenFunctionID)functionIDForName:(NSString *)functionName {
    for (int i = 0; functionNames[i].functionName != nil; i++) {
        if ([functionNames[i].functionName isEqualToString:functionName]) {
            return functionNames[i].functionID;
        }
    }
    return ANBasicTokenFunctionIDNotFound;
}

+ (NSString *)functionNameForID:(ANBasicTokenFunctionID)functionID {
    for (int i = 0; functionNames[i].functionName != nil; i++) {
        if (functionNames[i].functionID == functionID) {
            return functionNames[i].functionName;
        }
    }
    return nil;
}

- (UInt8)machineCodeType {
    return ANBasicMCObjectFunctionType;
}

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    ANBasicTokenFunctionID functionID = [[self class] functionIDForName:self.functionName];
    if (functionID == ANBasicTokenFunctionIDNotFound) return NO;
    [super encodeToBuffer:buffer];
    [buffer writeByte:functionID];
    if ([self groupedToken]) {
        return [groupedToken encodeToBuffer:buffer];
    }
    return YES;
}

+ (id<ANBasicMCObject>)decodeFromBuffer:(ANBasicByteBuffer *)buffer type:(UInt8)readType {
    ANBasicTokenFunctionID functionID = [buffer readByte];
    NSString * funcName = [[self class] functionNameForID:functionID];
    if (!funcName) return nil;
    ANBasicTokenFunction * function = [[ANBasicTokenFunction alloc] initWithFunctionName:funcName];
    
    if ([function functionTakesArgument]) {
        // read the type and contents of the next argument
        UInt8 aType = [buffer readByte];
        ANBasicToken * token = (id)[ANBasicToken decodeFromBuffer:buffer type:aType];
        if (!token) return nil;
        [function setHasBeenGrouped:YES];
        [function setGroupedToken:token];
    }
    return function;
}

@end
