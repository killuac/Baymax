//
//  CCTransition+BMTransition.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCTransition+BMTransition.h"

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

+ (instancetype)transitionRevealUp
{
    return [self transitionRevealWithDirection:CCTransitionDirectionUp duration:DURATION_SCENE_TRANSITION];
}

+ (instancetype)transitionRevealDown
{
    return [self transitionRevealWithDirection:CCTransitionDirectionDown duration:DURATION_SCENE_TRANSITION];
}

+ (instancetype)transitionFade
{
    return [self transitionFadeWithColor:[CCColor whiteColor] duration:DURATION_SCENE_FADE];
}

@end
