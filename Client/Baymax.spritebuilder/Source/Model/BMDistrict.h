//
//  BMDistrict.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BMDistrict <NSObject>
@end

@interface BMDistrict : JSONModel

@property (nonatomic, copy) NSString *districtName;

@end
