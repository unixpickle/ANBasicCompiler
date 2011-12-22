//
//  ANBasicTokenIfControlBlock.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenControlBlock.h"
#import "ANBasicTokenControl.h"
#import "ANBasicTokenBlock.h"

@interface ANBasicTokenIfControlBlock : ANBasicTokenControlBlock {
    ANBasicTokenBlock * condition;
    ANBasicTokenBlock * mainBody;
    ANBasicTokenBlock * elseBody;
}

@property (nonatomic, strong) ANBasicTokenBlock * condition;
@property (nonatomic, strong) ANBasicTokenBlock * mainBody;
@property (nonatomic, strong) ANBasicTokenBlock * elseBody;

+ (BOOL)isLineIfStatement:(ANBasicTokenBlock *)lineBlock;

@end
