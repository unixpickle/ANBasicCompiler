//
//  ANBasicToken+MCObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicToken.h"
#import "ANBasicMCObject.h"

@interface ANBasicToken (MCObject) <ANBasicMCObject>

- (UInt8)machineCodeType;

@end
