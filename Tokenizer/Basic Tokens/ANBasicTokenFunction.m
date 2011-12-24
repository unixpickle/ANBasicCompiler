//
//  ANBasicTokenFunction.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenFunction.h"

@implementation ANBasicTokenFunction

@synthesize functionName;
@synthesize hasBeenGrouped;
@synthesize groupedToken;

+ (BOOL)isFunctionName:(NSString *)aTokenString {
    NSString * functionNames[] = {
        @"sin", @"cos", @"tan", @"arcsin", @"arccos", @"arctan",
        @"log", @"ln", @"sqrt",
        @"Abs", @"Ran#", @"Int", @"-", @"?"
    };
    for (NSUInteger i = 0; i < (sizeof(functionNames) / sizeof(NSString *)); i++) {
        if ([functionNames[i] isEqualToString:aTokenString]) {
            return YES;
        }
    }
    return NO;
}

- (id)initWithFunctionName:(NSString *)aName {
    if ((self = [super init])) {
        if (![[self class] isFunctionName:aName]) return nil;
        functionName = aName;
    }
    return self;
}

- (BOOL)functionTakesArgument {
    NSString * argLess[] = {
        @"Ran#", @"?"
    };
    for (NSUInteger i = 0; i < (sizeof(argLess) / sizeof(NSString *)); i++) {
        if ([argLess[i] isEqualToString:functionName]) {
            return NO;
        }
    }
    return YES;
}

- (NSString *)stringValue {
    return functionName;
}

- (NSString *)description {
    if (!hasBeenGrouped) return [NSString stringWithFormat:@"<ANBasicTokenFunction: %@>", [self stringValue]];
    else {
        return [NSString stringWithFormat:@"<ANBasicTokenFunction %@ (%@)>", functionName, groupedToken];
    }
}

@end
