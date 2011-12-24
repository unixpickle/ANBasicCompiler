//
//  ANBasicTokenControlBlock.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenControlBlock.h"

@implementation ANBasicTokenControlBlock

@synthesize controlType;

- (id)initWithControlType:(ANBasicTokenControlBlockType)aType {
    if ((self = [super init])) {
        controlType = aType;
    }
    return self;
}

@end
