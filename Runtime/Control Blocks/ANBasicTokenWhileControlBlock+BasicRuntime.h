//
//  ANBasicTokenWhileControlBlock+BasicRuntime.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenWhileControlBlock.h"
#import "ANBasicTokenBlock+BasicRuntime.h"

@interface ANBasicTokenWhileControlBlock (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state;

@end
