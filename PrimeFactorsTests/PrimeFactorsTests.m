//
//  PrimeFactorsTests.m
//  PrimeFactors
//
//  Created by Nate West on 2/14/15.
//  Copyright (c) 2015 Nate West. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <Fox/Fox.h>
#import <Underscore.m/Underscore.h>

#import "PrimeFactors.h"

BOOL PrimeNumber(NSInteger integer) {
    if (integer == 0 || integer == 1) {
        return NO;
    } else if (integer == 2) {
        return YES;
    }

    NSInteger max = (NSInteger)ceil(sqrt((double)integer));
    for (NSInteger i = 2; i < max; i++) {
        if (integer % i == 0) {
            return NO;
        }
    }
    return YES;
};

BOOL (^nonPrime)(NSNumber *) = ^BOOL(NSNumber *number) {
    return !PrimeNumber([number integerValue]);
};

NSNumber *(^multiply)(NSNumber *, NSNumber *) = ^NSNumber *(NSNumber *x, NSNumber *y) {
    return @([x integerValue] * [y integerValue]);
};

@interface PrimeFactorsTests : XCTestCase

@end

@implementation PrimeFactorsTests

- (void)testPrimeFactors {
    FOXAssert(FOXForAll(FOXStrictPositiveInteger(), ^BOOL(NSNumber *number) {
        NSArray *primeFactors = PrimeFactors([number integerValue]);
        NSLog(@"input: %@ result: %@", number, primeFactors);

        NSArray *nonPrimes = Underscore.filter(primeFactors, nonPrime);

        if ([nonPrimes count] > 0) {
            return NO;
        }

        NSNumber *total = Underscore.reduce(primeFactors, @1, multiply);

        if (![total isEqualToNumber:number]) {
            return NO;
        }

        return YES;
    }));
}

@end
