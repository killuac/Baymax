//
//  BMOrder.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMOrderItem.h"

typedef NS_ENUM(ushort, BMOrderStatus) {
    OrderStatusCreated = 1,
    OrderStatusAccepted,
    OrderStatusWaiting,
    OrderStatusRating,
    OrderStatusSuccess,
    OrderStatusClosed
};

@protocol BMOrder <NSObject>
@end

@interface BMOrder : JSONModel

@property (nonatomic, assign) NSUInteger orderId;
@property (nonatomic, assign) NSUInteger automobileId;
@property (nonatomic, assign) BMOrderStatus status;
@property (nonatomic, assign) ushort paymentId;
@property (nonatomic, assign) NSUInteger addressId;
@property (nonatomic, copy) NSString *employeeId;
@property (nonatomic, copy) NSString *coworkerId;
@property (nonatomic, assign) BOOL isOwnParts;
@property (nonatomic, assign) BOOL isNeedInvoice;
@property (nonatomic, assign) double amount;
@property (nonatomic, strong) NSDate *serviceTime;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSDate *acceptTime;
@property (nonatomic, strong) NSDate *completeTime;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, copy) NSString *paymentName;
@property (nonatomic, copy) NSString *detailAddress;
@property (nonatomic, copy) NSString *orderDescription;
@property (nonatomic, strong) NSURL *autoLogoURL;

@property (nonatomic, strong) NSArray<BMOrderItem> *orderItems;

@end
