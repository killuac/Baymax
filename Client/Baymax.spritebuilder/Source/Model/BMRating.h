//
//  BMRating.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BMRating : JSONModel

@property (nonatomic, assign) NSUInteger orderId;
@property (nonatomic, assign) short product;
@property (nonatomic, assign) short service;
@property (nonatomic, assign) short timeliness;
@property (nonatomic, copy) NSString *comment;

@end
