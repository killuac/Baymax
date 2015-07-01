//
//  BMNavigationScene.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMBaseScene.h"
#import "BMNavigationBar.h"

@protocol BMNavigationSceneDelegate;

@interface BMNavigationScene : BMBaseScene <BMNavigationBarDelegate>

@property (nonatomic, weak) id <BMNavigationSceneDelegate> delegate;
@property (nonatomic, strong, readonly) BMNavigationBar *navigationBar;

- (void)pushSceneWithName:(NSString *)sceneName animated:(BOOL)animated;
- (void)pushScene:(CCScene *)scene animated:(BOOL)animated;
- (void)popSceneAnimated:(BOOL)animated;
- (void)popToRootSceneAnimated:(BOOL)animated;

@end

@protocol BMNavigationSceneDelegate <NSObject>

@optional
- (void)navigationScene:(BMNavigationScene *)navScene didShowFrom:(BMBaseScene *)fromScene;
- (void)navigationSceneDidPop:(BMNavigationScene *)navScene;

@end