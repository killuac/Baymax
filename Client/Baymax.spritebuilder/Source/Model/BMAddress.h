//
//  BMAddress.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BMAddress <NSObject>
@end

@interface BMAddress : JSONModel

@property (nonatomic, assign) NSUInteger addressId;
@property (nonatomic, assign) short districtId;
@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *detailAddress;
@property (nonatomic, assign) BOOL isDefaultAddress;

@end
