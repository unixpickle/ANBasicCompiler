//
//  ANBasicTokenVariable.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

@interface ANBasicTokenVariable : ANBasicToken {
    NSString * variableName;
}

@property (readonly) NSString * variableName;

+ (BOOL)isVariableName:(NSString *)aTokenName;
- (id)initWithVariableName:(NSString *)aName;

@end
