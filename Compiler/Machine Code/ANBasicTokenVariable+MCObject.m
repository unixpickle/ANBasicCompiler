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
    [super encodeToBuffer:buffer];
    [buffer writeByte:[[self class] variableNumberFromName:variableName]];
    return YES;
}

+ (id<ANBasicMCObject>)decodeFromBuffer:(ANBasicByteBuffer *)buffer type:(UInt8)readType {
    NSString * varName = [[self class] variableNameFromNumber:[buffer readByte]];
    if (!varName) return nil;
    return [[ANBasicTokenVariable alloc] initWithVariableName:varName];
}

@end
