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

@property (nonatomic) NSUInteger addressId;
@property (nonatomic) ushort districtId;
@property (nonatomic) NSUInteger userId;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *detailAddress;

@end
