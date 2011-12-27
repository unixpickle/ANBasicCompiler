//
//  ANBasicTokenBlock+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenBlock+MCObject.h"

@implementation ANBasicTokenBlock (MCObject)

- (UInt8)machineCodeType {
    return ANBasicMCObjectBlockType;
}

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    [super encodeToBuffer:buffer];
    [buffer writeByte:self.printOutput];
    for (NSUInteger i = 0; i < [tokens count]; i++) {
        if (![[tokens objectAtIndex:i] encodeToBuffer:buffer]) return NO;
    }
    [buffer writeByte:0];
    return YES;
}

+ (id<ANBasicMCObject>)decodeFromBuffer:(ANBasicByteBuffer *)buffer type:(UInt8)readType {
    ANBasicTokenBlock * block = [[ANBasicTokenBlock alloc] init];
    block.printOutput = [buffer readByte];
    while (true) {
        UInt8 type = [buffer readByte];
        if (type == 0) break;
        ANBasicToken * token = (ANBasicToken *)[ANBasicToken decodeFromBuffer:buffer type:type];
        if (!token) return nil;
        [block.tokens addObject:token];
    }
    return block;
}

@end
