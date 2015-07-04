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
        @"_embedded.autoBrands": @"autoBrands",
        @"_embedded.autoSeries": @"autoSerieses",
        @"_embedded.autoModels": @"autoModels",
        @"_embedded.automobiles": @"automobiles",
        @"_embedded.addresses": @"addresses",
        @"_embedded.partses": @"partses",
        @"_embedded.partsItems": @"partsItems",
        @"_embedded.services": @"services",
        @"_embedded.payments": @"payments",
    }];
}

@end
