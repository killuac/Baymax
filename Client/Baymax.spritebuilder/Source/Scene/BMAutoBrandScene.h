//
//  BMAutoBrandScene.h
//  Baymax
//
//  Created by Killua Liu on 6/19/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewScene.h"
#import "BMAutomobileService.h"

@interface BMAutoBrandScene : BMTableViewScene

@property (nonatomic, strong, readonly) BMAutomobileService *autoService;

@end
