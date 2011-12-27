//
//  ANBasicTokenWhileControlBlock+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenWhileControlBlock+MCObject.h"

@implementation ANBasicTokenWhileControlBlock (MCObject)

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    [super encodeToBuffer:buffer];
    if (![condition encodeToBuffer:buffer]) return NO;
    if (![loopBody encodeToBuffer:buffer]) return NO;
    return YES;
}

+ (ANBasicTokenControlBlock *)decodeFromBuffer:(ANBasicByteBuffer *)buffer withCBType:(ANBasicTokenControlBlockType)blockType {
    UInt8 conditionType = [buffer readByte];
    if (conditionType != ANBasicMCObjectBlockType) return nil;
    ANBasicTokenBlock * conditionBlock = (id)[ANBasicTokenBlock decodeFromBuffer:buffer type:conditionType];
    UInt8 bodyType = [buffer readByte];
    if (bodyType != ANBasicMCObjectBlockType) return nil;
    ANBasicTokenBlock * bodyBlock = (id)[ANBasicTokenBlock decodeFromBuffer:buffer type:bodyType];
    
    ANBasicTokenWhileControlBlock * whileBlock = [[ANBasicTokenWhileControlBlock alloc] init];
    [whileBlock setCondition:conditionBlock];
    [whileBlock setLoopBody:bodyBlock];
    return whileBlock;
}

@end
