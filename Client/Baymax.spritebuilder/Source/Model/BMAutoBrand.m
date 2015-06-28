//
//  BMAutoBrand.m
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAutoBrand.h"
#import "BMServerAPI.h"

@implementation BMAutoBrand

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"_links.autoSerieses.href": @"autoSeriesesURL",
        @"_embedded.autoSeries": @"autoSerieses"
    }];
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
