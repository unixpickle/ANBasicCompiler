//
//  ANBasicTokenOperator+BasicRuntime.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenOperator.h"
#import "ANBasicToken+BasicRuntime.h"

@interface ANBasicTokenOperator (BasicRuntime)

- (BOOL)executeOperator:(double)leftValue state:(ANBasicRuntimeState *)state;

@end
