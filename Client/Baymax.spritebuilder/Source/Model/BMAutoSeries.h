//
//  BMAutoSeries.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMAutoModel.h"
#import "BMAutoSeriesPartsItem.h"

@class BMAutoBrand;

@protocol BMAutoSeries <NSObject>
@end

@interface BMAutoSeries : JSONModel

@property (nonatomic, assign) short seriesId;
@property (nonatomic, copy) NSString *seriesName;

@property (nonatomic, strong) BMAutoBrand<Optional> *autoBrand;

@property (nonatomic, strong) NSURL<Optional> *autoModelsURL;
@property (nonatomic, strong) NSURL<Optional> *autoSeriesPartsItemsURL;

@property (nonatomic, strong) NSArray<BMAutoModel, Ignore> *autoModels;
@property (nonatomic, strong) NSArray<AutoSeriesPartsItem, Optional> *autoSeriesPartsItems;

@end
