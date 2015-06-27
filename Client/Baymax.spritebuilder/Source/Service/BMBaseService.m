//
//  BMBaseService.m
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMBaseService.h"

@implementation BMBaseService

+ (instancetype)serviceWithModel:(id)modelObject
{
    return [[self alloc] initWithModel:modelObject];
}

- (instancetype)initWithModel:(id)modelObject
{
//  Implement by subclass
    return [super init];
}

- (NSInteger)statusCode
{
    return self.response.statusCode;
}

@end
