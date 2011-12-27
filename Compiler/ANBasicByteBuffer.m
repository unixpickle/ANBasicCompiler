//
//  ANBasicByteBuffer.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicByteBuffer.h"

@implementation ANBasicByteBuffer

- (id)init {
    if ((self = [super init])) {
        offset = 0;
        data = [[NSMutableData alloc] init];
    }
    return self;
}

- (id)initWithData:(NSData *)theData {
    if ((self = [super init])) {
        offset = 0;
        data = [theData mutableCopy];
    }
    return self;
}

- (NSUInteger)offset {
    return offset;
}

- (void)setOffset:(NSUInteger)anOffset {
    if (anOffset > [data length]) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"Offset out of bounds of buffer"
                                     userInfo:nil];
    }
}

- (void)writeData:(NSData *)someData {
    [data appendData:someData];
}

- (void)writeBytes:(const void *)bytes length:(NSUInteger)length {
    [data appendBytes:bytes length:length];
}

- (void)writeByte:(UInt8)aByte {
    [data appendBytes:&aByte length:1];
}

- (NSData *)readDataOfLength:(NSUInteger)length {
    if (offset + length > [data length]) {
        @throw [NSException exceptionWithName:ANBasicBufferUnderflowException
                                       reason:@"Not enough bytes are available for reading."
                                     userInfo:nil];
    }
    const char * buffer = (const char *)[data bytes];
    NSData * readData = [NSData dataWithBytes:&buffer[offset] length:length];
    offset += length;
    return readData;
}

- (UInt8)readByte {
    if (offset + 1 > [data length]) {
        @throw [NSException exceptionWithName:ANBasicBufferUnderflowException
                                       reason:@"Not enough bytes are available for reading."
                                     userInfo:nil];
    }
    const UInt8 * buffer = (const UInt8 *)[data bytes];
    return buffer[offset++];
}

- (NSData *)data {
    return data;
}

@end
