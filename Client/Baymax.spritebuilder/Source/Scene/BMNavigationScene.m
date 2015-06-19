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
        [self addChild:_navigationBar z:100];
    }
    return self;
}

- (void)pushSceneWithName:(NSString *)sceneName
{
    CCScene *scene = [CCBReader loadAsScene:sceneName];
    [self pushScene:scene];
}

- (void)pushScene:(CCScene *)scene
{
    [[CCDirector sharedDirector] pushScene:scene withTransition:[CCTransition transitionPushLeft]];
}

- (void)popScene
{
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransition transitionPushRight]];
}

@end
