//
//  BMAddressService.h
//  Baymax
//
//  Created by Killua Liu on 7/4/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMBaseService.h"
#import "BMAddress.h"

@interface BMAddressService : BMBaseService

@property (nonatomic, strong, readonly) BMAddress *address;

@end
