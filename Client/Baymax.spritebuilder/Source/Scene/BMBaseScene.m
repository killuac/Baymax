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
        
//        CCNode *background = [CCBReader load:@"Background" owner:self];
//        [self addChild:background];
        
        [self scheduleBlock:^(CCTimer *timer) {
            [self loadData];
        } delay:DURATION_SCENE_TRANSITION];
    }
    return self;
}

- (void)loadData
{
//  Implemented by subclass
}

- (void)reloadData
{
//  Implemented by subclass
}

- (void)presentSceneWithName:(NSString *)sceneName animated:(BOOL)animated
{
    CCScene *scene = [CCBReader loadAsScene:sceneName];
    [self presentScene:scene animated:animated];
}

- (void)presentScene:(CCScene *)scene animated:(BOOL)animated
{
    scene.lastScene = self.scene;
    
    if (animated) {
        [[CCDirector sharedDirector] presentScene:scene withTransition:[CCTransition transitionMoveInUp]];
    } else {
        [[CCDirector sharedDirector] presentScene:scene];
    }
}

- (void)dismissSceneAnimated:(BOOL)animated
{
    if (animated) {
        [[CCDirector sharedDirector] replaceScene:self.scene.lastScene withTransition:[CCTransition transitionRevealDown]];
    } else {
        [[CCDirector sharedDirector] replaceScene:self.scene.lastScene];
    }
}

- (void)dismissToRootSceneAnimated:(BOOL)animated
{
    if (animated) {
        [[CCDirector sharedDirector] replaceScene:self.rootScene withTransition:[CCTransition transitionRevealDown]];
    } else {
        [[CCDirector sharedDirector] replaceScene:self.rootScene];
    }
}

- (CCScene *)rootScene
{
    CCScene *lastScene = self.scene.lastScene;
    
    if (lastScene) {
        return [lastScene.children.firstObject rootScene];
    } else {
        return self.scene;
    }
}

- (void)onExitTransitionDidStart
{
    [super onExitTransitionDidStart];
    [BMActivityIndicator resumeAnimation];
}

#if __CC_PLATFORM_IOS
- (void)showBackgroundUIView
{
    self.scene.colorRGBA = BACKGROUND_COLOR_TRANSPARENT;
}

- (void)hideBackgroundUIView
{
    self.scene.colorRGBA = BACKGROUND_COLOR;
}
#endif

@end
