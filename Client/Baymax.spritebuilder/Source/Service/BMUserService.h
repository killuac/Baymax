//
//  BMUserService.h
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMBaseService.h"
#import "BMUser.h"
#import "BMSMSCode.h"

@interface BMUserService : BMBaseService

@property (nonatomic, strong, readonly) BMUser *user;
@property (nonatomic, strong, readonly) NSArray *automobiles;
@property (nonatomic, strong, readonly) NSArray *addresses;
@property (nonatomic, strong, readonly) NSArray *orders;

@property (nonatomic, assign, readonly) NSUInteger userId;
@property (nonatomic, assign, readonly) NSUInteger automobileCount;

@property (nonatomic, weak, readonly) BMAutomobile *selectedAutomobile;
@property (nonatomic, weak, readonly) BMAddress *defaultAddress;

- (void)updateAutomobiles:(BMAutomobile *)automobile;

- (void)signInWithData:(id)data result:(void (^)(id service))result;

- (void)findAutomobiles:(void (^)(id service))result;

- (void)findAllAddresses:(void (^)(id service))result;

- (void)findAllOrders:(void (^)(id service))result;

- (void)sendSMSWithData:(id)data result:(void (^)(id service))result;

@end
