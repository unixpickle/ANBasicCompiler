//
//  ANBasicVariableObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicCodeObject.h"

typedef enum {
    ANBasicVariableAccessTypeRead = 0,
    ANBasicVariableAccessTypeWrite = 1
} ANBasicVariableAccessType;

@interface ANBasicVariableObject : ANBasicCodeObject {
    ANBasicVariableAccessType accessType;
    UInt8 variableID;
}

@property (readonly) ANBasicVariableAccessType accessType;
@property (readonly) UInt8 variableID;

+ (UInt8)variableIDForName:(NSString *)varName;
- (id)initWithVariableID:(UInt8)varID access:(ANBasicVariableAccessType)access;

@end
