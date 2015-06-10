//
//  BMCity.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMDistrict.h"

@protocol BMCity <NSObject>
@end

@interface BMCity : JSONModel

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, strong) NSURL<Optional> *districtsURL;
@property (nonatomic, strong) NSArray<BMDistrict, Optional> *districts;

@end
