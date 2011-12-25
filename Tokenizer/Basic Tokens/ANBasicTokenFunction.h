//
//  ANBasicTokenFunction.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

/**
 * This is a concrete ANBasicToken subclass that represents a numerical function,
 * such as sin, cos, and Int.
 *
 * After code grouping, if this type of function expects an argument, the 
 * hasBeenGrouped and groupedToken instance variables will be set. The groupedToken
 * instance variable is the first code object that followed the function name in the
 * script file.
 */
@interface ANBasicTokenFunction : ANBasicToken {
    NSString * functionName;
    
    BOOL hasBeenGrouped;
    ANBasicToken * groupedToken;
}

@property (readonly) NSString * functionName;

@property (readwrite) BOOL hasBeenGrouped;
@property (nonatomic, strong) ANBasicToken * groupedToken;

+ (BOOL)isFunctionName:(NSString *)aTokenString;
- (id)initWithFunctionName:(NSString *)aName;
- (BOOL)functionTakesArgument;

@end
