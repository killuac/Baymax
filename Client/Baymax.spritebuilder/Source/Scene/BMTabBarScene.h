//
//  BMTabBarScene.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMNavigationScene.h"
#import "BMTabBar.h"
#import "BMUserService.h"

@interface BMTabBarScene : BMBaseScene <BMTabBarDelegate> {
    CCNode *_animationNode;
    CCNode *_scenesBox;
}

@property (nonatomic, strong) BMUserService *userService;

@property (nonatomic, weak, readonly) NSArray *scenes;
@property (nonatomic, weak, readonly) BMBaseScene *selectedScene;
@property (nonatomic, weak, readonly) BMTabBar *tabBar;

@end
