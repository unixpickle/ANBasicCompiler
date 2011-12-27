//
//  ANBasicTokenBlock+BasicRuntime.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenBlock.h"
#import "ANBasicToken+BasicRuntime.h"

@interface ANBasicTokenBlock (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state;

@end
