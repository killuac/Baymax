//
//  AFNetworkReachabilityManager+BMNetworkReachabilityManager.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "AFNetworkReachabilityManager+BMNetworkReachabilityManager.h"

@implementation AFNetworkReachabilityManager (BMNetworkReachabilityManager)

- (void)checkReachability
{
    [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"SHIT!!! %@", AFStringFromNetworkReachabilityStatus(status));
    }];
}

@end
