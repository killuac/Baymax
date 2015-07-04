//
//  BMAddressService.m
//  Baymax
//
//  Created by Killua Liu on 7/4/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAddressService.h"

@implementation BMAddressService

- (instancetype)init
{
    if (self = [super init]) {
        _address = [[BMAddress alloc] init];
    }
    return self;
}

@end
