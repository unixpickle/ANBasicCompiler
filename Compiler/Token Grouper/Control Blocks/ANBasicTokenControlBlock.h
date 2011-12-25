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

/**
 * This is a concrete ANBasicToken subclass that represents a complex control flow
 * block in an ANBasic script. A lot of control blocks are denoted by the use of a
 * single control token at the beginning of a line, but then include more information
 * on the same or following lines.
 
 * For all control-related syntax that requires more than a single ANBasicTokenControl
 * token to fully be described, and instance of ANBasicTokenControlBlock must be used.
 * Examples of this are for loops and if statements.
 *
 * These tokens will exist only after the grouping process, and will not completely rid
 * the script of ANBasicTokenControl objects. Some control tokens, such as Stop and Break,
 * do not require additional parameters, and therefore can be represented by ANBasicTokenControl
 * objects.
 */
@interface ANBasicTokenControlBlock : ANBasicToken {
    ANBasicTokenControlBlockType controlType;
}

@property (readwrite) ANBasicTokenControlBlockType controlType;

- (id)initWithControlType:(ANBasicTokenControlBlockType)aType;

@end
