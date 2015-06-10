//
//  BMOrderItem.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BMOrderItem <NSObject>
@end

@interface BMOrderItem : JSONModel

@property (nonatomic) NSUInteger itemId;
@property (nonatomic) NSUInteger orderId;
@property (nonatomic) ushort partsItemId;
@property (nonatomic) ushort serviceId;
@property (nonatomic) ushort quantity;
@property (nonatomic) double price;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *itemDescription;

@end
