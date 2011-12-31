//
//  ANBasicRuntimeState.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicRuntimeState.h"

@implementation ANBasicRuntimeState

@synthesize returnType;
@synthesize returnNumber;
@synthesize gotoLineNumber;

- (id)init {
    if ((self = [super init])) {
        returnType = ANBasicRuntimeReturnTypeValue;
        returnNumber = 0;
        variableValues = [[NSMutableDictionary alloc] init];
        isOnNewLine = YES;
    }
    return self;
}

- (void)returnNumeric:(double)aNumber {
    returnNumber = aNumber;
    returnType = ANBasicRuntimeReturnTypeValue;
}

- (void)gotoLineNumber:(int)number {
    gotoLineNumber = number;
    returnType = ANBasicRuntimeReturnTypeValue;
}

- (void)resetReturnState {
    returnType = ANBasicRuntimeReturnTypeValue;
    returnNumber = 0;
    gotoLineNumber = 0;
}

- (double)valueForVariableName:(NSString *)varName {
    return [[variableValues objectForKey:varName] doubleValue];
}

- (void)setValue:(double)aValue forVariableName:(NSString *)varName {
    [variableValues setObject:[NSNumber numberWithDouble:aValue] forKey:varName];
}

- (void)print:(NSString *)str requireNewLine:(BOOL)newLine {
    if (isOnNewLine || !newLine) {
        printf("%s", [str UTF8String]);
    } else {
        printf("\n%s", [str UTF8String]);
    }
    fflush(stdout);
    isOnNewLine = NO;
}

- (void)promptMore {
    [self print:@"-More-" requireNewLine:YES];
    int aChar;
    while ((aChar = fgetc(stdin)) != EOF) {
        if (aChar == '\n') break;
    }
    isOnNewLine = YES;
}

- (NSString *)promptInput {
    [self print:@"?\n" requireNewLine:NO];
    NSMutableString * readString = [NSMutableString string];
    int aChar;
    while ((aChar = fgetc(stdin)) != EOF) {
        if (aChar == '\n') break;
        else if (aChar != '\r') {
            [readString appendFormat:@"%C", aChar];
        }
    }
    isOnNewLine = YES;
    return [NSString stringWithString:readString];
}

@end
