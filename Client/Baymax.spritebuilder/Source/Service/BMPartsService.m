//
//  BMPartsService.m
//  Baymax
//
//  Created by Killua Liu on 6/30/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMPartsService.h"

@implementation BMPartsService

- (void)findAll:(void (^)(id))result
{
    NSURL *url = [BMServerAPI sharedServerAPI].partsesURL;
    
    [BMActivityIndicator show];
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _response = operation.response;
        _allPartses = container.partses;
        result(self);
    }];
}

- (void)findOnePartsItems:(void (^)(id))result
{
    NSURL *url = _selectedParts.partsItemsURL;
    
    [BMActivityIndicator show];
    
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _response = operation.response;
        _selectedParts.partsItems = container.partsItems;
        result(self);
        
        [BMActivityIndicator remove];
    }];
}

- (BMPartsItem *)selectedPartsItem
{
    return _selectedParts.selectedPartsItem;
}

@end
