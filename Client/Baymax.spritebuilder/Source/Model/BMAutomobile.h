//
//  BMAutomobile.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMOrder.h"

@protocol BMAutomobile <NSObject>
@end

@interface BMAutomobile : JSONModel

@property (nonatomic, assign) NSUInteger automobileId;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *seriesName;
@property (nonatomic, copy) NSString *modelName;
@property (nonatomic, copy) NSString *registrationPlate;
@property (nonatomic, copy) NSString *vinNumber;
@property (nonatomic, assign) NSUInteger mileage;
@property (nonatomic, assign) ushort oilCapacity;
@property (nonatomic, assign) ushort maintenanceCount;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSURL *logoURL;

@property (nonatomic, strong) NSURL<Optional> *ordersURL;
@property (nonatomic, strong) NSArray<BMOrder, Optional> *orders;

@end
