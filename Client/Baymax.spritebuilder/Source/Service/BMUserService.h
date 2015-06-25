//
//  BMUserService.h
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMBaseService.h"
#import "BMUser.h"

@interface BMUserService : BMBaseService

@property (nonatomic, strong, readonly) BMUser *user;

- (void)signInWithData:(id)data result:(void (^)(id service))result;

@end
