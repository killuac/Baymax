//
//  BMUser.m
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMUser.h"

@implementation BMUser

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"_links.automobiles.href": @"automobilesURL",
        @"_links.addresses.href": @"addressesURL"
    }];
}

@end
