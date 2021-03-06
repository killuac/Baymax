//
//  BMOrderService.h
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMBaseService.h"
#import "BMUserService.h"
#import "BMPartsService.h"
#import "BMAddressService.h"
#import "BMOrder.h"

@interface BMOrderService : BMBaseService

@property (nonatomic, strong, readonly) NSArray *partsAndServices;
@property (nonatomic, strong, readonly) NSArray *payments;
@property (nonatomic, strong, readonly) NSArray *statuses;

@property (nonatomic, strong) BMOrder *selectedOrder;

@property (nonatomic, strong) BMUserService *userService;
@property (nonatomic, strong, readonly) BMPartsService *partsService;
@property (nonatomic, strong, readonly) BMAddressService *addressService;

@property (nonatomic, weak, readonly) BMAddress *selectedAddress;
@property (nonatomic, weak, readonly) BMPayment *selectedPayment;

- (void)findAllPartsAndServices:(void (^)(id service))result;
- (void)findAllPayments:(void (^)(id service))result;

- (NSString *)statusNameForId:(BMOrderStatus)statusId;

@end
