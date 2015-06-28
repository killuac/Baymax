//
//  BMOrderService.h
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMBaseService.h"

@interface BMOrderService : BMBaseService

@property (nonatomic, strong, readonly) NSArray *allItems;

- (void)findAllItems:(void (^)(id service))result;

@end
