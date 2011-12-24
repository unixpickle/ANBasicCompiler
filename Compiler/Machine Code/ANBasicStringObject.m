//
//  ANBasicStringObject.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicStringObject.h"

@implementation ANBasicStringObject

@synthesize stringValue;

- (id)initWithStringValue:(NSString *)aString {
    if ((self = [super init])) {
        [self setObjectType:ANBasicCodeObjectTypeString];
        stringValue = aString;
    }
    return self;
}

@end
