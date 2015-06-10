//
//  BMAutoBrand.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMAutoSeries.h"

@protocol BMAutoBrand <NSObject>
@end

@interface BMAutoBrand : JSONModel

@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, strong) NSURL *logoURL;

@property (nonatomic, strong) NSURL<Optional> *autoSeriesesURL;
@property (nonatomic, strong) NSArray<BMAutoSeries, Optional> *autoSerieses;

@end
