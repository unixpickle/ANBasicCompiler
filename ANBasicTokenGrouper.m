//
//  ANBasicCompiler.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenGrouper.h"

@implementation ANBasicTokenGrouper

@synthesize script;
@synthesize offset;

- (id)initWithScript:(ANBasicTokenizedScript *)aScript {
    if ((self = [super init])) {
        script = aScript;
    }
    return self;
}

- (ANBasicToken *)nextToken {
    if (offset == [script.tokens count]) return [ANBasicTokenEOF eofToken];
    return [script.tokens objectAtIndex:offset++];
}

- (ANBasicTokenBlock *)readParenthasized {
    ANBasicToken * token = nil;
    ANBasicTokenBlock * block = [[ANBasicTokenBlock alloc] init];
    
    while (![(token = [self nextToken]) isKindOfClass:[ANBasicTokenEOF class]]) {
        BOOL specialToken = NO;
        
        if ([token isKindOfClass:[ANBasicTokenOperator class]]) {
            if ([[(ANBasicTokenOperator *)token operatorName] isEqualToString:@")"]) {
                return block;
            } else if ([[(ANBasicTokenOperator *)token operatorName] isEqualToString:@"("]) {
                ANBasicTokenBlock * subBlock = [self readParenthasized];
                if (!subBlock) return nil;
                [[block tokens] addObject:subBlock];
                specialToken = YES;
            }
        }
        
        if (!specialToken) [[block tokens] addObject:token];
    }
    
    // if this point has been reached, then we have hit end-of-script before a close parenthesis.
    // this means that the script is invalid, and thus we return nil to indicate an error.
    return nil;
}

- (ANBasicTokenBlock *)readLine {
    ANBasicToken * token = nil;
    ANBasicTokenBlock * block = [[ANBasicTokenBlock alloc] init];
    
    // loop until a new line character is encountered
    // if a new line is not found, and end-of-script is reached, this loop will break
    // without returning.
    while (![(token = [self nextToken]) isKindOfClass:[ANBasicTokenEOF class]]) {
        BOOL specialToken = NO;
        
        if ([token isKindOfClass:[ANBasicTokenOperator class]]) {
            if ([[(ANBasicTokenOperator *)token operatorName] isEqualToString:@"("]) {
                ANBasicTokenBlock * subBlock = [self readParenthasized];
                if (!subBlock) return nil;
                [[block tokens] addObject:subBlock];
                specialToken = YES;
            }
        } else if ([token isKindOfClass:[ANBasicTokenControl class]]) {
            ANBasicTokenControl * control = (ANBasicTokenControl *)token;
            NSString * controlName = [control controlName];
            // if it is the end of the line, we will reutrn the block as planned
            if ([control isNewBlockControl]) {
                if ([controlName isEqualToString:@";"]) {
                    [block setPrintOutput:YES];
                }
                return block;
            }
        }
        
        if (!specialToken) [[block tokens] addObject:token];
    }
    
    // if the block has no tokens, then there are no more tokens left in the file to be
    // read, and therefore we are responsible to return ANBasicTokenEOF.
    if ([[block tokens] count] == 0) return [ANBasicTokenEOF eofToken];
    
    // if the block contains more than zero tokens, then this is the last line of the script,
    // but there is still some code on it that needs to be returned.
    return block;
}

- (ANBasicTokenBlock *)readUntilControlTerminators:(NSArray *)controlNames terminator:(ANBasicTokenControl * __autoreleasing *)_control terminatingLine:(ANBasicTokenBlock * __autoreleasing *)termLine {
    ANBasicTokenBlock * block = [[ANBasicTokenBlock alloc] init];
    ANBasicTokenBlock * nextLine = nil;
    while (![(nextLine = [self readLine]) isKindOfClass:[ANBasicTokenEOF class]]) {
        if (!nextLine) return nil;
        
        // group up line before performing inter-line grouping
        if (![self functionizeNegatives:nextLine]) return nil;
        if (![self groupFunctionsAndExponents:nextLine]) return nil;
        if (![self groupMultiplicationDivision:nextLine]) return nil;
        if (![self groupAdditionSubtraction:nextLine]) return nil;
        if (![self groupComparators:nextLine]) return nil;
        
        // check if the line is a terminator for the control block
        if ([[nextLine tokens] count] != 0) {
            ANBasicToken * potentialControl = [nextLine firstToken];
            if ([potentialControl isKindOfClass:[ANBasicTokenControl class]]) {
                ANBasicTokenControl * control = (ANBasicTokenControl *)potentialControl;
                if ([controlNames containsObject:[control controlName]]) {
                    if (_control) *_control = control;
                    if (termLine) *termLine = nextLine;
                    return block;
                }
            }
        }
        
        ANBasicToken * token = [self readSubBlockOrReturn:nextLine];
        if (!token) return nil;
        [[block tokens] addObject:token];
    }
    
    if (nextLine == nil) return nil;
    if ([[block tokens] count] == 0) return [ANBasicTokenEOF eofToken];
    
    // the block extends to the end of the script, but it is not empty
    return block;
}

- (ANBasicTokenBlock *)readUntilControlTerminators:(NSArray *)controlNames
                                        terminator:(ANBasicTokenControl * __autoreleasing *)control {
    return [self readUntilControlTerminators:controlNames terminator:control terminatingLine:nil];
}

#pragma mark Control Blocks

- (ANBasicToken *)readSubBlockOrReturn:(ANBasicTokenBlock *)line {
    if ([ANBasicTokenIfControlBlock isLineIfStatement:line]) {
        return [self readIfStatement:line];
    } else if ([ANBasicTokenWhileControlBlock isLineWhileBlock:line]) {
        return [self readWhileLoop:line];
    } else if ([ANBasicTokenForControlBlock isLineForBlock:line]) {
        return [self readForLoop:line];
    } else if ([ANBasicTokenLabelControlBlock isLineLabelBlock:line]) {
        return [[ANBasicTokenLabelControlBlock alloc] initWithLabelBlock:line];
    } else if ([ANBasicTokenGotoControlBlock isLineGotoBlock:line]) {
        return [[ANBasicTokenGotoControlBlock alloc] initWithGotoBlock:line];
    } else {
        // normal line, no need to read additional lines
       return line;
    }
}

- (ANBasicTokenIfControlBlock *)readIfStatement:(ANBasicTokenBlock *)ifStatementHeader {
    [ifStatementHeader removeFirstToken];
    
    ANBasicTokenIfControlBlock * ifBlock = [[ANBasicTokenIfControlBlock alloc] init];
    [ifBlock setCondition:ifStatementHeader];
    
    if (![self skipPastControlBlock:@"Then"]) return nil;
    
    // read until endif or else
    NSArray * elseEndif = [NSArray arrayWithObjects:@"Else", @"IfEnd", nil];
    ANBasicTokenControl * terminatingControl = nil;
    ANBasicTokenBlock * termLine = nil;
    
    ANBasicTokenBlock * block = [self readUntilControlTerminators:elseEndif
                                                       terminator:&terminatingControl
                                                  terminatingLine:&termLine];
    
    if (!block || [block isKindOfClass:[ANBasicTokenEOF class]]) {
        return nil;
    }
    
    // the first token in an if statement must be a "Then" token
    /*
    ANBasicToken * firstToken = [block firstToken];
    if (![firstToken isKindOfClass:[ANBasicTokenControl class]]) {
        return nil;
    }
    if (![[(ANBasicTokenControl *)firstToken controlName] isEqualToString:@"Then"]) {
        return nil;
    }
    
    // since the "Then" control token doesn't serve a real purpose, we will remove it
    // for convenience
    [block removeFirstToken];
    */
    
    [ifBlock setMainBody:block];
    
    if (terminatingControl && [[terminatingControl controlName] isEqualToString:@"Else"]) {
        // the control line begins the else block, and thus, we remove the Else token itself
        [termLine removeFirstToken];
        
        // now, read the line as if it was a normal line in the script
        ANBasicToken * startElseToken = [self readSubBlockOrReturn:termLine];
        
        NSArray * ifEnd = [NSArray arrayWithObject:@"IfEnd"];
        ANBasicTokenBlock * elseBlock = [self readUntilControlTerminators:ifEnd
                                                               terminator:nil];
        if (!elseBlock) {
            return nil;
        }
        // if the else block is empty because the end-of-script has been reached,
        // we will create an empty, regular else block
        if ([elseBlock isKindOfClass:[ANBasicTokenEOF class]]) {
            elseBlock = [[ANBasicTokenBlock alloc] init];
        }
        
        [elseBlock.tokens insertObject:startElseToken atIndex:0];
        [ifBlock setElseBody:elseBlock];
    }
    
    return ifBlock;
}

- (ANBasicTokenWhileControlBlock *)readWhileLoop:(ANBasicTokenBlock *)whileHeader {
    ANBasicTokenWhileControlBlock * whileBlock = [[ANBasicTokenWhileControlBlock alloc] init];
    [whileHeader removeFirstToken];
    [whileBlock setCondition:whileHeader];
    
    NSArray * whileEnd = [NSArray arrayWithObject:@"WhileEnd"];
    ANBasicTokenBlock * whileBody = [self readUntilControlTerminators:whileEnd
                                                           terminator:nil];
    
    if (!whileBody || [whileBody isKindOfClass:[ANBasicTokenEOF class]]) return nil;
    [whileBlock setLoopBody:whileBody];
    return whileBlock;
}

- (ANBasicTokenForControlBlock *)readForLoop:(ANBasicTokenBlock *)forHeader {
    ANBasicTokenForControlBlock * forBlock = [[ANBasicTokenForControlBlock alloc] initWithForHeader:forHeader];
    if (!forBlock) return nil;
    
    NSArray * next = [NSArray arrayWithObject:@"Next"];
    ANBasicTokenBlock * forBody = [self readUntilControlTerminators:next
                                                         terminator:nil];
    
    if (!forBody || [forBody isKindOfClass:[ANBasicTokenEOF class]]) return nil;
    [forBlock setLoopBody:forBody];
    return forBlock;
}

- (BOOL)skipPastControlBlock:(NSString *)controlName {
    ANBasicToken * token = nil;
    while (![(token = [self nextToken]) isKindOfClass:[ANBasicTokenEOF class]]) {
        if ([token isKindOfClass:[ANBasicTokenControl class]]) {
            ANBasicTokenControl * control = (ANBasicTokenControl *)token;
            if ([[control controlName] isEqualToString:controlName]) return YES;
        }
    }
    return NO;
}

#pragma mark Per-Line Grouping

- (BOOL)functionizeNegatives:(ANBasicTokenBlock *)block {
    BOOL negOperatorValid = NO;
    for (NSUInteger i = 0; i < [block.tokens count]; i++) {
        ANBasicToken * token = [block.tokens objectAtIndex:i];
        if ([token isKindOfClass:[ANBasicTokenBlock class]]) {
            [self functionizeNegatives:(ANBasicTokenBlock *)token];
            negOperatorValid = YES;
        } else if ([token isKindOfClass:[ANBasicTokenFunction class]]) {
            ANBasicTokenFunction * funct = (ANBasicTokenFunction *)token;
            if ([funct functionTakesArgument]) {
                negOperatorValid = NO;
            } else negOperatorValid = YES;
        } else if ([token isKindOfClass:[ANBasicTokenOperator class]]) {
            ANBasicTokenOperator * operator = (ANBasicTokenOperator *)token;
            BOOL isNegative = [[operator operatorName] isEqualToString:@"-"];
            if (isNegative && !negOperatorValid) {
                // functionize the negative
                ANBasicTokenFunction * function = [[ANBasicTokenFunction alloc] initWithFunctionName:@"-"];
                [block.tokens replaceObjectAtIndex:i withObject:function];
            }
            negOperatorValid = NO;
        } else {
            negOperatorValid = YES;
        }
    }
    return YES;
}

- (BOOL)groupFunctionsAndExponents:(ANBasicTokenBlock *)block {
    for (NSInteger i = [block.tokens count] - 1; i >= 0; i--) {
        ANBasicToken * token = [block.tokens objectAtIndex:i];
        if ([token isKindOfClass:[ANBasicTokenOperator class]]) {
            ANBasicTokenOperator * operator = (ANBasicTokenOperator *)token;
            if ([[operator operatorName] isEqualToString:@"^"]) {
                if (i + 1 == [block.tokens count] || i - 1 < 0) {
                    return NO;
                }
                
                // group the previous expression with the next one with an exponent
                // operator 
                ANBasicToken * lastToken = [block.tokens objectAtIndex:i - 1];
                ANBasicToken * nextToken = [block.tokens objectAtIndex:i + 1];
                
                NSArray * tokenArray = [NSArray arrayWithObjects:lastToken, operator, nextToken, nil];
                ANBasicTokenBlock * powerGroup = [[ANBasicTokenBlock alloc] initWithTokens:tokenArray];
                [block.tokens removeObjectAtIndex:i + 1];
                [block.tokens removeObjectAtIndex:i];
                [block.tokens replaceObjectAtIndex:(i - 1) withObject:powerGroup];
                i--;
            }
        } else if ([token isKindOfClass:[ANBasicTokenFunction class]]) {
            ANBasicTokenFunction * function = (ANBasicTokenFunction *)token;
            if ([function functionTakesArgument] && ![function hasBeenGrouped]) {
                if (i + 1 == [block.tokens count]) {
                    return NO;
                }
                
                ANBasicToken * argument = [block.tokens objectAtIndex:i + 1];
                [function setGroupedToken:argument];
                [function setHasBeenGrouped:YES];
                [block.tokens removeObjectAtIndex:i + 1];
            }
        } else if ([token isKindOfClass:[ANBasicTokenBlock class]]) {
            if (![self groupFunctionsAndExponents:(ANBasicTokenBlock *)token]) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)groupMultiplicationDivision:(ANBasicTokenBlock *)block {
    for (NSInteger i = [block.tokens count] - 1; i >= 0; i--) {
        ANBasicToken * token = [block.tokens objectAtIndex:i];
        if ([token isKindOfClass:[ANBasicTokenOperator class]]) {
            ANBasicTokenOperator * operator = (ANBasicTokenOperator *)token;
            if ([[operator operatorName] isEqualToString:@"/"] || [[operator operatorName] isEqualToString:@"*"]) {
                if (i + 1 == [block.tokens count] || i - 1 < 0) {
                    return NO;
                }
                
                // group the previous expression with the next one with an exponent
                // operator 
                ANBasicToken * lastToken = [block.tokens objectAtIndex:i - 1];
                ANBasicToken * nextToken = [block.tokens objectAtIndex:i + 1];
                
                NSArray * tokenArray = [NSArray arrayWithObjects:lastToken, operator, nextToken, nil];
                ANBasicTokenBlock * powerGroup = [[ANBasicTokenBlock alloc] initWithTokens:tokenArray];
                [block.tokens removeObjectAtIndex:i + 1];
                [block.tokens removeObjectAtIndex:i];
                [block.tokens replaceObjectAtIndex:(i - 1) withObject:powerGroup];
                i--;
            }
        } else if ([token isKindOfClass:[ANBasicTokenBlock class]]) {
            if (![self groupMultiplicationDivision:(ANBasicTokenBlock *)token]) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)groupAdditionSubtraction:(ANBasicTokenBlock *)block {
    for (NSInteger i = [block.tokens count] - 1; i >= 0; i--) {
        ANBasicToken * token = [block.tokens objectAtIndex:i];
        if ([token isKindOfClass:[ANBasicTokenOperator class]]) {
            ANBasicTokenOperator * operator = (ANBasicTokenOperator *)token;
            if ([[operator operatorName] isEqualToString:@"-"] || [[operator operatorName] isEqualToString:@"+"]) {
                if (i + 1 == [block.tokens count] || i - 1 < 0) {
                    return NO;
                }
                
                // group the previous expression with the next one with an exponent
                // operator 
                ANBasicToken * lastToken = [block.tokens objectAtIndex:i - 1];
                ANBasicToken * nextToken = [block.tokens objectAtIndex:i + 1];
                
                NSArray * tokenArray = [NSArray arrayWithObjects:lastToken, operator, nextToken, nil];
                ANBasicTokenBlock * powerGroup = [[ANBasicTokenBlock alloc] initWithTokens:tokenArray];
                [block.tokens removeObjectAtIndex:i + 1];
                [block.tokens removeObjectAtIndex:i];
                [block.tokens replaceObjectAtIndex:(i - 1) withObject:powerGroup];
                i--;
            }
        } else if ([token isKindOfClass:[ANBasicTokenBlock class]]) {
            if (![self groupAdditionSubtraction:(ANBasicTokenBlock *)token]) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)groupComparators:(ANBasicTokenBlock *)block {
    for (NSInteger i = [block.tokens count] - 1; i >= 0; i--) {
        ANBasicToken * token = [block.tokens objectAtIndex:i];
        if ([token isKindOfClass:[ANBasicTokenOperator class]]) {
            ANBasicTokenOperator * operator = (ANBasicTokenOperator *)token;
            if ([operator isComparatorOperator]) {
                if (i + 1 == [block.tokens count] || i - 1 < 0) {
                    return NO;
                }
                
                // group the previous expression with the next one with an exponent
                // operator 
                ANBasicToken * lastToken = [block.tokens objectAtIndex:i - 1];
                ANBasicToken * nextToken = [block.tokens objectAtIndex:i + 1];
                
                NSArray * tokenArray = [NSArray arrayWithObjects:lastToken, operator, nextToken, nil];
                ANBasicTokenBlock * powerGroup = [[ANBasicTokenBlock alloc] initWithTokens:tokenArray];
                [block.tokens removeObjectAtIndex:i + 1];
                [block.tokens removeObjectAtIndex:i];
                [block.tokens replaceObjectAtIndex:(i - 1) withObject:powerGroup];
                i--;
            }
        } else if ([token isKindOfClass:[ANBasicTokenBlock class]]) {
            if (![self groupComparators:(ANBasicTokenBlock *)token]) {
                return NO;
            }
        }
    }
    return YES;
}

#pragma mark Utility

- (ANBasicTokenBlock *)readScriptBlock {
    return [self readUntilControlTerminators:[NSArray array]
                                  terminator:nil];
}

@end
