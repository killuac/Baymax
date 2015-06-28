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

@property (nonatomic, assign) short brandId;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *logoName;

@property (nonatomic, strong, readonly) NSURL<Ignore> *logoURL;
@property (nonatomic, strong, readonly) NSString<Ignore> *logoFile;

@property (nonatomic, strong) NSURL<Optional> *autoSeriesesURL;
@property (nonatomic, strong) NSArray<BMAutoSeries, Ignore> *autoSerieses;

@end
