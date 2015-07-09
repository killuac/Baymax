//
//  BMOrder.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMOrderItem.h"
#import "BMOrderStatusModel.h"

@class BMAutomobile;

@protocol BMOrder <NSObject>
@end

@interface BMOrder : JSONModel

@property (nonatomic, assign) NSUInteger orderId;
@property (nonatomic, assign) NSUInteger automobileId;
@property (nonatomic, assign) short statusId;
@property (nonatomic, assign) short paymentId;
@property (nonatomic, assign) NSUInteger addressId;
@property (nonatomic, copy) NSString<Optional> *employeeId;
@property (nonatomic, copy) NSString<Optional> *coworkerId;
@property (nonatomic, assign) BOOL isOwnParts;
@property (nonatomic, assign) BOOL isNeedInvoice;
@property (nonatomic, assign) double amount;
@property (nonatomic, strong) NSDate *serviceTime;
@property (nonatomic, strong) NSDate<Optional> *createTime;
@property (nonatomic, strong) NSDate<Optional> *acceptTime;
@property (nonatomic, strong) NSDate<Optional> *completeTime;
@property (nonatomic, copy) NSString<Optional> *statusName;
@property (nonatomic, copy) NSString<Optional> *paymentName;
@property (nonatomic, copy) NSString<Optional> *detailAddress;
@property (nonatomic, copy) NSString<Optional> *remark;

@property (nonatomic, copy) NSString<Ignore> *reserveTime;

@property (nonatomic, copy) NSString<Optional> *autoLogoName;
@property (nonatomic, strong, readonly) NSURL<Ignore> *autoLogoURL;
@property (nonatomic, strong, readonly) NSString<Ignore> *autoLogoFile;

@property (nonatomic, strong) BMAutomobile<Ignore> *automobile;
@property (nonatomic, strong) NSArray<BMOrderItem> *orderItems;

@end
