//
//  BMNavigationScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMNavigationScene.h"

@implementation BMNavigationScene

- (void)pushSceneWithName:(NSString *)sceneName
{
    CCScene *scene = [CCBReader loadAsScene:sceneName];
    [[CCDirector sharedDirector] pushScene:scene withTransition:[CCTransition transitionPushLeft]];
}

- (void)popScene
{
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransition transitionPushLeft]];
}

@end
