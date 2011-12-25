//
//  ANBasicTokenControl.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

/**
 * This is a concrete ANBasicToken subclass that represents a program-state control
 * operator, such as a Goto or If command. New lines are also control tokens. All
 * ANBasicTokenControl objects are single-word commands, such as If, Else, or Next.
 *
 * After grouping, many types of control blocks, such as for loops and if statements
 * will be converted to ANBasicTokenControlBlock objects. However, ANBasicTokenControl
 * objects may still exist for several control flow commands, such as "Stop" and "Break".
 */
@interface ANBasicTokenControl : ANBasicToken {
    NSString * controlName;
}

@property (readonly) NSString * controlName;

+ (BOOL)isControlName:(NSString *)aTokenString;
- (id)initWithControlName:(NSString *)aName;
- (BOOL)isNewBlockControl;

@end
