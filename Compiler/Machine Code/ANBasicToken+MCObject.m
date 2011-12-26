//
//  ANBasicToken+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken+MCObject.h"
#import "ANBasicTokenOperator+MCObject.h"
#import "ANBasicTokenVariable+MCObject.h"
#import "ANBasicTokenString+MCObject.h"
#import "ANBasicTokenNumber+MCObject.h"
#import "ANBasicTokenBlock+MCObject.h"
#import "ANBasicTokenFunction+MCObject.h"
#import "ANBasicTokenControl+MCObject.h"
#import "ANBasicTokenControlBlock+MCObject.h"

@implementation ANBasicToken (MCObject)

- (UInt8)machineCodeType {
    return 0;
}

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    [buffer writeByte:[self machineCodeType]];
    return NO;
}

+ (id<ANBasicMCObject>)decodeFromBuffer:(ANBasicByteBuffer *)buffer type:(UInt8)readType {
    const struct {
        __unsafe_unretained Class class;
        UInt8 type;
    } _machineCodeTypes[] = {
        {NSClassFromString(@"ANBasicTokenOperator"), ANBasicMCObjectOperatorType},
        {NSClassFromString(@"ANBasicTokenString"), ANBasicMCObjectStringType},
        {NSClassFromString(@"ANBasicTokenVariable"), ANBasicMCObjectVariableType},
        {NSClassFromString(@"ANBasicTokenNumber"), ANBasicMCObjectNumberType},
        {NSClassFromString(@"ANBasicTokenBlock"), ANBasicMCObjectBlockType},
        {NSClassFromString(@"ANBasicTokenFunction"), ANBasicMCObjectFunctionType},
        {NSClassFromString(@"ANBasicTokenControl"), ANBasicMCObjectControlType},
        {NSClassFromString(@"ANBasicTokenControlBlock"), ANBasicMCObjectControlBlockType},
        {nil, 0}
    };
    
    for (int i = 0; _machineCodeTypes[i].class != nil; i++) {
        if (_machineCodeTypes[i].type == readType) {
            Class c = _machineCodeTypes[i].class;
            return [c decodeFromBuffer:buffer type:readType];
        }
    }
    
    return nil;
}

@end
