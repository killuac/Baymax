//
//  BMUserService.m
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMUserService.h"

@implementation BMUserService

- (void)createWithData:(id)data result:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].usersURL;
    
    [[BMSessionManager sharedSessionManager] POST:url parameters:[data toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _user = [BMUser modelWithDictionary:responseObject];
        _response = operation.response;
        result(self);
    }];
}

- (void)signInWithData:(id)data result:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].signInURL;
    
    [[BMSessionManager sharedSessionManager] POST:url parameters:[data toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _user = [BMUser modelWithDictionary:responseObject];
        _response = operation.response;
        result(self);
    }];
}

@end
