//
//  BMOrderService.m
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMOrderService.h"

@implementation BMOrderService

- (instancetype)init
{
    if (self = [super init]) {
        _partsService = [BMPartsService new];
    }
    return self;
}

- (void)findAllItems:(void (^)(id))result
{
    [_partsService findAll:^(id service) {
        [self findAllServices:result];
    }];
}

- (void)findAllServices:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].servicesURL;
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _response = operation.response;
        
        NSMutableArray *items = [NSMutableArray arrayWithArray:_partsService.allPartses];
        [items addObjectsFromArray:container.services];
        _allItems = items;
        
        result(self);
        
        [BMActivityIndicator remove];
    }];
}

@end
