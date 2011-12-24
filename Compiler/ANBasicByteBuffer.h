//
//  ANBasicByteBuffer.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ANBasicBufferUnderflowException @"ANBasicBufferUnderflowException"

@interface ANBasicByteBuffer : NSObject {
    NSMutableData * data;
    NSUInteger offset;
}

- (id)initWithData:(NSData *)theData;

- (NSUInteger)offset;
- (void)setOffset:(NSUInteger)anOffset;

- (void)writeData:(NSData *)someData;
- (void)writeBytes:(const void *)bytes length:(NSUInteger)length;
- (void)writeByte:(UInt8)aByte;

- (NSData *)readDataOfLength:(NSUInteger)length;
- (UInt8)readByte;

@end
