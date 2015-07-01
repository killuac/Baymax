//
//  BMMainScene.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewScene.h"
#import "BMTabBarScene.h"
#import "BMOrderService.h"

@interface BMMainScene : BMTableViewScene <BMNavigationSceneDelegate>

@property (nonatomic, weak, readonly) BMUserService *userService;
@property (nonatomic, weak, readonly) BMAutomobile *automobile;
@property (nonatomic, strong, readonly) BMOrderService *orderService;

@property (nonatomic, strong, readonly) CCLabelTTF *amountLabel;
@property (nonatomic, strong, readonly) CCButton *nextButton;

- (void)nextStep:(CCButton *)button;

@end
