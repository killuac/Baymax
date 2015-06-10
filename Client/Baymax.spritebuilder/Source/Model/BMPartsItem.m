//
//  BMPartsItem.m
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMPartsItem.h"

@implementation BMPartsItem

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"description": @"partsItemDesc"
    }];
}

@end
