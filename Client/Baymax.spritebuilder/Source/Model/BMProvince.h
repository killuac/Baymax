//
//  BMProvince.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMCity.h"

@protocol BMProvince <NSObject>
@end

@interface BMProvince : JSONModel

@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *abbreviation;

@property (nonatomic, strong) NSURL<Optional> *citiesURL;
@property (nonatomic, strong) NSArray<BMCity, Optional> *cities;

@end
