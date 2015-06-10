//
//  BMContainer.m
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMContainer.h"

@implementation BMContainer

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"_embedded.autoBrands": @"autoBrands"
    }];
}

@end
