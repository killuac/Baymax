//
//  BMTabBarScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTabBarScene.h"
#import "BMConstant.h"

@implementation BMTabBarScene

- (void)didLoadFromCCB
{
    [_background removeFromParent];
    _scenes = _scenesBox.children;
    _selectedScene = _scenes.firstObject;
    _tabBar.delegate = self;
}

- (void)tabBar:(BMTabBar *)tabBar didSelectItem:(BMTabBarItem *)item
{
    _selectedScene.visible =  NO;
    _selectedScene = [_scenesBox getNonRecursiveChildByName:item.name];
    _selectedScene.visible = YES;
}

@end
