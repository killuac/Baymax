//
//  BMEmployee.m
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMEmployee.h"

@implementation BMEmployee

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"_links.employeeOrders.href": @"employeeOrdersURL",
        @"_links.coworkerOrders.href": @"coworkerOrdersURL"
    }];
}

@end
