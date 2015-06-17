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

@property (nonatomic, assign) NSUInteger itemId;
@property (nonatomic, assign) NSUInteger orderId;
@property (nonatomic, assign) ushort partsItemId;
@property (nonatomic, assign) ushort serviceId;
@property (nonatomic, assign) ushort quantity;
@property (nonatomic, assign) double price;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *itemDescription;

@end
