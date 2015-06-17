//
//  BMMainScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMMainScene.h"
#import "BMConstant.h"

@implementation BMMainScene

- (void)didLoadFromCCB
{
    _navigationBar.delegate = self;
    [_navigationBar.rightBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_ADD];
    
//    [_roundCell.cellButton drawTopRoundCorner];
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:_navigationBar.rightBarItem]) {
        [self pushSceneWithName:@"SignInScene"];
    }
}

@end
