//
//  ANBasicTokenIfControlBlock+BasicRuntime.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenIfControlBlock.h"
#import "ANBasicTokenBlock+BasicRuntime.h"

@interface ANBasicTokenIfControlBlock (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state;

@end
