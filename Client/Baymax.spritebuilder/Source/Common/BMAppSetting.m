//
//  BMAppSetting.m
//  Baymax
//
//  Created by Killua Liu on 6/11/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAppSetting.h"

#define APP_SETTING @"app-setting"
#define PLIST       @"plist"

@implementation BMServer

@end


@implementation BMAppSetting

static BMAppSetting *instanceOfAppSetting = nil;
+ (instancetype)defaultAppSetting
{
    if (!instanceOfAppSetting) {
        NSString *fileName = [[NSBundle mainBundle] pathForResource:APP_SETTING ofType:PLIST];
        instanceOfAppSetting = [self modelWithDictionary:[NSDictionary dictionaryWithContentsOfFile:fileName]];
    }
    return instanceOfAppSetting;
}

- (void)save
{
    NSString *fileName = [[NSBundle mainBundle] pathForResource:APP_SETTING ofType:PLIST];
    [[self toDictionary] writeToFile:fileName atomically:YES];
}

- (NSURL *)baseURL
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@:%@", _server.protocol, _server.host, _server.port]];
}

@end
