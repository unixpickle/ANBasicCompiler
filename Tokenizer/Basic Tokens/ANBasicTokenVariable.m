//
//  ANBasicTokenVariable.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenVariable.h"

@implementation ANBasicTokenVariable

@synthesize variableName;
@synthesize isAssignment;

+ (BOOL)isVariableName:(NSString *)aTokenName {
    if ([aTokenName length] != 1) {
        return NO;
    }
    unichar theChar = [aTokenName characterAtIndex:0];
    if (!isupper(theChar)) return NO;
    return YES;
}

- (id)initWithVariableName:(NSString *)aName {
    if ((self = [super init])) {
        if (![[self class] isVariableName:aName]) return nil;
        variableName = aName;
    }
    return self;
}

- (NSString *)stringValue {
    return variableName;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<ANBasicTokenVariable: %@ (write=%@)>", [self stringValue],
            (isAssignment ? @"YES" : @"NO")];
}

@end
