//
//  ANBasicTokenString+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenString+MCObject.h"

@implementation ANBasicTokenString (MCObject)

- (UInt8)machineCodeType {
    return ANBasicMCObjectStringType;
}

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    [super encodeToBuffer:buffer];
    for (NSUInteger i = 0; i < [self.string length]; i++) {
        unichar aChar = [self.string characterAtIndex:i];
        if (aChar > 0 && aChar < 256) {
            [buffer writeByte:(UInt8)aChar];
        }
    }
    [buffer writeByte:0];
    return YES;
}

+ (id<ANBasicMCObject>)decodeFromBuffer:(ANBasicByteBuffer *)buffer type:(UInt8)readType {
    NSMutableString * stringBuilder = [NSMutableString string];
    while (true) {
        UInt8 aChar = [buffer readByte];
        if (aChar == 0) break;
        [stringBuilder appendFormat:@"%c", (char)aChar];
    }
    return [[ANBasicTokenString alloc] initWithString:stringBuilder];
}

@end
