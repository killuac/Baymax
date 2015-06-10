//
//  JSONKeyMapper+BMJSONKeyMapper.m
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "JSONKeyMapper+BMJSONKeyMapper.h"

@implementation JSONKeyMapper (BMJSONKeyMapper)

+ (instancetype)jsonKeyMapperWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

@end
