//
//  ANBasicControlObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicCodeObject.h"

typedef enum {
    ANBasicControlTypeForLoop = 1,
    ANBasicControlTypeWhileLoop = 2
} ANBasicControlType;

@interface ANBasicControlObject : ANBasicCodeObject {
    ANBasicControlType controlType;
}

@property (readonly) ANBasicControlType controlType;

- (id)initWithControlType:(ANBasicControlType)aControlType;

@end
