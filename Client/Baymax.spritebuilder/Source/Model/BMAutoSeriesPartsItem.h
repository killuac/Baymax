//
//  BMAutoSeriesPartsItem.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMPartsItem.h"

@class BMPartsItem;

@protocol AutoSeriesPartsItem <NSObject>
@end

@interface BMAutoSeriesPartsItem : JSONModel

@property (nonatomic, strong) BMPartsItem *partsItem;

@end
