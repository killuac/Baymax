//
//  BMActivityIndicator.m
//  Baymax
//
//  Created by Killua Liu on 6/26/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMActivityIndicator.h"
#import "BMConstant.h"

#define NAME_ACTIVITY_INDICATOR @"ActivityIndicator"
#define NAME_MASK_NODE          @"maskNode"

@implementation BMActivityIndicator

+ (void)show
{
    [self showWithText:@""];
}

+ (void)showWithText:(NSString *)text
{
    [self showWithText:text userInteractionEnabled:YES];
}

+ (void)showWithText:(NSString *)text userInteractionEnabled:(BOOL)userInteractionEnabled
{
    BMActivityIndicator *activityIndicator = (BMActivityIndicator *)[CCBReader load:NAME_ACTIVITY_INDICATOR];
    [activityIndicator showText:text userInteractionEnabled:userInteractionEnabled inScene:[CCDirector sharedDirector].runningScene];
}

+ (void)remove
{
    [self.runningScene removeChildByName:NAME_ACTIVITY_INDICATOR];
    [self.runningScene removeChildByName:NAME_MASK_NODE];
    [self.runningScene setUserInteractionEnabledRecursively:YES];
}

+ (void)resumeAnimation
{
    BMActivityIndicator *indicator = (id)[self.runningScene.lastScene getChildByName:NAME_ACTIVITY_INDICATOR recursively:NO];
    if (indicator) {
        [indicator.iconSprite runRotateForever];
    }
}

+ (CCScene *)runningScene
{
    return [CCDirector sharedDirector].runningScene;
}

- (void)showText:(NSString *)text userInteractionEnabled:(BOOL)userInteractionEnabled inScene:(CCScene *)scene
{
    [BMActivityIndicator remove];
    
    self.position = SCREEN_CENTER;
    self.textLabel.string = text;
    self.background.visible = text.length > 0;
    [_iconSprite runRotateForever];
    [scene addChild:self z:1000 name:NAME_ACTIVITY_INDICATOR];
    
    if (!userInteractionEnabled) {
        [self.class.runningScene setUserInteractionEnabledRecursively:NO];
        CCNodeColor *maskNode = [CCNodeColor nodeWithColor:[CCColor blackColor]];
        maskNode.opacity = 0.3;
        maskNode.contentSizeType = CCSizeTypeNormalized;
        maskNode.contentSize = CGSizeMake(1, 1);
        [scene addChild:maskNode z:100 name:NAME_MASK_NODE];
    }
}

@end
