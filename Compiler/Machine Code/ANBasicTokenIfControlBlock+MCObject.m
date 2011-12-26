//
//  ANBasicTokenIfControlBlock+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenIfControlBlock+MCObject.h"

@implementation ANBasicTokenIfControlBlock (MCObject)

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    [super encodeToBuffer:buffer];
    if (![condition encodeToBuffer:buffer]) return NO;
    if (![mainBody encodeToBuffer:buffer]) return NO;
    if (elseBody) {
        if (![elseBody encodeToBuffer:buffer]) return NO;
    } else {
        [buffer writeByte:0];
    }
    return nil;
}

+ (ANBasicTokenControlBlock *)decodeFromBuffer:(ANBasicByteBuffer *)buffer withCBType:(ANBasicTokenControlBlockType)blockType {
    ANBasicTokenIfControlBlock * ifBlock = [[ANBasicTokenIfControlBlock alloc] init];
    
    UInt8 conditionType = [buffer readByte];
    if (conditionType != ANBasicMCObjectBlockType) return nil;
    ifBlock.condition = (ANBasicTokenBlock *)[ANBasicTokenBlock decodeFromBuffer:buffer type:conditionType];
    
    UInt8 bodyType = [buffer readByte];
    if (bodyType != ANBasicMCObjectBlockType) return nil;
    ifBlock.mainBody = (ANBasicTokenBlock *)[ANBasicTokenBlock decodeFromBuffer:buffer type:bodyType];
    
    UInt8 elseType = [buffer readByte];
    if (elseType == ANBasicMCObjectBlockType) {
        ifBlock.elseBody = (ANBasicTokenBlock *)[ANBasicTokenBlock decodeFromBuffer:buffer type:conditionType];
    }
    
    return ifBlock;
}

@end
