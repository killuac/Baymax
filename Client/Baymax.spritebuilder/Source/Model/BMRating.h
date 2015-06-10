//
//  BMRating.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BMRating : JSONModel

@property (nonatomic) NSUInteger orderId;
@property (nonatomic) ushort product;
@property (nonatomic) ushort service;
@property (nonatomic) ushort timeliness;
@property (nonatomic, copy) NSString *comment;

@end
