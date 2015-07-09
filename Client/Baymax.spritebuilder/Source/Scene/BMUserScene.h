//
//  BMUserScene.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewScene.h"
#import "BMTabBarScene.h"

@interface BMUserScene : BMTableViewScene

@property (nonatomic, weak, readonly) BMUserService *userService;

@property (nonatomic, strong, readonly) CCSprite9Slice *avatarNode;
@property (nonatomic, weak, readonly) CCSprite9Slice *avatarSprite;
@property (nonatomic, weak, readonly) CCLabelTTF *userNameLabel;

@end
