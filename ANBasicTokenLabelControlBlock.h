//
//  ANBasicTokenGotoControlBlock.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenControlBlock.h"
#import "ANBasicTokenBlock.h"
#import "ANBasicTokenControl.h"
#import "ANBasicTokenNumber.h"

@interface ANBasicTokenLabelControlBlock : ANBasicTokenControlBlock {
    ANBasicTokenNumber * labelNumber;
}

@property (nonatomic, strong) ANBasicTokenNumber * labelNumber;

+ (BOOL)isLineLabelBlock:(ANBasicTokenBlock *)aBlock;
- (id)initWithLabelBlock:(ANBasicTokenBlock *)aBlock;

@end
