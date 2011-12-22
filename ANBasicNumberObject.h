//
//  ANBasicNumberObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicCodeObject.h"

@interface ANBasicNumberObject : ANBasicCodeObject {
    NSNumber * number;
    BOOL isInteger;
}

@property (readonly) NSNumber * number;
@property (readonly) BOOL isInteger;

- (id)initWithNumber:(NSNumber *)aNumber;

@end
