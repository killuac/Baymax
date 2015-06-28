//
//  BMOrderService.m
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMOrderService.h"

@implementation BMOrderService

- (void)findAllItems:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].partsBaseURL;
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _response = operation.response;
        _allItems = [NSMutableArray arrayWithArray:container.partses];
        
        [self findAllServices:result];
    }];
}

- (void)findAllServices:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].servicesURL;
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _response = operation.response;
        
        NSMutableArray *items = [NSMutableArray arrayWithArray:_allItems];
        [items addObjectsFromArray:container.services];
        _allItems = items;
        
        result(self);
    }];
}

@end
