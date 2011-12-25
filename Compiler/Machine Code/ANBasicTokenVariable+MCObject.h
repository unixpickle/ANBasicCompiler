//
//  ANBasicTokenVariable+MCObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenVariable.h"
#import "ANBasicToken+MCObject.h"

#define ANBasicMCObjectVariableType 3

@interface ANBasicTokenVariable (MCObject) <ANBasicMCObject>

+ (NSString *)variableNameFromNumber:(UInt8)varNum;
+ (UInt8)variableNumberFromName:(NSString *)varName;

@end
