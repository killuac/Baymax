//
//  BMAutomobileService.h
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMBaseService.h"
#import "BMAutoBrand.h"

@interface BMAutomobileService : BMBaseService

@property (nonatomic, strong, readonly) BMAutomobile *automobile;

@property (nonatomic, strong, readonly) NSArray *autoBrands;
@property (nonatomic, strong) BMAutoBrand *selectedBrand;
@property (nonatomic, strong) BMAutoSeries *selectedSeries;

- (void)findAllBrands:(void (^)(id service))result;
- (void)findOneBrandSerieses:(void (^)(id service))result;
- (void)findOneSeriesModels:(void (^)(id service))result;

@end
