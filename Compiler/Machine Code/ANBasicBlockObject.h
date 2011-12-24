//
//  ANBasicBlockObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicCodeObject.h"

@interface ANBasicBlockObject : ANBasicCodeObject {
    BOOL printOutput;
    NSMutableArray * subBlocks;
}

@property (readonly) BOOL printOutput;
@property (readonly) NSMutableArray * subBlocks;

- (id)initWithSubBlocks:(NSArray *)theBlocks printOutput:(BOOL)flag;

@end
