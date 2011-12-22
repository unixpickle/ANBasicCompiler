//
//  ANBasicTokenOperator.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

@interface ANBasicTokenOperator : ANBasicToken {
    NSString * operatorName; 
}

@property (readonly) NSString * operatorName;

+ (BOOL)isOperatorName:(NSString *)aTokenName;
- (id)initWithOperatorName:(NSString *)aName;

@end
