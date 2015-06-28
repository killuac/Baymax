//
//  BMParts.m
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMParts.h"
#import "BMServerAPI.h"

@implementation BMParts

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"_links.partsItems.href": @"partsItemsURL",
        @"_embedded.partsItems": @"partsItems"
    }];
}

- (NSURL<Ignore> *)imageURL
{
    return (_imageName) ? (id)[[BMServerAPI sharedServerAPI].partsBaseURL URLByAppendingPathComponent:_imageName] : _imageName;
}

@end
