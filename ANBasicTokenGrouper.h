//
//  ANBasicCompiler.h
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANBasicTokenizedScript.h"
#import "ANBasicTokenBlock.h"
#import "ANBasicTokenIfControlBlock.h"
#import "ANBasicTokenWhileControlBlock.h"
#import "ANBasicTokenForControlBlock.h"
#import "ANBasicTokenLabelControlBlock.h"
#import "ANBasicTokenGotoControlBlock.h"
#import "ANBasicTokenEOF.h"

@interface ANBasicTokenGrouper : NSObject {
    ANBasicTokenizedScript * script;
    NSUInteger offset;
}

@property (readonly) ANBasicTokenizedScript * script;
@property (readonly) NSUInteger offset;

- (id)initWithScript:(ANBasicTokenizedScript *)aScript;

/**
 * Reads the next token in the script.
 * @return The next token that is available in the script, or an instance of ANBasicTokenEOF
 * if the end-of-script has been reached.
 */
- (ANBasicToken *)nextToken;

/**
 * Reads until a close parenthasis
 * @return A block of code within parentheses, or nil if no close parenthasis was found.
 */
- (ANBasicTokenBlock *)readParenthasized;

/**
 * Reads tokens until a new line character is reached.
 * @return A block of code, or ANBasicTokenEOF if there were no more tokens
 * in the file. This may also return nil, if an error was encountered.
 */
- (ANBasicTokenBlock *)readLine;

/**
 * Converts minus operators to negation functions where approriate.
 */
- (BOOL)functionizeNegatives:(ANBasicTokenBlock *)block;

/**
 * Goes from left to right and embeds exponentials in sub-blocks. Also applies
 * functions to corresponding arguments.
 */
- (BOOL)groupFunctionsAndExponents:(ANBasicTokenBlock *)block;

- (BOOL)groupMultiplicationDivision:(ANBasicTokenBlock *)block;
- (BOOL)groupAdditionSubtraction:(ANBasicTokenBlock *)block;
- (BOOL)groupComparators:(ANBasicTokenBlock *)block;

/**
 * Read a control block. This is equivalent to calling
 * readUntilControlTerminators:terminator:terminatingLine: and passing nil for the
 * terminatingLine argument.
 */
- (ANBasicTokenBlock *)readUntilControlTerminators:(NSArray *)controlNames
                                        terminator:(ANBasicTokenControl * __autoreleasing *)control;

/**
 * Read a control block of zero or more lines, up to a terminator. If no terminator is found,
 * this will read until the end-of-script is reached.
 * @param controlNames An array of NSStrings that are valid terminators for this control block.
 * @param control An out-parameter that will be set if a terminating control token is found.
 * @param termLine An out-parameter that will be set to the line containing the terminating control
 * token, if a terminating control token is encountered.
 * @return Upon success, this method will return a block containing the lines up to the control
 * terminator. This will be an instance of ANBasicTokenEOF if the end-of-script was reached before
 * any tokens could be read, or nil if an error was encountered.
 */
- (ANBasicTokenBlock *)readUntilControlTerminators:(NSArray *)controlNames
                                        terminator:(ANBasicTokenControl * __autoreleasing *)control
                                   terminatingLine:(ANBasicTokenBlock * __autoreleasing *)termLine;

/**
 * Given a line block that has just been read, this method can be used to expand a control block,
 * and returns the encoded block as a token. If the line does not head a control block, the original line
 * will be returned as a token block.
 */
- (ANBasicToken *)readSubBlockOrReturn:(ANBasicTokenBlock *)line;

// specialized control blocks
- (ANBasicTokenIfControlBlock *)readIfStatement:(ANBasicTokenBlock *)ifStatementHeader;
- (ANBasicTokenWhileControlBlock *)readWhileLoop:(ANBasicTokenBlock *)whileHeader;
- (ANBasicTokenForControlBlock *)readForLoop:(ANBasicTokenBlock *)forHeader;

- (BOOL)skipPastControlBlock:(NSString *)controlName;

/**
 * Reads all of the lines in the script, and puts them in a root block.
 * This will have the order of operations met, negatives handled as functions,
 * functions grouped in code blocks of their own (as to meet the order of operations).
 * @discussion This is equivalent to calling -readUntilControlTerminators: and passing
 * an empty array for controlNames.
 */
- (ANBasicTokenBlock *)readScriptBlock;

@end
