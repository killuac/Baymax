//
//  BMAutoModel.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BMAutoModel <NSObject>
@end

@interface BMAutoModel : JSONModel

@property (nonatomic, copy) NSString *modelName;
@property (nonatomic, assign) short oilCapacity;

@end
