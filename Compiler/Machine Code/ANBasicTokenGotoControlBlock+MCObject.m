//
//  ANBasicTokenGotoControlBlock+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenGotoControlBlock+MCObject.h"

@implementation ANBasicTokenGotoControlBlock (MCObject)

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    [super encodeToBuffer:buffer];
    if (![jumpLocation encodeToBuffer:buffer]) return NO;
    return YES;
}

+ (ANBasicTokenControlBlock *)decodeFromBuffer:(ANBasicByteBuffer *)buffer withCBType:(ANBasicTokenControlBlockType)blockType {
    UInt8 jumpBlockType = [buffer readByte];
    if (jumpBlockType != ANBasicMCObjectBlockType) return nil;
    ANBasicTokenBlock * jumpBlock = (id)[ANBasicTokenBlock decodeFromBuffer:buffer type:jumpBlockType];
    
    ANBasicTokenGotoControlBlock * gotoControl = [[ANBasicTokenGotoControlBlock alloc] init];
    [gotoControl setJumpLocation:jumpBlock];
    return gotoControl;
}

@end
