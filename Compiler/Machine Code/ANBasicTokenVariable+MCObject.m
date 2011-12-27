//
//  ANBasicTokenVariable+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenVariable+MCObject.h"

@implementation ANBasicTokenVariable (MCObject)

+ (NSString *)variableNameFromNumber:(UInt8)varNum {
    varNum &= (0xff ^ 0b10000000);
    char varChar = 'A' + varNum;
    return [NSString stringWithFormat:@"%c", varChar];
}

+ (UInt8)variableNumberFromName:(NSString *)varName {
    if ([varName length] != 1) return 0xff;
    char theChar = (char)[varName characterAtIndex:0];
    return theChar - 'A';
}

- (UInt8)machineCodeType {
    return ANBasicMCObjectVariableType;
}

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    UInt8 varNum = [[self class] variableNumberFromName:variableName];
    varNum |= (self.isAssignment << 7);
    [super encodeToBuffer:buffer];
    [buffer writeByte:varNum];
    return YES;
}

+ (id<ANBasicMCObject>)decodeFromBuffer:(ANBasicByteBuffer *)buffer type:(UInt8)readType {
    UInt8 varNum = [buffer readByte];
    NSString * varName = [[self class] variableNameFromNumber:varNum];
    if (!varName) return nil;
    ANBasicTokenVariable * variable = [[ANBasicTokenVariable alloc] initWithVariableName:varName];
    if ((varNum & 0b10000000) != 0) {
        [variable setIsAssignment:YES];
    }
    return variable;
}

@end
