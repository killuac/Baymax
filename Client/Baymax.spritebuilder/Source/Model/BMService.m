//
//  BMService.m
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMService.h"
#import "BMServerAPI.h"

@implementation BMService

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"description": @"serviceDesc"
    }];
}

- (NSURL<Ignore> *)imageURL
{
    return (_imageName) ? (id)[[BMServerAPI sharedServerAPI].partsBaseURL URLByAppendingPathComponent:_imageName] : _imageName;
}

@end
