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

- (NSString<Ignore> *)reserveDate
{
    return @"7月31日 10~12点";     // !!!
}

- (NSURL<Ignore> *)autoLogoURL
{
    return (_autoLogoName) ? (id)[[BMServerAPI sharedServerAPI].logoBaseURL URLByAppendingPathComponent:_autoLogoName] : _autoLogoName;
}

@end
