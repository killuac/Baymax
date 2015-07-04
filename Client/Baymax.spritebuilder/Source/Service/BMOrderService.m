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
        _selectedOrder = [BMOrder model];
        _partsService = [[BMPartsService alloc] init];
        _addressService = [[BMAddressService alloc] init];
    }
    return self;
}

- (void)createWithData:(id)data result:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].ordersURL;
    
    [BMActivityIndicator showWithText:TIP_CREATING userInteractionEnabled:NO];
    
    [[BMSessionManager sharedSessionManager] POST:url parameters:[data toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _selectedOrder = [BMOrder modelWithDictionary:responseObject];
        _response = operation.response;
        result(self);
        
        [BMActivityIndicator remove];
    }];
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

- (void)findAllPayments:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].paymentsURL;
    
    [BMActivityIndicator show];
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _response = operation.response;
        _payments = container.payments;
        
        result(self);
        
        [BMActivityIndicator remove];
    }];
}

- (BMAddress *)selectedAddress
{
    if (_userService.defaultAddress) {
        return _userService.defaultAddress;
    } else {
        if (!_addressService.address.realName) _addressService.address.realName = _userService.user.realName;
        if (!_addressService.address.mobile) _addressService.address.mobile = _userService.user.mobile;
        return _addressService.address;
    }
}

- (BMPayment *)selectedPayment
{
    for (BMPayment *payment in self.payments) {
        if (payment.isSelected) {
            return payment;
        }
    }
    return nil;
}

@end
