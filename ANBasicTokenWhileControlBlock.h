//
//  ANBasicTokenWhileControlBlock.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenControlBlock.h"
#import "ANBasicTokenBlock.h"
#import "ANBasicTokenControl.h"

@interface ANBasicTokenWhileControlBlock : ANBasicTokenControlBlock {
    ANBasicTokenBlock * condition;
    ANBasicTokenBlock * loopBody;
}

@property (nonatomic, strong) ANBasicTokenBlock * condition;
@property (nonatomic, strong) ANBasicTokenBlock * loopBody;

+ (BOOL)isLineWhileBlock:(ANBasicTokenBlock *)codeLine;

@end
