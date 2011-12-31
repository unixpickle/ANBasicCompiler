//
//  main.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANBasicTokenizedScript.h"
#import "ANBasicTokenGrouper.h"
#import "ANBasicToken+MCObject.h"

int printUsage (const char * cmdName);
int compileMain (NSString * inputFile, NSString * outputFile, const char * cmdName);

int main (int argc, const char * argv[]) {
    @autoreleasepool {
        // my debug code, so that I can execute this through Xcode and test it
        // with my ANBasic script:
        //
        return compileMain(@"/Users/alex/Desktop/sqrtprogram", @"/Users/alex/Desktop/sqrtprogram.bin", "anbc");
        
        /*
        if (argc == 1) {
            return printUsage(argv[0]);
        }
        
        NSString * inputFile = [NSString stringWithUTF8String:argv[1]];
        NSString * outputFile = @"a.bsc";
        for (int i = 2; i < argc; i++) {
            if (strcmp(argv[i], "-o") == 0) {
                if (i + 1 == argc) return printUsage(argv[0]);
                outputFile = [NSString stringWithUTF8String:argv[i + 1]];
            }
        }
        
        return compileMain(inputFile, outputFile, argv[0]);
         */
    }
}

int printUsage (const char * cmdName) {
    fprintf(stderr, "Usage: %s input [-o output]\n", cmdName);
    return 1;
}

int compileMain (NSString * inputFile, NSString * outputFile, const char * cmdName) {
    NSString * fileContents = [[NSString alloc] initWithContentsOfFile:inputFile
                                                              encoding:NSASCIIStringEncoding
                                                                 error:nil];
    if (!fileContents) {
        fprintf(stderr, "%s: error: failed to read input file\n", cmdName);
        return 1;
    }
    
    ANBasicTokenizedScript * tokenized = [[ANBasicTokenizedScript alloc] initWithScript:fileContents];
    if (!tokenized || [[tokenized tokens] count] == 0) {
        fprintf(stderr, "%s: error: parse failed\n", cmdName);
        return 1;
    }
    
    ANBasicTokenGrouper * grouper = [[ANBasicTokenGrouper alloc] initWithScript:tokenized];
    ANBasicTokenBlock * block = [grouper readScriptBlock];
    if (!block) {
        fprintf(stderr, "%s: error: code group failed\n", cmdName);
        return 1;
    }
    NSLog(@"%@", block);
    
    ANBasicByteBuffer * buffer = [[ANBasicByteBuffer alloc] init];
    if (![block encodeToBuffer:buffer]) {
        fprintf(stderr, "%s: error: failed to encode machine code\n", cmdName);
        return 1;
    }
    
    [[buffer data] writeToFile:outputFile atomically:YES];
    
    [buffer setOffset:0];
    UInt8 typeByte = [buffer readByte];
    ANBasicTokenBlock * decoded = (id)[ANBasicTokenBlock decodeFromBuffer:buffer type:typeByte];
    
    NSLog(@"Decoded: %@", decoded);
    
    return 0;
}

