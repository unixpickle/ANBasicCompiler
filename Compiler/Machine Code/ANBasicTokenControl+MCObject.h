//
//  ANBasicTokenControl+MCObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenControl.h"
#import "ANBasicToken+MCObject.h"

#define ANBasicMCObjectControlType 7

typedef enum {
    ANBasicTokenControlIDBreak = 0,
    ANBasicTokenControlIDStop = 1,
    ANBasicTokenControlIDNotFound = 2
} ANBasicTokenControlID;

@interface ANBasicTokenControl (MCObject) <ANBasicMCObject>

+ (ANBasicTokenControlID)controlIDForName:(NSString *)theName;
+ (NSString *)controlNameForID:(ANBasicTokenControlID)theID;

@end
