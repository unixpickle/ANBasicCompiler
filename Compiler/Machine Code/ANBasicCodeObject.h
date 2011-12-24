//
//  ANBasicCodeObject.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ANBasicCodeObjectTypeCode = 0,
    ANBasicCodeObjectTypeString = 1,
    ANBasicCodeObjectTypeVariable = 2,
    ANBasicCodeObjectTypeNumber = 3,
    ANBasicCodeObjectTypeOperator = 4,
    ANBasicCodeObjectTypeFunction = 5,
    ANBasicCodeObjectTypeControl = 6
} ANBasicCodeObjectType;

@interface ANBasicCodeObject : NSObject {
    UInt8 basicHeader;
}

@property (readwrite) UInt8 basicHeader;

/**
 * Retrieves the object type from the basicHeader
 * @return The highest three bits of the basic header, and shifts them.
 */
- (ANBasicCodeObjectType)objectType;

/**
 * Sets the object type of the basicHeader
 * @param objectType The type to set as the highest three bits of the
 * basicHeader field.
 */
- (void)setObjectType:(ANBasicCodeObjectType)objectType;

- (UInt8)additionalInfo;
- (void)setAdditionalInfo:(UInt8)info;

@end
