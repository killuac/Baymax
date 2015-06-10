//
//  BMOrder.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMOrderItem.h"

@protocol BMOrder <NSObject>
@end

@interface BMOrder : JSONModel

@property (nonatomic) NSUInteger orderId;
@property (nonatomic) NSUInteger automobileId;
@property (nonatomic) ushort statusId;
@property (nonatomic) ushort paymentId;
@property (nonatomic) NSUInteger addressId;
@property (nonatomic, copy) NSString *employeeId;
@property (nonatomic, copy) NSString *coworkerId;
@property (nonatomic) BOOL isOwnParts;
@property (nonatomic) BOOL isNeedInvoice;
@property (nonatomic) double amount;
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
