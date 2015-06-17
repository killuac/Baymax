//
//  BMServerAPI.m
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMServerAPI.h"
#import "BMSessionManager.h"

#define JSON_SERVER_API @"server-api.json"

@implementation BMServerAPI

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@
    {
        @"_links.signIn.href": @"signInURL",
        @"_links.users.href": @"usersURL",
        @"_links.employees.href": @"employeesURL",
        @"_links.autoBrands.href": @"autoBrandsURL",
        @"_links.automobiles.href": @"automobilesURL",
        @"_links.addresses.href": @"addressesURL",
        @"_links.provinces.href": @"provincesURL",
        @"_links.cities.href": @"citiesURL",
        @"_links.orders.href": @"ordersURL",
        @"_links.orderItems.href": @"orderItemsURL",
        @"_links.partses.href": @"partsesURL",
        @"_links.services.href": @"servicesURL",
        @"_links.payments.href": @"paymentsURL",
        @"_links.ratings.href": @"ratingsURL"
    }];
}

static BMServerAPI *instanceOfServerAPI = nil;
+ (instancetype)sharedServerAPI
{
    if (!instanceOfServerAPI) {
        NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *fileName = [docDir stringByAppendingPathComponent:JSON_SERVER_API];
        instanceOfServerAPI = [self modelWithData:[NSData dataWithContentsOfFile:fileName]];
    }
    return instanceOfServerAPI;
}

+ (void)writeAPIFile
{
    [[BMSessionManager sharedSessionManager] GET:@"api"
                                      parameters:nil
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *fileName = [docDir stringByAppendingPathComponent:JSON_SERVER_API];
        [responseObject writeToFile:fileName atomically:YES];
    }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"GET server api error: %@", error);
    }];
}

@end
