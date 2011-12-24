//
//  ANBasicTokenNumber.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenNumber.h"

@implementation ANBasicTokenNumber

@synthesize numberValue;

- (id)initWithNumberValue:(NSNumber *)aNumber {
    if ((self = [super init])) {
        numberValue = aNumber;
    }
    return self;
}

- (NSString *)stringValue {
    return [numberValue stringValue];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<ANBasicTokenNumber: %@>", [self stringValue]];
}

@end
