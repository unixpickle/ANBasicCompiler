//
//  ANFloatingPoint.h
//  ANFloatingPoint
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * ANFloatingPoint is a floating-point format similar to IEEE's decimal64, except
 * that encoding and decoding is done slightly differently. ANFloatingPoint values
 * are packed into a string of 8 bytes, most significant bit and byte first, and
 * are decoded likewise. The most significant bit is the sign bit, followed by
 * the significand (53 bits), followed by the 10 bit exponent field.
 *
 * Since the significand value can require 54 bits for large significand values,
 * compression tactics are used, such that exponents can only go up to 256+512 - 1,
 * and significands have a hard limit of
 * 0b100111111111111111111111111111111111111111111111111111.
 *
 * This data format exists pretty much for the soul purpose of easily encoding
 * and decoding floating-point values in Objective-C.
 */
@interface ANFloatingPoint : NSObject {
    UInt64 significand;
    UInt16 exponent;
    UInt8 signBit;
}

@property (readonly) UInt64 significand;
@property (readonly) UInt16 exponent;
@property (readonly) UInt8 signBit;

+ (void)extractDouble:(double)aDouble significand:(UInt64 *)sig exponent:(SInt16 *)exp;

- (id)initWithDouble:(double)aDouble;
- (id)initWithSignificandValue:(UInt64)sigValue exponentValue:(SInt16)signedExponent;
- (id)initWithPacked:(NSData *)packedData;

- (void)getSignificand:(UInt64 *)significand exponent:(SInt16 *)signedExp;

- (double)doubleValue;
- (NSData *)packedData;

- (BOOL)isNan;
- (BOOL)isInfinity;

@end
