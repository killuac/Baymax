//
//  BMNavigationScene.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMBaseScene.h"
#import "BMNavigationBar.h"

@interface BMNavigationScene : BMBaseScene <BMNavigationBarDelegate>

@property (nonatomic, strong, readonly) BMNavigationBar *navigationBar;

- (void)pushSceneWithName:(NSString *)sceneName;
- (void)pushScene:(CCScene *)scene;
- (void)popScene;

@end
