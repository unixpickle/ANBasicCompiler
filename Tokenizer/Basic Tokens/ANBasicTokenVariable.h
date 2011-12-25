//
//  ANBasicTokenVariable.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

/**
 * This is a concrete ANBasicToken subclass that represents a variable name. In a script,
 * this would be a capital letter from A to Z.
 *
 * After grouping, a variable will have its isAssignment property set appropriately. If the
 * variable was part of an expression, such as 3*X+2, then the variable is being read. If 
 * the variable is the receiver in an assignment, such as 10->A, then the variable (A in
 * this case) is being assigned a value. If the variable is being assigned a value, then the
 * isAssignment instance variable will be set to YES. If this is the case, the preceeding -> operator
 * will be omitted from the grouped script.
 */
@interface ANBasicTokenVariable : ANBasicToken {
    NSString * variableName;
    BOOL isAssignment;
}

@property (readonly) NSString * variableName;
@property (readwrite) BOOL isAssignment;

+ (BOOL)isVariableName:(NSString *)aTokenName;
- (id)initWithVariableName:(NSString *)aName;

@end
