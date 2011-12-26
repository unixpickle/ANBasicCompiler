//
//  ANBasicTokenControl+MCObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenControl+MCObject.h"

const struct {
    __unsafe_unretained NSString * controlName;
    ANBasicTokenControlID controlID;
} controlNames[] = {
    {@"Break", ANBasicTokenControlIDBreak},
    {@"Stop", ANBasicTokenControlIDStop},
    {nil, 0}
};

@implementation ANBasicTokenControl (MCObject)

+ (ANBasicTokenControlID)controlIDForName:(NSString *)theName {
    for (int i = 0; controlNames[i].controlName != nil; i++) {
        if ([controlNames[i].controlName isEqualToString:theName]) {
            return controlNames[i].controlID;
        }
    }
    return ANBasicTokenControlIDNotFound;
}

+ (NSString *)controlNameForID:(ANBasicTokenControlID)theID {
    for (int i = 0; controlNames[i].controlName != nil; i++) {
        if (controlNames[i].controlID == theID) {
            return controlNames[i].controlName;
        }
    }
    return nil;
}

- (UInt8)machineCodeType {
    return ANBasicMCObjectControlType;
}

- (BOOL)encodeToBuffer:(ANBasicByteBuffer *)buffer {
    ANBasicTokenControlID controlID = [[self class] controlIDForName:self.controlName];
    if (controlID == ANBasicTokenControlIDNotFound) return nil;
    [super encodeToBuffer:buffer];
    [buffer writeByte:controlID];
    return YES;
}

+ (id<ANBasicMCObject>)decodeFromBuffer:(ANBasicByteBuffer *)buffer type:(UInt8)readType {
    ANBasicTokenControlID controlID = [buffer readByte];
    NSString * controlName = [[self class] controlNameForID:controlID];
    if (!controlName) return nil;
    return [[ANBasicTokenControl alloc] initWithControlName:controlName];
}

@end
