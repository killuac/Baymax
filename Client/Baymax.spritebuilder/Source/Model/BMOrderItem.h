//
//  BMOrderItem.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMPartsItem.h"
#import "BMService.h"

@class BMOrder;

@protocol BMOrderItem <NSObject>
@end

@interface BMOrderItem : JSONModel

@property (nonatomic, assign) NSUInteger itemId;
@property (nonatomic, assign) short quantity;
@property (nonatomic, assign) double price;     // Assign it after partsItems and service assignment
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *itemDescription;

@property (nonatomic, strong) BMPartsItem<Optional> *partsItem;
@property (nonatomic, strong) BMService<Optional> *service;

@end
