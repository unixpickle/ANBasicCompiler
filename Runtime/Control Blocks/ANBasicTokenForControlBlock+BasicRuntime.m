//
//  ANBasicTokenForControlBlock+BasicRuntime.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenForControlBlock+BasicRuntime.h"

@implementation ANBasicTokenForControlBlock (BasicRuntime)

- (BOOL)executeToken:(ANBasicRuntimeState *)state {
    NSString * theVariable = self.counterVariable.variableName;
    
    if (![self.initialBlock executeToken:state]) return NO;
    if ([state returnType] != ANBasicRuntimeReturnTypeValue) return NO;
    [state setValue:[state returnNumber] forVariableName:theVariable];
    
    if (![self.destinationBlock executeToken:state]) return NO;
    if ([state returnType] != ANBasicRuntimeReturnTypeValue) return NO;
    double destination = [state returnNumber];
    
    double step = (self.stepValue ? [self.stepValue.numberValue doubleValue] : 1);
    while (true) {
        if (step > 0 && [state valueForVariableName:theVariable] > destination) break;
        if (step < 0 && [state valueForVariableName:theVariable] < destination) break;
        if (![self.loopBody executeToken:state]) return NO;
        if ([state returnType] != ANBasicRuntimeReturnTypeValue) break;
        
        double oldVal = [state valueForVariableName:theVariable];
        [state setValue:(oldVal + step) forVariableName:theVariable];
    }
    
    if ([state returnType] == ANBasicRuntimeReturnTypeBreak) {
        // they have successfully broken from a loop!
        [state resetReturnState];
    }
    
    return YES;
}

@end
