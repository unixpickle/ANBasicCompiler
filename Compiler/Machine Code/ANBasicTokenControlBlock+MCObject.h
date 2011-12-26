//
//  ANBasicTokenControlBlock+MCObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenControlBlock.h"
#import "ANBasicToken+MCObject.h"

#define ANBasicMCObjectControlBlockType 8

@interface ANBasicTokenControlBlock (MCObject) <ANBasicMCObject>

+ (ANBasicTokenControlBlock *)decodeFromBuffer:(ANBasicByteBuffer *)buffer withCBType:(ANBasicTokenControlBlockType)blockType;

@end
