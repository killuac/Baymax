//
//  BMPartsItem.m
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMPartsItem.h"
#import "BMServerAPI.h"

@implementation BMPartsItem

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"description": @"partsItemDesc"
    }];
}

- (NSString<Ignore> *)imageFile
{
    return DocumentFilePath(self.imageURL.relativePath);
}

- (NSURL<Ignore> *)imageURL
{
    return (_imageName) ? (id)[[BMServerAPI sharedServerAPI].partsBaseURL URLByAppendingPathComponent:_imageName] : _imageName;
}

- (BOOL)isSelected
{
    return self.selected.boolValue;
}

@end
