//
//  BMOrderStatusModel.h
//  Baymax
//
//  Created by Killua Liu on 7/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

typedef NS_ENUM(short, BMOrderStatus) {
    BMOrderStatusCreated = 1,
    BMOrderStatusWaitingAccept,
    BMOrderStatusAccepted,
    BMOrderStatusWaitingService,
    BMOrderStatusRating,
    BMOrderStatusSuccess,
    BMOrderStatusClosed
};

@protocol BMOrderStatusModel <NSObject>
@end

@interface BMOrderStatusModel : JSONModel

@property (nonatomic, assign) short statusId;
@property (nonatomic, copy) NSString *statusName;

@end
