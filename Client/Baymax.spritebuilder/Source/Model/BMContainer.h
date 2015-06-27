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

@interface BMContainer : JSONModel

@property (nonatomic, strong) NSArray<BMAutoBrand, Optional> *autoBrands;
@property (nonatomic, strong) NSArray<BMAutoSeries, Optional> *autoSerieses;
@property (nonatomic, strong) NSArray<BMAutoModel, Optional> *autoModels;
@property (nonatomic, strong) NSMutableArray<BMAutomobile, Optional> *automobiles;
@property (nonatomic, strong) NSMutableArray<BMAddress, Optional> *addresses;

@end
