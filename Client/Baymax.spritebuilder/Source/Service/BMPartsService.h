//
//  BMPartsService.h
//  Baymax
//
//  Created by Killua Liu on 6/30/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMBaseService.h"
#import "BMParts.h"

@interface BMPartsService : BMBaseService

@property (nonatomic, strong, readonly) NSArray *allPartses;
@property (nonatomic, strong) BMParts *selectedParts;
@property (nonatomic, weak, readonly) BMPartsItem *selectedPartsItem;

- (void)findOnePartsItems:(void (^)(id service))result;

@end
