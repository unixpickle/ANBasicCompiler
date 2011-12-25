//
//  ANBasicTokenEOF.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenBlock.h"

/**
 * This is a concrete ANBasicToken subclass that represents the end of a script.
 * This token will not exist in script representations after or before grouping, and will
 * only be returned by grouping-related methods when the end-of-script has been reached.
 */
@interface ANBasicTokenEOF : ANBasicTokenBlock

+ (ANBasicTokenEOF *)eofToken;

@end
