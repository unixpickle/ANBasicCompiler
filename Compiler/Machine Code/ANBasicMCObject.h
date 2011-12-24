//
//  ANBasicMCObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANBasicByteBuffer.h"

@protocol ANBasicMCObject

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer;
+ (id<ANBasicMCObject>)decodeFromBuffer:(ANBasicByteBuffer *)buffer type:(UInt8)readType;

@end
