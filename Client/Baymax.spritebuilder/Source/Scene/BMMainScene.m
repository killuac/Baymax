//
//  BMMainScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMMainScene.h"
#import "BMAutoBrandScene.h"

@implementation BMMainScene

- (void)didLoadFromCCB
{
    self.navigationBar.delegate = self;
    self.navigationBar.titleLabel.string = @"保养";
    [self.navigationBar.leftBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_DROPDOWN];
    [self.navigationBar.rightBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_ADD];
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.rightBarItem]) {
        [self presentScene:[CCScene sceneWithNode:[BMAutoBrandScene node]] animated:YES];
    } else {
//      !!!
    }
}

@end
