//
//  ANBasicTokenForControlBlock.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenControlBlock.h"
#import "ANBasicTokenControl.h"
#import "ANBasicTokenBlock.h"
#import "ANBasicTokenNumber.h"
#import "ANBasicTokenOperator.h"
#import "ANBasicTokenVariable.h"

@interface ANBasicTokenForControlBlock : ANBasicTokenControlBlock {
    ANBasicTokenBlock * initialBlock;
    ANBasicTokenVariable * counterVariable;
    ANBasicTokenBlock * destinationBlock;
    ANBasicTokenNumber * stepValue;
    ANBasicTokenBlock * loopBody;
}

@property (nonatomic, strong) ANBasicTokenBlock * initialBlock;
@property (nonatomic, strong) ANBasicTokenVariable * counterVariable;
@property (nonatomic, strong) ANBasicTokenBlock * destinationBlock;
@property (nonatomic, strong) ANBasicTokenNumber * stepValue;
@property (nonatomic, strong) ANBasicTokenBlock * loopBody;

+ (BOOL)isLineForBlock:(ANBasicTokenBlock *)aBlock;
- (id)initWithForHeader:(ANBasicTokenBlock *)forHeader;

@end
