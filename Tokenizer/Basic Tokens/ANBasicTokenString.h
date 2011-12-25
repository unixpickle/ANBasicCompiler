//
//  ANBasicTokenString.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

/**
 * This is a concrete ANBasicToken subclass that represents a string of
 * characters. In the script, this would be represented as "A STRING".
 * 
 * Grouping has no effect on ANBasicTokenString objects.
 */
@interface ANBasicTokenString : ANBasicToken {
    NSString * string;
}

@property (readonly) NSString * string;

- (id)initWithString:(NSString *)aString;

@end
