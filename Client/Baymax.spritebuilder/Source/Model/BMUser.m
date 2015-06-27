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
        @"notFound": @"isNotFound",
        @"mobileTaken": @"isMobileTaken",
        @"wrongPassword": @"isWrongPassword",
        @"wrongVcode": @"isWrongVcode",
        @"_links.automobiles.href": @"automobilesURL",
        @"_links.addresses.href": @"addressesURL",
        @"_embedded.autombiles": @"autombiles",
        @"_embedded.addresses": @"addresses"
    }];
}

- (void)setAutomobiles:(NSMutableArray<BMAutomobile,Optional> *)automobiles
{
    [automobiles sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    _automobiles = automobiles;
}

@end
