//
//  BMOrder.m
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMOrder.h"
#import "BMServerAPI.h"

@implementation BMOrder

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"ownParts": @"isOwnParts",
        @"needInvoice": @"isNeedInvoice"
    }];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.statusId = BMOrderStatusCreated;
    }
    return self;
}

- (NSComparisonResult)compare:(id)object
{
    return [self.createTime compare:[object createTime]];
}

- (NSString<Ignore> *)reserveTime
{
    return @"2015-07-31 10~12点";     // !!!
}

- (NSString<Ignore> *)autoLogoFile
{
    return DocumentFilePath(self.autoLogoURL.relativePath);
}


- (NSURL<Ignore> *)autoLogoURL
{
    return (_autoLogoName) ? (id)[[BMServerAPI sharedServerAPI].logoBaseURL URLByAppendingPathComponent:_autoLogoName] : _autoLogoName;
}

@end
