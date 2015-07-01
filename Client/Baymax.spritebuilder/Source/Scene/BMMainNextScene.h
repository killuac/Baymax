//
//  BMMainNextScene.h
//  Baymax
//
//  Created by Killua Liu on 7/1/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewScene.h"

@interface BMMainNextScene : BMTableViewScene

@property (nonatomic, strong, readonly) CCNodeColor *buttonBackground;
@property (nonatomic, strong, readonly) CCLabelTTF *amountLabel;
@property (nonatomic, strong, readonly) CCButton *orderButton;

- (void)createOrder:(CCButton *)button;

@end
