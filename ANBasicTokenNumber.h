//
//  ANBasicTokenNumber.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

@interface ANBasicTokenNumber : ANBasicToken {
    NSNumber * numberValue;
}

@property (readonly) NSNumber * numberValue;

- (id)initWithNumberValue:(NSNumber *)aNumber;

@end
