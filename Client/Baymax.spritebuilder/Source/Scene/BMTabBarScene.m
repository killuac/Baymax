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
    _scenes = _scenesBox.children;
    _selectedScene = _scenes.firstObject;
    _tabBar.delegate = self;
    
    self.userService = [[BMUserService alloc] init];
}

- (void)loadData
{
    if ([BMCredential sharedCredential].isSignedIn) {
        BMUser *user = [[BMUser alloc] init];
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
    
    [BMActivityIndicator remove];
    [_selectedScene loadData];
}

@end
