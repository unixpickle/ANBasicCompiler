//
//  ANBasicBlockObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicBlockObject.h"

@implementation ANBasicBlockObject

@synthesize printOutput;
@synthesize subBlocks;

- (id)initWithSubBlocks:(NSArray *)theBlocks printOutput:(BOOL)flag {
    if ((self = [super init])) {
        [self setObjectType:ANBasicCodeObjectTypeCode];
        [self setAdditionalInfo:(flag << 3)];
        subBlocks = [theBlocks mutableCopy];
        printOutput = flag;
    }
    return self;
}

@end
