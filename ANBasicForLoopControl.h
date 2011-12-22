//
//  ANBasicForLoopControl.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicControlObject.h"
#import "ANBasicBlockObject.h"
#import "ANBasicNumberObject.h"
#import "ANBasicVariableObject.h"

@interface ANBasicForLoopControl : ANBasicControlObject {
    ANBasicNumberObject * initialValue;
    ANBasicVariableObject * counterVariable;
    ANBasicNumberObject * destinationValue;
    ANBasicNumberObject * stepValue;
    ANBasicBlockObject * codeBlock;
}

@property (readonly) ANBasicNumberObject * initialValue;
@property (readonly) ANBasicVariableObject * counterVariable;
@property (readonly) ANBasicNumberObject * destinationValue;
@property (readonly) ANBasicNumberObject * stepValue;
@property (readonly) ANBasicBlockObject * codeBlock;

- (id)initWithInitial:(NSNumber *)initial
          destination:(NSNumber *)destination
              counter:(NSString *)variableName
                 step:(NSNumber *)step;

@end
