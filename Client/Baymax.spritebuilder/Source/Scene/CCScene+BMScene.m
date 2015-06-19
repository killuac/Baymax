//
//  CCScene+BMScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCScene+BMScene.h"

@implementation CCScene (BMScene)

+ (instancetype)sceneWithNode:(CCNode *)node
{
    CCScene *scene = [CCScene node];
    [scene addChild:node];
    return scene;
}

- (void)showText:(NSString *)text
{
    //!!!:
}

- (void)showActivityIndicator
{
    //!!!:
}

- (void)removeActivityIndicator
{
    //!!!:
}

@end
