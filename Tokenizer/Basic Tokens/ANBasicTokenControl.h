//
//  ANBasicTokenControl.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"

@interface ANBasicTokenControl : ANBasicToken {
    NSString * controlName;
}

@property (readonly) NSString * controlName;

+ (BOOL)isControlName:(NSString *)aTokenString;
- (id)initWithControlName:(NSString *)aName;
- (BOOL)isNewBlockControl;

@end
