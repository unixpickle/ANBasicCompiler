//
//  ANBasicNumberObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicNumberObject.h"

@implementation ANBasicNumberObject

@synthesize number;
@synthesize isInteger;

- (id)initWithNumber:(NSNumber *)aNumber {
    if ((self = [super init])) {
        [self setObjectType:ANBasicCodeObjectTypeNumber];
        if ((double)[aNumber longLongValue] == [aNumber doubleValue]) {
            isInteger = YES;
        }
        number = aNumber;
        [self setAdditionalInfo:(isInteger << 4)];
    }
    return self;
}

@end
