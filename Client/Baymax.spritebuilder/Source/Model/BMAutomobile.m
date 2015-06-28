//
//  BMAutomobile.m
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAutomobile.h"
#import "BMServerAPI.h"

@implementation BMAutomobile

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"_links.orders.href": @"ordersURL",
        @"_embedded.orders": @"orders"
    }];
}

- (NSComparisonResult)compare:(id)object
{
    return [self.createTime compare:[object createTime]];
}

- (NSString<Ignore> *)titleName
{
    return [_brandName stringByAppendingString:_seriesName];
}

- (NSString<Ignore> *)logoFile
{
    return DocumentFilePath(self.logoURL.relativePath);
}

- (NSURL<Ignore> *)logoURL
{
    return (_logoName) ? (id)[[BMServerAPI sharedServerAPI].logoBaseURL URLByAppendingPathComponent:_logoName] : _logoName;
}

@end
