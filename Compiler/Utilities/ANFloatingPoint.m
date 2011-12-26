//
//  ANFloatingPoint.m
//  ANFloatingPoint
//
//  Created by Alex Nichol on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANFloatingPoint.h"

#define DIGIT_MASK(x) (((UInt64)1 << (UInt64)x) - (UInt64)1)

@implementation ANFloatingPoint

@synthesize significand;
@synthesize exponent;
@synthesize signBit;

+ (void)extractDouble:(double)aDouble significand:(UInt64 *)sig exponent:(SInt16 *)exp {
    if (aDouble == 0) {
        *sig = 0;
        *exp = 0;
        return;
    }
    int shift = (int)floor(log10(aDouble));
    double shiftedNum = aDouble;
    if (15 - shift < 0) {
        for (int i = 0; i > 15 - shift; i--) {
            shiftedNum /= 10;
        }
    } else if (15 - shift > 0) {
        for (int i = 0; i < 15 - shift; i++) {
            shiftedNum *= 10;
        }
    }
    if (sig) *sig = (UInt64)round(shiftedNum);
    if (exp) *exp = (UInt64)shift;
}

- (id)initWithDouble:(double)aDouble {
    if (isnan(aDouble)) {
        if ((self = [super init])) {
            exponent = (3 << 8);
            significand = ((UInt64)7 << (UInt64)50);
        }
        return self;
    } else if (isinf(aDouble)) {
        exponent = (3 << 8);
        significand = ((UInt64)3 << (UInt64)51);
        if (aDouble < 0) signBit = 1;
        return self;
    }
    
    // get the significand and exponent
    SInt16 signedExponent = 0;
    UInt64 significandValue = 0;
    [[self class] extractDouble:ABS(aDouble) significand:&significandValue exponent:&signedExponent];
    
    // create the encoded floating point
    self = [self initWithSignificandValue:significandValue exponentValue:signedExponent];
    if (self) {
        if (aDouble < 0) signBit = 1;
    }
    return self;
}

- (id)initWithSignificandValue:(UInt64)sigValue exponentValue:(SInt16)signedExponent {
    if ((self = [super init])) {
        UInt16 exponentValue = (UInt16)(signedExponent + 383);
        
        NSAssert(exponentValue < 768, @"Exponent exceeds decimal64 limitations");
        
        UInt8 sigHigh = (sigValue >> 51) & 7; // top three bits of a 54-bit value
        UInt8 expHigh = (exponentValue >> 8) & 3; // top two bits of a 10-bit value
        
        NSAssert(sigHigh <= 4, @"Significand exceeds decimal64 limitations");
        
        if (sigHigh == 4) {
            // The significand is large enough that it has the 54th bit set to 1,
            // but do not fear, we can compress the value by storing 0b11 for the
            // first two highest bits of the exponent, and then the actual highest
            // bits of the exponent at the beginning of the significand.
            // This saves an extra bit, because doing this implies that the
            // significand begins with 0b100, yet we only waste two bits of the
            // significand.
            
            UInt64 sigMask = DIGIT_MASK(51);
            exponent = (3 << 8);
            significand = ((UInt64)expHigh << (UInt64)51);
            
            // The lowest 51 bits of the significand could be anything (although
            // the 51st bit is only valid if it is 0, but we cannot assume that).
            significand |= (sigValue & sigMask);
        } else {
            // The significand is already 53 bits or less, allowing us to freely store
            // both the exponent and the significand in a usual fashion.
            exponent = (expHigh << 8);
            significand = sigValue;
        }
        
        // The lowest byte of the exponent is always the real deal
        exponent |= (exponentValue & 255);
    }
    return self;
}

- (id)initWithPacked:(NSData *)packedData {
    if ((self = [super init])) {
        if ([packedData length] != 8) return nil;
        const UInt8 * bytes = (const UInt8 *)[packedData bytes];
        
        signBit = bytes[0] >> 7;
        significand |= (UInt64)(bytes[0] & 127) << 46;
        significand |= (UInt64)bytes[1] << 38;
        significand |= (UInt64)bytes[2] << 30;
        significand |= (UInt64)bytes[3] << 22;
        significand |= (UInt64)bytes[4] << 14;
        significand |= (UInt64)bytes[5] << 6;
        significand |= (bytes[6] >> 2) & 63;
        exponent |= (bytes[6] & 3) << 8;
        exponent |= bytes[7];
    }
    return self;
}

#pragma mark - Extracting Values -

- (void)getSignificand:(UInt64 *)_significand exponent:(SInt16 *)signedExp {
    UInt8 topSig = (significand >> 51) & 3; // top two bits of a 53-bit value
    UInt8 topExp = (exponent >> 8) & 3; // top two bits of a 10-bit value
    UInt16 exponentValue = 0;
    UInt64 significandValue = 0;
    
    if (topExp < 3) {
        // if the most significant bits of the exponent are below 3, then
        // the significand takes less than 54 bits to store, and therefore
        // both the exponent and the significand and stored normally.
        exponentValue = exponent;
        significandValue = significand;
    } else {
        // the most significant bits of the exponent cannot be 0b11, indicating
        // that the actual high bits of the exponent are stored at the head
        // of the significand, and that the significand begins with the
        // sequence 0b100.
        // the significand following the first two bits are the least significant
        // 51 bits of the significand value.
        UInt64 sigMask = DIGIT_MASK(51);

        exponentValue = (topSig << 8);
        exponentValue |= (exponent & 255);
        
        // we know that the significand is of the pattern 0b100xxxxxx...
        significandValue = ((UInt64)1 << (UInt64)53); // highest bit
        significandValue |= (significand & sigMask); // base (after 00).
    }
    
    if (_significand) _significand[0] = significandValue;
    if (signedExp) signedExp[0] = (SInt16)exponentValue - (SInt16)383;
}

- (double)doubleValue {
    UInt64 significandValue = 0;
    SInt16 signedExponentValue = 0;
    [self getSignificand:&significandValue exponent:&signedExponentValue];
    if (signedExponentValue > 384) {
        if ([self isInfinity]) return INFINITY;
        else return NAN;
    }
    double coefficient = (double)significandValue / pow(10, 15);
    double power = pow(10, signedExponentValue);
    return coefficient * power;
}

- (NSData *)packedData {
    UInt8 bytes[8];
    bytes[0] = (signBit << 7);
    bytes[0] |= (significand >> 46) & 127;
    bytes[1] = (significand >> 38) & 255;
    bytes[2] = (significand >> 30) & 255;
    bytes[3] = (significand >> 22) & 255;
    bytes[4] = (significand >> 14) & 255;
    bytes[5] = (significand >> 6) & 255;
    bytes[6] = (significand & 63) << 2;
    bytes[6] |= (exponent >> 8) & 3;
    bytes[7] = exponent & 255;
    return [NSData dataWithBytes:bytes length:8];
}

#pragma - Special Values -

- (BOOL)isNan {
    if (((exponent >> 8) & 3) == 3) {
        if (((significand >> 50) & 7) == 7) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isInfinity {
    if (((exponent >> 8) & 3) == 3) {
        if (((significand >> 50) & 7) == 6) {
            return YES;
        }
    }
    return NO;
}

@end
