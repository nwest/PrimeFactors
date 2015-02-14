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

@interface PrimeFactorsTests : XCTestCase

@end

@implementation PrimeFactorsTests

- (void)testPrimeFactors {
    FOXAssert(FOXForAll(FOXStrictPositiveInteger(), ^BOOL(NSNumber *number) {
        NSArray *primeFactors = PrimeFactors([number integerValue]);
        NSLog(@"input: %@ result: %@", number, primeFactors);

        NSArray *nonPrimes = Underscore.filter(primeFactors, ^BOOL(NSNumber *number){
            return !PrimeNumber([number integerValue]);
        });

        if ([nonPrimes count] > 0) {
            return NO;
        }

        NSNumber *total = Underscore.reduce(primeFactors, @1, ^(NSNumber *total, NSNumber *next) {
            return @([total integerValue] * [next integerValue]);
        });

        if (![total isEqualToNumber:number]) {
            return NO;
        }

        return YES;
    }));
}

@end
