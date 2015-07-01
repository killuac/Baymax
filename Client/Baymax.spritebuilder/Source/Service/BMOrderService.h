//
//  BMOrderService.h
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMBaseService.h"
#import "BMPartsService.h"

@interface BMOrderService : BMBaseService

@property (nonatomic, strong, readonly) BMPartsService *partsService;
@property (nonatomic, strong, readonly) NSArray *allItems;

@property (nonatomic, assign) double amount;

- (void)findAllItems:(void (^)(id service))result;

@end
