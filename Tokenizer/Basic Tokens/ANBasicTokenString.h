//
//  ANBasicTokenString.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

@interface ANBasicTokenString : ANBasicToken {
    NSString * string;
}

@property (readonly) NSString * string;

- (id)initWithString:(NSString *)aString;

@end
