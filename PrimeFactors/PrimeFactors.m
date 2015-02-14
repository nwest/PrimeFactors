//
//  PrimeFactors.m
//  PrimeFactors
//
//  Created by Nate West on 2/14/15.
//  Copyright (c) 2015 Nate West. All rights reserved.
//

#import "PrimeFactors.h"

NSArray *PrimeFactors(NSInteger integer) {
    NSMutableArray *factors = [[NSMutableArray alloc] init];

    NSInteger divisor = 2;
    while (integer > 1) {
        while (integer % divisor == 0) {
            integer /= divisor;
            [factors addObject:@(divisor)];
        }
        divisor += 1;
    }

    return [NSArray arrayWithArray:factors];
};
