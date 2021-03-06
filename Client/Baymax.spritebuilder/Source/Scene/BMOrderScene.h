//
//  BMOrderScene.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewScene.h"
#import "BMTabBarScene.h"
#import "BMOrderService.h"

@interface BMOrderScene : BMTableViewScene

@property (nonatomic, weak, readonly) BMUserService *userService;
@property (nonatomic, strong, readonly) BMOrderService *orderService;

@end
