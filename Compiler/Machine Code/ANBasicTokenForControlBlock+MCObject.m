//
//  ANBasicTokenForControlBlock+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenForControlBlock+MCObject.h"

@implementation ANBasicTokenForControlBlock (MCObject)

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    if (!initialBlock || !counterVariable || !destinationBlock || !loopBody) {
        return NO;
    }
    
    [super encodeToBuffer:buffer];

    if (![initialBlock encodeToBuffer:buffer]) return NO;
    if (![counterVariable encodeToBuffer:buffer]) return NO;
    if (![destinationBlock encodeToBuffer:buffer]) return NO;
    if (stepValue) {
        if (![stepValue encodeToBuffer:buffer]) return NO;
    } else {
        [buffer writeByte:0];
    }
    if (![loopBody encodeToBuffer:buffer]) return NO;
    
    return YES;
}

+ (ANBasicTokenControlBlock *)decodeFromBuffer:(ANBasicByteBuffer *)buffer withCBType:(ANBasicTokenControlBlockType)blockType {
    ANBasicTokenForControlBlock * forBlock = [[ANBasicTokenForControlBlock alloc] init];
    
    UInt8 initBlockType = [buffer readByte];
    if (initBlockType != ANBasicMCObjectBlockType) return nil;
    forBlock.initialBlock = (ANBasicTokenBlock *)[ANBasicTokenBlock decodeFromBuffer:buffer type:initBlockType];
    
    UInt8 counterVarType = [buffer readByte];
    if (counterVarType != ANBasicMCObjectVariableType) return nil;
    forBlock.counterVariable = (ANBasicTokenVariable *)[ANBasicTokenVariable decodeFromBuffer:buffer type:counterVarType];
    
    UInt8 destBlockType = [buffer readByte];
    if (destBlockType != ANBasicMCObjectBlockType) return nil;
    forBlock.destinationBlock = (ANBasicTokenBlock *)[ANBasicTokenBlock decodeFromBuffer:buffer type:destBlockType];
    
    UInt8 stepValType = [buffer readByte];
    if (stepValType == ANBasicMCObjectNumberType) {
        forBlock.stepValue = (ANBasicTokenNumber *)[ANBasicTokenNumber decodeFromBuffer:buffer type:stepValType];
    }
    
    UInt8 loopBodyType = [buffer readByte];
    if (loopBodyType != ANBasicMCObjectBlockType) return nil;
    forBlock.loopBody = (ANBasicTokenBlock *)[ANBasicTokenBlock decodeFromBuffer:buffer type:loopBodyType];

    return forBlock;
}

@end
