//
//  BMAutomobile.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMAutoModel.h"
#import "BMOrder.h"

@protocol BMAutomobile <NSObject>
@end

@interface BMAutomobile : JSONModel

@property (nonatomic, assign) NSUInteger automobileId;
@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, assign) short modelId;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *seriesName;
@property (nonatomic, copy) NSString *modelName;
@property (nonatomic, copy) NSString *logoName;
@property (nonatomic, copy) NSString *registrationPlate;
@property (nonatomic, copy) NSString<Optional> *vinNumber;
@property (nonatomic, assign) NSUInteger mileage;
@property (nonatomic, assign) short oilCapacity;
@property (nonatomic, assign) short maintenanceCount;
@property (nonatomic, strong) NSDate<Optional> *createTime;

@property (nonatomic, strong) NSString<Ignore> *titleName;
@property (nonatomic, strong, readonly) NSString<Ignore> *logoFile;
@property (nonatomic, strong, readonly) NSURL<Ignore> *logoURL;

@property (nonatomic, strong) NSURL<Optional> *ordersURL;
@property (nonatomic, strong) NSArray<BMOrder, Optional> *orders;

@end
