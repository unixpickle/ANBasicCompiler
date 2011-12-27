//
//  ANBasicTokenLabelControlBlock+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenLabelControlBlock+MCObject.h"

@implementation ANBasicTokenLabelControlBlock (MCObject)

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    [super encodeToBuffer:buffer];
    if (![labelNumber encodeToBuffer:buffer]) return NO;
    return YES;
}

+ (ANBasicTokenControlBlock *)decodeFromBuffer:(ANBasicByteBuffer *)buffer withCBType:(ANBasicTokenControlBlockType)blockType {
    UInt8 labelNumType = [buffer readByte];
    if (labelNumType != ANBasicMCObjectNumberType) return nil;
    ANBasicTokenNumber * labelNum = (id)[ANBasicTokenNumber decodeFromBuffer:buffer type:labelNumType];
    
    ANBasicTokenLabelControlBlock * label = [[ANBasicTokenLabelControlBlock alloc] init];
    [label setLabelNumber:labelNum];
    return label;
}

@end
