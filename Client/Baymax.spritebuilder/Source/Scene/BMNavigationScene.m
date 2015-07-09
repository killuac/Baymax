//
//  BMNavigationScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMNavigationScene.h"

@implementation BMNavigationScene

- (id)init
{
    if (self = [super init]) {
        _navigationBar = (BMNavigationBar *)[CCBReader load:@"NavigationBar"];
        _navigationBar.positionType = CCPositionTypeNormalized;
        _navigationBar.position = ccp(0.5, 1);
        _navigationBar.delegate = self;
        [self addChild:_navigationBar z:100];
    }
    return self;
}

- (void)onExitTransitionDidStart
{
    [super onExitTransitionDidStart];
    
    if ([_delegate respondsToSelector:@selector(navigationSceneDidPop:)]) {
        [_delegate navigationSceneDidPop:self];
    }
}

- (void)pushSceneWithName:(NSString *)sceneName animated:(BOOL)animated
{
    CCScene *scene = [CCBReader loadAsScene:sceneName];
    [self pushScene:scene animated:animated];
}

- (void)pushScene:(CCScene *)scene animated:(BOOL)animated
{
    scene.lastScene = self.scene;
    
    if (animated) {
        [[CCDirector sharedDirector] pushScene:scene withTransition:[CCTransition transitionPushLeft]];
    } else {
        [[CCDirector sharedDirector] pushScene:scene];
    }
    
    [self scheduleBlock:^(CCTimer *timer) {
        BMNavigationScene *navScene = scene.children.firstObject;
        [navScene.navigationBar.leftBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_BACK];
    } delay:DURATION_SCENE_TRANSITION];
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([_delegate respondsToSelector:@selector(navigationSceneDidPop:)]) {
        [_delegate navigationSceneDidPop:self];
    }
    
    [self popSceneAnimated:YES];
}

- (void)popSceneAnimated:(BOOL)animated
{
    if (animated) {
        [[CCDirector sharedDirector] popSceneWithTransition:[CCTransition transitionPushRight]];
    } else {
        [[CCDirector sharedDirector] popScene];
    }
}

- (void)popToRootSceneAnimated:(BOOL)animated
{
    if (animated) {
        [[CCDirector sharedDirector] popToRootSceneWithTransition:[CCTransition transitionPushRight]];
    } else {
        [[CCDirector sharedDirector] popToRootScene];
    }
}

@end
