//
//  ANBasicControlObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicControlObject.h"

@implementation ANBasicControlObject

@synthesize controlType;

- (id)initWithControlType:(ANBasicControlType)aControlType {
    if ((self = [super init])) {
        [self setObjectType:ANBasicCodeObjectTypeControl];
        [self setAdditionalInfo:aControlType];
        controlType = aControlType;
    }
    return self;
}

@end
