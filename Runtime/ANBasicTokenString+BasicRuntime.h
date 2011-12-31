//
//  ANBasicTokenString+BasicRuntime.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenString.h"
#import "ANBasicToken+BasicRuntime.h"

@interface ANBasicTokenString (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state;

@end
