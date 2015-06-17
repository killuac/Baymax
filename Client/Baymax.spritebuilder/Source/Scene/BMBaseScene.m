//
//  BMBaseScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMBaseScene.h"

@implementation BMBaseScene

- (void)presentSceneWithName:(NSString *)sceneName animated:(BOOL)animated
{
    CCScene *scene = [CCBReader loadAsScene:sceneName];
    [self presentScene:scene animated:animated];
}

- (void)presentScene:(CCScene *)scene animated:(BOOL)animated
{
    if (animated) {
        [[CCDirector sharedDirector] presentScene:scene withTransition:[CCTransition transitionMoveInUp]];
    } else {
        [[CCDirector sharedDirector] presentScene:scene];
    }
}

- (void)dismissSceneAnimated:(BOOL)animated
{
    if (animated) {
        [[CCDirector sharedDirector] popSceneWithTransition:[CCTransition transitionMoveInDown]];
    } else {
        [[CCDirector sharedDirector] popScene];
    }
}

@end
