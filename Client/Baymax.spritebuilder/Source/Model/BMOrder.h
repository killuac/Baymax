//
//  BMOrder.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMOrderItem.h"

typedef NS_ENUM(short, BMOrderStatus) {
    BMOrderStatusCreated = 1,
    BMOrderStatusAccepted,
    BMOrderStatusWaiting,
    BMOrderStatusRating,
    BMOrderStatusSuccess,
    BMOrderStatusClosed
};

@protocol BMOrder <NSObject>
@end

@interface BMOrder : JSONModel

@property (nonatomic, assign) NSUInteger orderId;
@property (nonatomic, assign) NSUInteger automobileId;
@property (nonatomic, assign) BMOrderStatus statusId;
@property (nonatomic, assign) short paymentId;
@property (nonatomic, assign) NSUInteger addressId;
@property (nonatomic, copy) NSString<Optional> *employeeId;
@property (nonatomic, copy) NSString<Optional> *coworkerId;
@property (nonatomic, assign) BOOL isOwnParts;
@property (nonatomic, assign) BOOL isNeedInvoice;
@property (nonatomic, assign) double amount;
@property (nonatomic, strong) NSDate *serviceTime;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSDate<Optional> *acceptTime;
@property (nonatomic, strong) NSDate<Optional> *completeTime;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, copy) NSString *paymentName;
@property (nonatomic, copy) NSString *detailAddress;
@property (nonatomic, copy) NSString<Optional> *remark;

@property (nonatomic, copy) NSString<Ignore> *reserveDate;

@property (nonatomic, copy) NSString *autoLogoName;
@property (nonatomic, strong) NSURL<Ignore> *autoLogoURL;

@property (nonatomic, strong) NSArray<BMOrderItem> *orderItems;

@end
