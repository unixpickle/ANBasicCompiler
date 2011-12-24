//
//  ANBasicTokenizedScript.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANBasicTokenizer.h"

@interface ANBasicTokenizedScript : NSObject {
    NSArray * tokens;
}

@property (readonly) NSArray * tokens;

- (id)initWithScript:(NSString *)scriptBody;

@end
