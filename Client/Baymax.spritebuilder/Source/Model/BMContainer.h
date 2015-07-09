//
//  BMContainer.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMAutoBrand.h"
#import "BMAutomobile.h"
#import "BMAddress.h"
#import "BMProvince.h"
#import "BMParts.h"
#import "BMService.h"
#import "BMPayment.h"
#import "BMOrder.h"

@interface BMContainer : JSONModel

@property (nonatomic, strong) NSArray<BMAutoBrand, Optional> *autoBrands;
@property (nonatomic, strong) NSArray<BMAutoSeries, Optional> *autoSerieses;
@property (nonatomic, strong) NSArray<BMAutoModel, Optional> *autoModels;

@property (nonatomic, strong) NSMutableArray<BMAutomobile, Optional> *automobiles;
@property (nonatomic, strong) NSMutableArray<BMAddress, Optional> *addresses;

@property (nonatomic, strong) NSArray<BMProvince, Optional> *provinces;

@property (nonatomic, strong) NSArray<BMOrder, Optional> *orders;
@property (nonatomic, strong) NSArray<BMOrderStatusModel, Optional> *orderStatuses;

@property (nonatomic, strong) NSArray<BMParts, Optional> *partses;
@property (nonatomic, strong) NSArray<BMPartsItem, Optional> *partsItems;
@property (nonatomic, strong) NSArray<BMService, Optional> *services;

@property (nonatomic, strong) NSArray<BMPayment, Optional> *payments;

@end
