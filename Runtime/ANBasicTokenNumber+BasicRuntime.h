//
//  ANBasicTokenNumber+BasicRuntime.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenNumber.h"
#import "ANBasicToken+BasicRuntime.h"

@interface ANBasicTokenNumber (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state;

@end
