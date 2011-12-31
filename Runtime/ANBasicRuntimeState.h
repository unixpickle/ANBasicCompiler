//
//  ANBasicRuntimeState.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ANBasicRuntimeReturnTypeValue,
    ANBasicRuntimeReturnTypeGoto,
    ANBasicRuntimeReturnTypeBreak,
    ANBasicRuntimeReturnTypeStop
} ANBasicRuntimeReturnType;

@interface ANBasicRuntimeState : NSObject {
    ANBasicRuntimeReturnType returnType;
    double returnNumber;
    int gotoLineNumber;
    
    NSMutableDictionary * variableValues;
    BOOL isOnNewLine;
}

@property (readwrite) ANBasicRuntimeReturnType returnType;
@property (readwrite) double returnNumber;
@property (readwrite) int gotoLineNumber;

- (void)returnNumeric:(double)aNumber;
- (void)gotoLineNumber:(int)number;
- (void)resetReturnState;

- (double)valueForVariableName:(NSString *)varName;
- (void)setValue:(double)aValue forVariableName:(NSString *)varName;

- (void)print:(NSString *)str requireNewLine:(BOOL)newLine;
- (void)promptMore;
- (NSString *)promptInput;

@end
