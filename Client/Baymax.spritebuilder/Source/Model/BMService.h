//
//  BMService.h
//  Baymax
//
//  Created by Killua Liu on 6/10/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BMService : JSONModel

@property (nonatomic, assign) short serviceId;
@property (nonatomic, assign) double price;
@property (nonatomic, copy) NSString *serviceName;
@property (nonatomic, copy) NSString *serviceDesc;

@end
