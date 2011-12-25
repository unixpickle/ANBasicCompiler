//
//  ANBasicTokenNumber.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

/**
 * This is a concrete ANBasicToken subclass that represents a floating-point decimal number
 * in the script.
 *
 * Grouping has no effect on ANBasicTokenNumber objects.
 */
@interface ANBasicTokenNumber : ANBasicToken {
    NSNumber * numberValue;
}

@property (readonly) NSNumber * numberValue;

- (id)initWithNumberValue:(NSNumber *)aNumber;

@end
