//
//  ANBasicTokenOperator.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

/**
 * This is a concrete ANBasicToken subclass that represents a numerical operator
 * in ANBasic source code.
 * 
 * Before the grouping stage of compilation, instances of ANBasicTokenOperator are
 * used to represent parentheses, and assignment operators, as well as numerical
 * operators. After grouping, there is no need for ( and ) operators, because sub-blocks
 * will take their place. The assignment operator (->) will be omitted by setting the
 * isAssignment property on it's corresponding variable.
 */
@interface ANBasicTokenOperator : ANBasicToken {
    NSString * operatorName; 
}

@property (readonly) NSString * operatorName;

+ (BOOL)isOperatorName:(NSString *)aTokenName;
- (id)initWithOperatorName:(NSString *)aName;

- (BOOL)isComparatorOperator;

@end
