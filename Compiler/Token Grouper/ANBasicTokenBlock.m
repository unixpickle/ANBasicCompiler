//
//  ANBasicTokenBlock.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenBlock.h"

@interface ANBasicTokenBlock (Private)

+ (NSString *)indentDescriptionString:(NSString *)aString;

@end

@implementation ANBasicTokenBlock

@synthesize tokens;
@synthesize printOutput;

- (id)init {
    if ((self = [super init])) {
        tokens = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithTokens:(NSArray *)someTokens {
    if ((self = [super init])) {
        tokens = [[NSMutableArray alloc] initWithArray:someTokens];
    }
    return self;
}

- (NSString *)description {
    NSMutableString * descriptionString = [NSMutableString string];
    [descriptionString appendFormat:@"<Code Block (printOutput=%@)> {\n", (printOutput ? @"YES" : @"NO")];
    for (ANBasicToken * token in tokens) {
        NSString * indentedDesc = [[self class] indentDescriptionString:[token description]];
        [descriptionString appendFormat:@"%@\n", indentedDesc];
    }
    [descriptionString appendFormat:@"}"];
    return descriptionString;
}

+ (NSString *)indentDescriptionString:(NSString *)aString {
    NSArray * lines = [aString componentsSeparatedByString:@"\n"];
    NSMutableString * newString = [NSMutableString string];
    for (NSUInteger i = 0; i < [lines count]; i++) {
        NSString * string = [lines objectAtIndex:i];
        [newString appendFormat:@"  %@%@", string, (i + 1 == [lines count]) ? @"" : @"\n"];
    }
    return newString;
}

#pragma mark Convenience

- (ANBasicToken *)firstToken {
    if ([tokens count] > 0) {
        ANBasicToken * firstToken = [tokens objectAtIndex:0];
        if ([firstToken isKindOfClass:[ANBasicTokenBlock class]]) {
            return [(ANBasicTokenBlock *)firstToken firstToken];
        } else return firstToken;
    }
    return nil;
}

- (void)removeFirstToken {
    if ([tokens count] > 0) {
        ANBasicToken * firstToken = [tokens objectAtIndex:0];
        if ([firstToken isKindOfClass:[ANBasicTokenBlock class]]) {
            [(ANBasicTokenBlock *)firstToken removeFirstToken];
        } else {
            [tokens removeObjectAtIndex:0];
        }
    }
}

- (ANBasicTokenBlock *)blockWithTokensInRange:(NSRange)aRange {
    NSArray * subArray = [tokens subarrayWithRange:aRange];
    return [[ANBasicTokenBlock alloc] initWithTokens:subArray];
}

@end
