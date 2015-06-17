//
//  BMAppSetting.h
//  Baymax
//
//  Created by Killua Liu on 6/11/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BMConstant.h"

@interface BMServer : JSONModel

@property (nonatomic, copy) NSString *protocol;
@property (nonatomic, copy) NSString *host;
@property (nonatomic, assign) NSNumber *port;

@end

@interface BMAppSetting : JSONModel

+ (instancetype)defaultAppSetting;

@property (nonatomic, strong) BMServer *server;
@property (nonatomic, weak, readonly) NSURL *baseURL;

@property (nonatomic) BOOL isFirstLaunch;
@property (nonatomic, copy) NSString *guideScene;

- (void)save;

@end
