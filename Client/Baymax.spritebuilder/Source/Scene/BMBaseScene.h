//
//  BMBaseScene.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCNode.h"

@interface BMBaseScene : CCNode

- (void)presentScene:(CCScene *)scene animated:(BOOL)animated;
- (void)presentSceneWithName:(NSString *)sceneName animated:(BOOL)animated;
- (void)dismissSceneAnimated:(BOOL)animated;

@end
