//
//  ANBasicTokenizer.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANBasicTokenNumber.h"
#import "ANBasicTokenFunction.h"
#import "ANBasicTokenControl.h"
#import "ANBasicTokenOperator.h"
#import "ANBasicTokenVariable.h"
#import "ANBasicTokenString.h"

#define ANBufferUnderflowException @"ANBufferUnderflowException"

@interface ANBasicTokenizer : NSObject {
    NSString * string;
    NSUInteger offset;
}

@property (readonly) NSString * string;
@property (readwrite) NSUInteger offset;

- (id)initWithString:(NSString *)aString offset:(NSUInteger)initial;

/**
 * @return The number of characters left for reading after and including
 * the character to which the offset points.
 */
- (NSUInteger)available;

/**
 * Read until a character in a specified set, and returned the text that
 * was read. This is equivalent to calling readUntilCharacterInSet:inclusive:
 * with inclusive set to NO.
 * @param charSet Any character in this set will terminate the end of the read.
 */
- (NSString *)readUntilCharacterInSet:(NSCharacterSet *)charSet;

/**
 * Read until a character in a specified set, and returned the text that
 * was read.
 * @param charSet Any character in this set will terminate the end of the read.
 * @param inclusive If this is YES, then the string returned will contain the terminator
 * string, and the offset will be set to after the termination character. Otherwise, the
 * termination character will not be "read", and will be pointed to by the current offset.
 */
- (NSString *)readUntilCharacterInSet:(NSCharacterSet *)charSet inclusive:(BOOL)inclusive;

/**
 * Reads until a character that is not in a specified character set is reached.
 * @param charSet The character set to use for chomping. If a character that is not in this
 * character set is reached, this method will return YES.
 * @return YES if a character that was not in the specified character set was encountered.
 * This will only return NO if the end of buffer was reached and no characters were found other
 * than those in the character set.
 * @discussion Upon return, the offset of will either point to the end of the buffer, or
 * to the first character that was not in the character set.
 */
- (BOOL)chompCharactersInSet:(NSCharacterSet *)charSet;

/**
 * Intelligently reads a token of ANBasic code. This will read an operator, function name,
 * numerical value, new line, etc.
 */
- (ANBasicToken *)readNextToken;

/**
 * Reads until a non-numerical character is encountered. Essentially, this will read numbers
 * from 0-9, and decimal points.
 */
- (NSString *)readNumericalToken;

/**
 * Reads until a non-alpha character. That is, this reads all characters from a-z, A-Z, and
 * the # character (for the Ran# function).
 */
- (NSString *)readNameToken;

/**
 * Reads the next (and longest as possible) operator from the buffer.
 */
- (NSString *)readOperatorToken;

/**
 * Reads the next string token, that is, until a closing " is found.
 */
- (NSString *)readStringToken;

@end
