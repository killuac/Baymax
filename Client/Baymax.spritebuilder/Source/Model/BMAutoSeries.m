//
//  BMAutoSeries.m
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAutoSeries.h"

@implementation BMAutoSeries

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"_links.autoModels.href": @"autoModelsURL",
        @"_embedded.autoModels": @"autoModels"
    }];
}

@end
