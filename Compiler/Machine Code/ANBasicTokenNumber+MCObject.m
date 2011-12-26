//
//  ANBasicTokenNumber+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenNumber+MCObject.h"

@implementation ANBasicTokenNumber (MCObject)

- (UInt8)machineCodeType {
    return ANBasicMCObjectNumberType;
}

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    [super encodeToBuffer:buffer];
    ANFloatingPoint * floatingPoint = [[ANFloatingPoint alloc] initWithDouble:[self.numberValue doubleValue]];
    [buffer writeData:[floatingPoint packedData]];
    return YES;
}

+ (id<ANBasicMCObject>)decodeFromBuffer:(ANBasicByteBuffer *)buffer type:(UInt8)readType {
    NSData * packed = [buffer readDataOfLength:8];
    ANFloatingPoint * floatingPoint = [[ANFloatingPoint alloc] initWithPacked:packed];
    NSNumber * number = [NSNumber numberWithDouble:[floatingPoint doubleValue]];
    return [[ANBasicTokenNumber alloc] initWithNumberValue:number];
}

@end
