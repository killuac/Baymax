//
//  BMMainNextScene.h
//  Baymax
//
//  Created by Killua Liu on 7/1/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewScene.h"
#import "BMOrderService.h"

@interface BMMainNextScene : BMTableViewScene <BMNavigationSceneDelegate>

@property (nonatomic, strong, readonly) CCNodeColor *buttonBackground;
@property (nonatomic, strong, readonly) CCLabelTTF *amountLabel;
@property (nonatomic, strong, readonly) CCButton *orderButton;

@property (nonatomic, weak) BMOrderService *orderService;

- (void)createOrder:(CCButton *)button;

@end
