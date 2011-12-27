//
//  ANBasicTokenControlBlock+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenControlBlock+MCObject.h"

@implementation ANBasicTokenControlBlock (MCObject)

- (UInt8)machineCodeType {
    return ANBasicMCObjectControlBlockType;
}

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    [super encodeToBuffer:buffer];
    [buffer writeByte:self.controlType];
    return NO;
}

+ (id<ANBasicMCObject>)decodeFromBuffer:(ANBasicByteBuffer *)buffer type:(UInt8)readType {
    ANBasicTokenControlBlockType blockType = [buffer readByte];
    return [self decodeFromBuffer:buffer withCBType:blockType];
}

+ (ANBasicTokenControlBlock *)decodeFromBuffer:(ANBasicByteBuffer *)buffer withCBType:(ANBasicTokenControlBlockType)blockType {
    const struct {
        __unsafe_unretained Class class;
        ANBasicTokenControlBlockType blockType;
    } controlBlockTypes[] = {
        {NSClassFromString(@"ANBasicTokenIfControlBlock"), ANBasicControlTypeIfStatement},
        {NSClassFromString(@"ANBasicTokenWhileControlBlock"), ANBasicControlTypeWhileLoop},
        {NSClassFromString(@"ANBasicTokenLabelControlBlock"), ANBasicControlTypeLabel},
        {NSClassFromString(@"ANBasicTokenGotoControlBlock"), ANBasicControlTypeGoto},
        {NSClassFromString(@"ANBasicTokenForControlBlock"), ANBasicControlTypeForLoop},
        {Nil, 0}
    };
    for (int i = 0; controlBlockTypes[i].class != Nil; i++) {
        if (controlBlockTypes[i].blockType == blockType) {
            return [controlBlockTypes[i].class decodeFromBuffer:buffer withCBType:blockType];
        }
    }
    return nil;
}

@end
