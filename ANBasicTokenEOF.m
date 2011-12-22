//
//  ANBasicTokenEOF.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenEOF.h"

@implementation ANBasicTokenEOF

+ (ANBasicTokenEOF *)eofToken {
    return [[ANBasicTokenEOF alloc] init];
}

@end
