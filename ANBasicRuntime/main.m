//
//  main.m
//  ANBasicRuntime
//
//  Created by Alex Nichol on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANBasicToken+MCObject.h"
#import "ANBasicToken+BasicRuntime.h"

int runtimeMain (const char * cmdName, NSString * scriptName);

int main (int argc, const char * argv[]) {
    @autoreleasepool {
        //runtimeMain("anbrun", @"/Users/alex/Desktop/sqrtprogram.bin");
        
        if (argc != 2) {
            fprintf(stderr, "Usage: %s <compiled script>\n", argv[0]);
            return 1;
        }
        NSString * scriptPath = [NSString stringWithUTF8String:argv[1]];
        return runtimeMain(argv[0], scriptPath);
    }
    return 0;
}

int runtimeMain (const char * cmdName, NSString * scriptName) {
    NSData * fileData = [[NSData alloc] initWithContentsOfFile:scriptName];
    if (!fileData) {
        fprintf(stderr, "%s: error: failed to read input file\n", cmdName);
        return 1;
    }
    
    if ([fileData length] == 0) {
        return 0;
    }
    
    ANBasicByteBuffer * byteBuffer = [[ANBasicByteBuffer alloc] initWithData:fileData];
    UInt8 typeByte = [byteBuffer readByte];
    ANBasicToken * token = (ANBasicToken *)[ANBasicToken decodeFromBuffer:byteBuffer type:typeByte];
    
    if (!token) {
        fprintf(stderr, "%s: error: failed to decode input file\n", cmdName);
        return 1;
    }
    
    ANBasicRuntimeState * runState = [[ANBasicRuntimeState alloc] init];
    
    if (![token executeToken:runState]) {
        fprintf(stderr, "%s: error: execution failed\n", cmdName);
        return 1;
    }
    
    NSString * resultStr = [NSString stringWithFormat:@"%0.0f", [runState returnNumber]];
    [runState print:resultStr requireNewLine:YES];
    [runState print:@"" requireNewLine:YES];
    
    return 0;
}

