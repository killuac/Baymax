//
//  CCNode+BMNode.h
//  Baymax
//
//  Created by Killua Liu on 6/16/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCNode.h"
#import "BMTextTip.h"
#import "BMActivityIndicator.h"

#define DURATION_FADE       0.5f
#define DURATION_ROTATE     0.75f

@interface CCNode (BMNode)

- (NSArray *)getAllChildren;
- (id)getNonRecursiveChildByName:(NSString *)name;
- (id)getRecursiveChildByName:(NSString *)name;

- (void)showTextTip:(NSString *)text;
- (void)showTextTip:(NSString *)text withType:(BMTextTipType)type;
- (void)removeTextTip;

- (void)showActivityIndicator;
- (void)removeActivityIndicator;

- (void)runRotateForever;
- (void)runFadeInWithBlock:(void(^)())block;
- (void)runFadeOutWithBlock:(void(^)())block;

@end
