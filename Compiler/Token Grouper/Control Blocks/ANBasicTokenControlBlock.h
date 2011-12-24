//
//  ANBasicTokenControlBlock.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

typedef enum {
    ANBasicControlTypeForLoop = 1,
    ANBasicControlTypeWhileLoop = 2,
    ANBasicControlTypeIfStatement = 3,
    ANBasicControlTypeLabel = 4,
    ANBasicControlTypeGoto = 5
} ANBasicTokenControlBlockType;

@interface ANBasicTokenControlBlock : ANBasicToken {
    ANBasicTokenControlBlockType controlType;
}

@property (readwrite) ANBasicTokenControlBlockType controlType;

- (id)initWithControlType:(ANBasicTokenControlBlockType)aType;

@end
