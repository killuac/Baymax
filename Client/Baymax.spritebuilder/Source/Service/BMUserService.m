//
//  BMUserService.m
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMUserService.h"
#import "BMAutomobileService.h"

@implementation BMUserService

- (NSUInteger)userId
{
    return self.user.userId;
}

- (NSUInteger)automobileCount
{
    return self.user.automobiles.count;
}

- (NSArray *)automobiles
{
    return self.user.automobiles;
}

- (void)updateAutomobiles:(BMAutomobile *)automobile
{
    [_user.automobiles addObject:automobile];
}

- (void)createWithData:(id)data result:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].usersURL;
    
    [BMActivityIndicator showWithText:TIP_SIGNING_UP];
    
    [[BMSessionManager sharedSessionManager] POST:url parameters:[data toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _user = [BMUser modelWithDictionary:responseObject];
        _response = operation.response;
        
        if (result) result(self);
        
        [BMActivityIndicator remove];
    }];
}

- (void)signInWithData:(id)data result:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].signInURL;
    
    [BMActivityIndicator showWithText:TIP_SIGNING_IN];
    
    [[BMSessionManager sharedSessionManager] POST:url parameters:[data toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _user = [BMUser modelWithDictionary:responseObject];
        _response = operation.response;
        
        if (result) result(self);
        
        [BMActivityIndicator remove];
    }];
}

- (void)findAutomobiles:(void (^)(id))result
{
    NSURL *url = _user.automobilesURL;
    
    [BMActivityIndicator show];
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _user.automobiles = container.automobiles;
        _response = operation.response;
        
        result(self);
        
        [BMActivityIndicator remove];
    }];
}

- (void)findAllAddresses:(void (^)(id))result
{
    NSURL *url = _user.addressesURL;
    
    [BMActivityIndicator show];
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _user.addresses = container.addresses;
        _response = operation.response;
        
        if (result) result(self);
        
        [BMActivityIndicator remove];
    }];
}

- (BMAutomobile *)selectedAutomobile
{
    for (BMAutomobile *automobile in _user.automobiles) {
        if (automobile.isSelected)
            return automobile;
    }
    return _user.automobiles.firstObject;
}

- (BMAddress *)defaultAddress
{
    for (BMAddress *address in _user.addresses) {
        if (address.isDefaultAddress)
            return address;
    }
    return nil;
}

- (void)findAllOrders:(void (^)(id))result
{
    NSMutableArray *orders = [NSMutableArray array];
    
    [BMActivityIndicator show];
    
    __block NSUInteger idx = 1;
    for (BMAutomobile *automobile in _user.automobiles) {
        NSURL *url = automobile.ordersURL;
        
        [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            BMContainer *container = [BMContainer modelWithDictionary:responseObject];
            if (container.orders) {
                [orders addObjectsFromArray:container.orders];
            }
            
            if (idx == _user.automobiles.count) {
                _response = operation.response;
                NSSortDescriptor *sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
                _orders = [orders sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder]];
                
                for (BMOrder *order in _orders) {
                    order.automobile = automobile;
                }
                
                result(self);
                
                [BMActivityIndicator remove];
            }
            
            idx++;
        }];
    }
}

@end
