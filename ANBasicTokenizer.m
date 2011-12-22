//
//  ANBasicTokenizer.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenizer.h"

@implementation ANBasicTokenizer

@synthesize string;
@synthesize offset;

- (id)initWithString:(NSString *)aString offset:(NSUInteger)initial {
    if ((self = [super init])) {
        string = aString;
        offset = initial;
        if (offset > [string length]) {
            @throw [NSException exceptionWithName:ANBufferUnderflowException
                                           reason:@"The offset exceeds the limits of the buffer."
                                         userInfo:nil];
        }
    }
    return self;
}

- (NSUInteger)available {
    return [string length] - offset;
}

- (NSString *)readUntilCharacterInSet:(NSCharacterSet *)charSet {
    return [self readUntilCharacterInSet:charSet inclusive:NO];
}

- (NSString *)readUntilCharacterInSet:(NSCharacterSet *)charSet inclusive:(BOOL)inclusive {
    NSMutableString * _mutableString = [[NSMutableString alloc] init];
    while (offset < [string length]) {
        unichar aChar = [string characterAtIndex:offset++];
        if (![charSet characterIsMember:aChar]) {
            [_mutableString appendFormat:@"%C", aChar];
        } else {
            if (inclusive) {
                [_mutableString appendFormat:@"%C", aChar];
            } else {
                offset--;
            }
            break;
        }
    }
    return [NSString stringWithString:_mutableString];
}

- (BOOL)chompCharactersInSet:(NSCharacterSet *)charSet {
    while (offset < [string length]) {
        unichar aChar = [string characterAtIndex:offset];
        if (![charSet characterIsMember:aChar]) {
            return YES;
        }
        offset++;
    }
    return NO;
}

#pragma mark - Reading Tokens -

- (ANBasicToken *)readNextToken {
    NSString * operators[] = {
        @"+", @"-", @"*", @"/", @"^",
        @"->", @"(", @")",
        @">", @"<", @"<=", @">=", @"=", @"!=",
        @";", @":", @"\n", @"=>" // control operators, we state they are operators
    };                           // here, but they are really just control characters.
    NSCharacterSet * numChars = [NSCharacterSet characterSetWithCharactersInString:@".01234567890"];
    NSCharacterSet * nameChars = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ#"];
    if (![self chompCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]) return nil;
    if (offset >= [string length]) return nil;
    unichar startChar = [string characterAtIndex:offset];
    if ([numChars characterIsMember:startChar]) {
        NSString * numString = [self readNumericalToken];
        NSNumber * number = [NSNumber numberWithDouble:[numString doubleValue]];
        return [[ANBasicTokenNumber alloc] initWithNumberValue:number];
    } else if ([nameChars characterIsMember:startChar]) {
        NSString * nameString = [self readNameToken];
        if ([ANBasicTokenFunction isFunctionName:nameString]) {
            return [[ANBasicTokenFunction alloc] initWithFunctionName:nameString];
        } else if ([ANBasicTokenControl isControlName:nameString]) {
            return [[ANBasicTokenControl alloc] initWithControlName:nameString];
        } else if ([ANBasicTokenVariable isVariableName:nameString]) {
            return [[ANBasicTokenVariable alloc] initWithVariableName:nameString];
        }
        return nil;
    } else if (startChar == '"') {
        return [[ANBasicTokenString alloc] initWithString:[self readStringToken]];
    } else {
        for (NSUInteger i = 0; i < (sizeof(operators) / sizeof(NSString *)); i++) {
            if ([operators[i] hasPrefix:[NSString stringWithFormat:@"%C", startChar]]) {
                NSString * operatorString = [self readOperatorToken];
                if (![ANBasicTokenControl isControlName:operatorString]) {
                    return [[ANBasicTokenOperator alloc] initWithOperatorName:operatorString];
                } else {
                    return [[ANBasicTokenControl alloc] initWithControlName:operatorString];
                }
            }
        }
    }
    return nil;
}

- (NSString *)readNumericalToken {
    NSMutableString * numToken = [[NSMutableString alloc] init];
    
    while (offset < [string length]) {
        unichar aChar = [string characterAtIndex:offset];
        if (aChar != '.' && !isdigit(aChar)) {
            break;
        } else {
            [numToken appendFormat:@"%C", aChar];
            offset++;
        }
    }
    
    return [NSString stringWithString:numToken];
}

- (NSString *)readNameToken {
    NSMutableString * nameToken = [[NSMutableString alloc] init];
    
    while (offset < [string length]) {
        unichar aChar = [string characterAtIndex:offset];
        if (aChar != '#' && !isalpha(aChar)) {
            break;
        } else {
            [nameToken appendFormat:@"%C", aChar];
            offset++;
        }
    }
    
    return [NSString stringWithString:nameToken];
}

- (NSString *)readOperatorToken {
    NSString * operators[] = {
        @"+", @"-", @"*", @"/", @"^",
        @"->", @"(", @")",
        @">", @"<", @"<=", @">=", @"=", @"!=",
        @";", @":", @"\n", @"=>"
    };
    NSMutableString * opString = [[NSMutableString alloc] init];
    NSString * operatorString = nil;
    NSUInteger endOperatorOffset = offset;
    while (offset < [string length]) {
        unichar character = [string characterAtIndex:offset++];
        [opString appendFormat:@"%C", character];
        BOOL shouldContinue = NO;
        for (NSUInteger i = 0; i < sizeof(operators) / sizeof(NSString *); i++) {
            NSString * operator = operators[i];
            if ([operator length] > [opString length] && [operator hasPrefix:opString]) {
                shouldContinue = YES;
            } else if ([operator isEqualToString:opString]) {
                operatorString = [NSString stringWithString:opString];
                endOperatorOffset = offset;
            }
        }
        if (!shouldContinue) break;
    }
    offset = endOperatorOffset;
    return operatorString;
}

- (NSString *)readStringToken {
    NSMutableString * _mutableString = [[NSMutableString alloc] init];
    
    offset++;
    while (offset < [string length]) {
        unichar aChar = [string characterAtIndex:offset++];
        if (aChar == '"') {
            return [NSString stringWithString:_mutableString];
        } else {
            [_mutableString appendFormat:@"%C", aChar];
        }
    }
    
    return nil;
}

@end
