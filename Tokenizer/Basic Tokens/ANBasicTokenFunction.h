//
//  ANBasicTokenFunction.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

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
