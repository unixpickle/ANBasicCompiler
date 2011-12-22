//
//  ANBasicTokenOperator.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenOperator.h"

@implementation ANBasicTokenOperator

@synthesize operatorName;

+ (BOOL)isOperatorName:(NSString *)aTokenName {
    NSString * operators[] = {
        @"+", @"-", @"*", @"/", @"^",
        @"->", @"(", @")",
        @">", @"<", @"<=", @">=", @"=", @"!="
    };
    for (NSUInteger i = 0; i < (sizeof(operators) / sizeof(NSString *)); i++) {
        if ([operators[i] isEqualToString:aTokenName]) {
            return YES;
        }
    }
    return NO;
}

- (id)initWithOperatorName:(NSString *)aName {
    if ((self = [super init])) {
        if (![[self class] isOperatorName:aName]) return nil;
        operatorName = aName;
    }
    return self;
}

- (NSString *)stringValue {
    return operatorName;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<ANBasicTokenOperator: %@>", [self stringValue]];
}

@end
