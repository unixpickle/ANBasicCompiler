//
//  ANBasicToken+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken+MCObject.h"

@implementation ANBasicToken (MCObject)

- (UInt8)machineCodeType {
    return 0;
}

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    [buffer writeByte:[self machineCodeType]];
    return YES;
}

+ (id<ANBasicMCObject>)decodeFromBuffer:(ANBasicByteBuffer *)buffer type:(UInt8)readType {
    return nil;
}

@end
