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
@property (nonatomic, assign) ushort product;
@property (nonatomic, assign) ushort service;
@property (nonatomic, assign) ushort timeliness;
@property (nonatomic, copy) NSString *comment;

@end
