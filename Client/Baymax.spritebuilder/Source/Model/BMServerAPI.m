//
//  BMServerAPI.m
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMServerAPI.h"
#import "BMSessionManager.h"

@implementation BMServerAPI

static BMServerAPI *instanceOfServerAPI = nil;
+ (instancetype)sharedServerAPI
{
    if (!instanceOfServerAPI) {
        [[BMSessionManager sharedSessionManager] GET:nil parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        instanceOfServerAPI = [BMServerAPI jsonModelWithDictionary:nil];
    }
    return instanceOfServerAPI;
}

@end
