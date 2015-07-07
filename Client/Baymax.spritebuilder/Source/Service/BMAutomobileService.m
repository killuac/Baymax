//
//  BMAutomobileService.m
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAutomobileService.h"

@implementation BMAutomobileService

- (instancetype)init
{
    if (self = [super init]) {
        _automobile = [[BMAutomobile alloc] init];
    }
    return self;
}

- (void)createWithData:(id)data result:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].automobilesURL;
    
    [BMActivityIndicator showWithText:TIP_CREATING userInteractionEnabled:NO];
    
    [[BMSessionManager sharedSessionManager] POST:url parameters:[data toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", operation.response.allHeaderFields);
        NSString *urlString = operation.response.allHeaderFields[HEAD_FIELD_LOCATION];
        NSURL *url = [NSURL URLWithString:urlString];
        
        [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            _automobile = [BMAutomobile modelWithDictionary:responseObject];
            _response = operation.response;
            
            result(self);
            
            [BMActivityIndicator remove];
        }];
    }];
}

- (void)findAllBrands:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].autoBrandsURL;
    
    [BMActivityIndicator show];
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _response = operation.response;
        _autoBrands = container.autoBrands;
        
        __block NSUInteger idx = 1;
        for (BMAutoBrand *autoBrand in _autoBrands) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:autoBrand.logoFile]) {
                [[BMSessionManager sharedSessionManager] getResource:autoBrand.logoURL
                                                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                 [responseObject writeToFile:autoBrand.logoFile atomically:YES];
                                                                 if (idx == _autoBrands.count) {
                                                                     result(self);
                                                                     [BMActivityIndicator remove];
                                                                 }
                                                                 idx++;
                                                             }];
            } else {
                if (idx == _autoBrands.count) {
                    result(self);
                    [BMActivityIndicator remove];
                }
                idx++;
            }
        }
    }];
}

- (void)findOneBrandSerieses:(void (^)(id))result
{
    NSURL *url = _selectedBrand.autoSeriesesURL;
    
    [BMActivityIndicator show];
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _response = operation.response;
        
        _selectedBrand.autoSerieses = (id)container.autoSerieses;
        for (BMAutoSeries *autoSeries in container.autoSerieses) {
            autoSeries.autoBrand = _selectedBrand;
        }
        
        result(self);
        
        [BMActivityIndicator remove];
    }];
}

- (void)findOneSeriesModels:(void (^)(id))result
{
    NSURL *url = _selectedSeries.autoModelsURL;
    
    [BMActivityIndicator show];
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _response = operation.response;
        
        _selectedSeries.autoModels = (id)container.autoModels;
        for (BMAutoModel *autoModel in container.autoModels) {
            autoModel.autoSeries = _selectedSeries;
        }
        
        result(self);
        
        [BMActivityIndicator remove];
    }];
}

- (void)findAllProvinces:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].provincesURL;
    
    [BMActivityIndicator show];
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _provinces = container.provinces;
        _response = operation.response;
        
        result(self);
        
        [BMActivityIndicator remove];
    }];
}

@end
