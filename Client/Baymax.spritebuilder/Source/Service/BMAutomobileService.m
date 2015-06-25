//
//  BMAutomobileService.m
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAutomobileService.h"

@implementation BMAutomobileService

- (void)findAllBrands:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].autoBrandsURL;
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _response = operation.response;
        _autoBrands = container.autoBrands;
        result(self);
    }];
}

- (void)findOneBrandSerieses:(void (^)(id))result
{
    NSURL *url = _selectedBrand.autoSeriesesURL;
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _response = operation.response;
        _selectedBrand.autoSerieses = container.autoSerieses;
        result(self);
    }];
}

- (void)findOneSeriesModels:(void (^)(id))result
{
    NSURL *url = _selectedSeries.autoModelsURL;
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _response = operation.response;
        _selectedSeries.autoModels = container.autoModels;
        result(self);
    }];
}

@end
