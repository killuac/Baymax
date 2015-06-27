//
//  BMAutoModel.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class BMAutoSeries;

@protocol BMAutoModel <NSObject>
@end

@interface BMAutoModel : JSONModel

@property (nonatomic, assign) short modelId;
@property (nonatomic, copy) NSString *modelName;
@property (nonatomic, assign) short oilCapacity;

@property (nonatomic, strong) BMAutoSeries<Optional> *autoSeries;

@end
