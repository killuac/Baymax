//
//  BMCity.m
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMCity.h"

@implementation BMCity

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"_links.districts.href": @"districtsURL",
        @"_embedded.districts": @"districts"
    }];
}

@end
