//
//  BMOrder.m
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMOrder.h"

@implementation BMOrder

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"ownParts": @"isOwnParts",
        @"needInvoice": @"isNeedInvoice",
        @"description": @"orderDescription"
    }];
}

@end
