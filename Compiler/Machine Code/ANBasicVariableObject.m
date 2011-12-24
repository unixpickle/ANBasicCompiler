//
//  ANBasicVariableObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicVariableObject.h"

@implementation ANBasicVariableObject

@synthesize accessType;
@synthesize variableID;

+ (UInt8)variableIDForName:(NSString *)varName {
    if ([varName length] != 1) return -1;
    unichar theChar = [varName characterAtIndex:0];
    if (theChar >= 'A' && theChar <= 'Z') {
        return theChar - 'A';
    }
    return -1;
}

- (id)initWithVariableID:(UInt8)varID access:(ANBasicVariableAccessType)access {
    if ((self = [super init])) {
        variableID = varID;
        accessType = access;
        [self setObjectType:ANBasicCodeObjectTypeVariable];
        [self setAdditionalInfo:(accessType << 4)];
    }
    return self;
}

@end
