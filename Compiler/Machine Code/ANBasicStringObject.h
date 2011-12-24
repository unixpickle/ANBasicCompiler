//
//  ANBasicStringObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicCodeObject.h"

@interface ANBasicStringObject : ANBasicCodeObject {
    NSString * stringValue;
}

@property (readonly) NSString * stringValue;

- (id)initWithStringValue:(NSString *)aString;

@end
