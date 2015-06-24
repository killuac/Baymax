//
//  CCTransition+BMTransition.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCTransition.h"

#define DURATION_SCENE_TRANSITION   0.25f

@interface CCTransition (BMTransition)

+ (instancetype)transitionPushLeft;
+ (instancetype)transitionPushRight;
+ (instancetype)transitionMoveInUp;
+ (instancetype)transitionMoveInDown;
+ (instancetype)transitionRevealUp;
+ (instancetype)transitionRevealDown;

@end
