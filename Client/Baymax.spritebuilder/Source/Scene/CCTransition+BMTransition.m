//
//  CCTransition+BMTransition.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCTransition+BMTransition.h"

#define DURATION_SCENE_TRANSITION   0.25f

@implementation CCTransition (BMTransition)

+ (instancetype)transitionPushLeft
{
    return [self transitionPushWithDirection:CCTransitionDirectionLeft duration:DURATION_SCENE_TRANSITION];
}

+ (instancetype)transitionPushRight
{
    return [self transitionPushWithDirection:CCTransitionDirectionRight duration:DURATION_SCENE_TRANSITION];
}

+ (instancetype)transitionMoveInUp
{
    return [self transitionMoveInWithDirection:CCTransitionDirectionUp duration:DURATION_SCENE_TRANSITION];
}

+ (instancetype)transitionMoveInDown
{
    return [self transitionMoveInWithDirection:CCTransitionDirectionDown duration:DURATION_SCENE_TRANSITION];
}

@end
