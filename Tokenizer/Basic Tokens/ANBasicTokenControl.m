//
//  ANBasicTokenControl.m
//  ANBasicCompiler
//
//  Created by Alex Nichol on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBasicTokenControl.h"

@implementation ANBasicTokenControl

@synthesize controlName;

+ (BOOL)isControlName:(NSString *)aTokenString {
    NSString * controlNames[] = {
        @"If", @"Then", @"Else", @"IfEnd", @"For", @"To", @"Step", @"Next", @"While", @"WhileEnd", @"Do", @"LpWhile",
        @"Prog", @"Return", @"Break", @"Stop",
        @"Lbl", @"Goto", @"=>", @"Isz", @"Dsz",
        @";", @":", @"\n"
    };
    for (NSUInteger i = 0; i < (sizeof(controlNames) / sizeof(NSString *)); i++) {
        if ([controlNames[i] isEqualToString:aTokenString]) {
            return YES;
        }
    }
    return NO;
}

- (id)initWithControlName:(NSString *)aName {
    if ((self = [super init])) {
        if (![[self class] isControlName:aName]) return nil;
        controlName = aName;
    }
    return self;
}

- (BOOL)isNewBlockControl {
    NSString * newLineControls[] = {
        @";", @":", @"\n"
    };
    for (NSUInteger i = 0; i < (sizeof(newLineControls) / sizeof(NSString *)); i++) {
        if ([newLineControls[i] isEqualToString:controlName]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)stringValue {
    return controlName;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<ANBasicTokenControl: %@>", [self stringValue]];
}

@end
