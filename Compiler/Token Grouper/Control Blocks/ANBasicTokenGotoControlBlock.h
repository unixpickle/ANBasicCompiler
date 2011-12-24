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

@interface ANBasicTokenGotoControlBlock : ANBasicTokenControlBlock {
    ANBasicTokenBlock * jumpLocation;
}

@property (nonatomic, strong) ANBasicTokenBlock * jumpLocation;

+ (BOOL)isLineGotoBlock:(ANBasicTokenBlock *)aBlock;
- (id)initWithGotoBlock:(ANBasicTokenBlock *)aBlock;

@end
