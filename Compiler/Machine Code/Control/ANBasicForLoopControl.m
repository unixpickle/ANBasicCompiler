//
//  ANBasicForLoopControl.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicForLoopControl.h"

@implementation ANBasicForLoopControl

@synthesize initialValue;
@synthesize counterVariable;
@synthesize destinationValue;
@synthesize stepValue;
@synthesize codeBlock;

- (id)initWithInitial:(NSNumber *)initial
          destination:(NSNumber *)destination
              counter:(NSString *)variableName
                 step:(NSNumber *)step {
    if ((self = [super initWithControlType:ANBasicControlTypeForLoop])) {
        UInt8 varID = [ANBasicVariableObject variableIDForName:variableName];
        initialValue = [[ANBasicNumberObject alloc] initWithNumber:initial];
        counterVariable = [[ANBasicVariableObject alloc] initWithVariableID:varID access:ANBasicVariableAccessTypeWrite];
        destinationValue = [[ANBasicNumberObject alloc] initWithNumber:destination];
        stepValue = [[ANBasicNumberObject alloc] initWithNumber:step];
        codeBlock = [[ANBasicBlockObject alloc] initWithSubBlocks:[NSArray array]
                                                      printOutput:NO];
    }
    return self;
}

@end
