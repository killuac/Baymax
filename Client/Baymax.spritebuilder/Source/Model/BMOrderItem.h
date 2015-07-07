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

@protocol BMOrderItem <NSObject>
@end

@interface BMOrderItem : JSONModel

@property (nonatomic, assign) NSUInteger itemId;
@property (nonatomic, assign) NSUInteger orderId;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) short quantity;
@property (nonatomic, copy) NSString<Optional> *itemName;
@property (nonatomic, copy) NSString<Optional> *itemDescription;

@property (nonatomic, strong) BMPartsItem<Optional> *partsItem;
@property (nonatomic, strong) BMService<Optional> *service;

@end
