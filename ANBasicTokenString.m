//
//  ANBasicTokenString.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenString.h"

@implementation ANBasicTokenString

@synthesize string;

- (id)initWithString:(NSString *)aString {
    if ((self = [super init])) {
        string = aString;
    }
    return self;
}

- (NSString *)stringValue {
    return string;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<ANBasicTokenString: \"%@\">", string];
}

@end
