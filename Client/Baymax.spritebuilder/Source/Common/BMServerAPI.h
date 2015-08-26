//
//  BMServerAPI.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMAppSetting.h"

@interface BMServerAPI : JSONModel

@property (nonatomic, strong) NSURL *signInURL;
@property (nonatomic, strong) NSURL *usersURL;
@property (nonatomic, strong) NSURL *employeesURL;
@property (nonatomic, strong) NSURL *autoBrandsURL;
@property (nonatomic, strong) NSURL *automobilesURL;
@property (nonatomic, strong) NSURL *addressesURL;
@property (nonatomic, strong) NSURL *provincesURL;
@property (nonatomic, strong) NSURL *citiesURL;
@property (nonatomic, strong) NSURL *ordersURL;
@property (nonatomic, strong) NSURL *orderItemsURL;
@property (nonatomic, strong) NSURL *orderStatusesURL;
@property (nonatomic, strong) NSURL *partsesURL;
@property (nonatomic, strong) NSURL *servicesURL;
@property (nonatomic, strong) NSURL *paymentsURL;
@property (nonatomic, strong) NSURL *ratingsURL;
@property (nonatomic, strong) NSURL *smsCodesURL;

@property (nonatomic, strong) NSURL *logoBaseURL;
@property (nonatomic, strong) NSURL *partsBaseURL;
@property (nonatomic, strong) NSURL *avatarBaseURL;
@property (nonatomic, strong) NSURL *imagesZIPURL;

+ (instancetype)sharedServerAPI;

+ (void)writeAPIFile;

- (void)downloadAllResources;

@end
