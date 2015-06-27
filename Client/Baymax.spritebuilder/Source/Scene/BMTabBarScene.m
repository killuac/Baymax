//
//  BMTabBarScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTabBarScene.h"
#import "BMConstant.h"
#import "BMCredential.h"

@implementation BMTabBarScene

- (void)didLoadFromCCB
{
    [_background removeFromParent];
    _scenes = _scenesBox.children;
    _selectedScene = _scenes.firstObject;
    _tabBar.delegate = self;
    
//    id actions = [CCActionSequence actionWithArray:@
//                  [[CCActionTween actionWithDuration:0.4 key:@"roll" from:0.0f to:M_PI_2],
//                   //                   [CCActionCallFunc actionWithTarget:self selector:@selector(swapImage)],
//                   [CCActionTween actionWithDuration:0.4 key:@"roll" from:M_PI_2 to:M_PI]]];
//    [self runAction:actions];
}

- (void)loadData
{
    if ([BMCredential sharedCredential].isSignedIn) {
        self.userService = [BMUserService new];
        BMUser *user = [BMUser new];
        user.mobile = [BMCredential sharedCredential].mobile;
        user.password = [BMCredential sharedCredential].password;
        [self.userService signInWithData:user result:^(id service) {
            [_selectedScene loadData];
        }];
    }
}

- (void)tabBar:(BMTabBar *)tabBar didSelectItem:(BMTabBarItem *)item
{
    _selectedScene.visible =  NO;
    _selectedScene = [_scenesBox getNonRecursiveChildByName:item.name];
    _selectedScene.visible = YES;
    
    [_selectedScene loadData];
}

@end
