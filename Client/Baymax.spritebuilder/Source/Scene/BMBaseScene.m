//
//  BMBaseScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMBaseScene.h"

@implementation BMBaseScene

- (id)init
{
    if (self = [super init]) {
        self.contentSizeType = CCSizeTypeNormalized;
        self.contentSize = CGSizeMake(1, 1);
        
        CCNode *background = [CCBReader load:@"Background" owner:self];
        [self addChild:background];
    }
    return self;
}

- (void)presentSceneWithName:(NSString *)sceneName animated:(BOOL)animated
{
    CCScene *scene = [CCBReader loadAsScene:sceneName];
    [self presentScene:scene animated:animated];
}

- (void)presentScene:(CCScene *)scene animated:(BOOL)animated
{
    if (animated) {
        [[CCDirector sharedDirector] pushScene:scene withTransition:[CCTransition transitionMoveInUp]];
    } else {
        [[CCDirector sharedDirector] pushScene:scene];
    }
}

- (void)dismissSceneAnimated:(BOOL)animated
{
    if (animated) {
        [[CCDirector sharedDirector] popToRootSceneWithTransition:[CCTransition transitionRevealDown]];
    } else {
        [[CCDirector sharedDirector] popScene];
    }
}

@end
