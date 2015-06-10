//
//  BMAutomobile.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BMAutomobile <NSObject>
@end

@interface BMAutomobile : JSONModel

@property (nonatomic) NSUInteger automobileId;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *seriesName;
@property (nonatomic, copy) NSString *modelName;
@property (nonatomic, copy) NSString *registrationPlate;
@property (nonatomic, copy) NSString *vinNumber;
@property (nonatomic) ushort oilCapacity;
@property (nonatomic) NSUInteger mileage;
@property (nonatomic) ushort maintenanceCount;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSURL *logoURL;

@end
