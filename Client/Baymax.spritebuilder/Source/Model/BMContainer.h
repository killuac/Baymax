//
//  BMContainer.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMAutoBrand.h"

@interface BMContainer : JSONModel

@property (nonatomic, strong) NSArray<BMAutoBrand, Optional> *autoBrands;

@end
