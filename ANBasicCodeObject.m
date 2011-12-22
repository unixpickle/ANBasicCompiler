//
//  ANBasicCodeObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicCodeObject.h"

@implementation ANBasicCodeObject

@synthesize basicHeader;

- (ANBasicCodeObjectType)objectType {
    return (basicHeader >> 5) & 7;
}

- (void)setObjectType:(ANBasicCodeObjectType)objectType {
    basicHeader &= (0xff ^ (7 << 5));
    basicHeader |= (objectType << 5);
}

- (UInt8)additionalInfo {
    return basicHeader & 0b11111;
}

- (void)setAdditionalInfo:(UInt8)info {
    basicHeader &= (0xff ^ 0b11111);
    basicHeader |= (info & 0b11111);
}

@end
