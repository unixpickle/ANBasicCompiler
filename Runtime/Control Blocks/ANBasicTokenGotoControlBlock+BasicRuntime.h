//
//  ANBasicTokenGotoControlBlock+BasicRuntime.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenGotoControlBlock.h"
#import "ANBasicTokenControlBlock+BasicRuntime.h"

@interface ANBasicTokenGotoControlBlock (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state;

@end
