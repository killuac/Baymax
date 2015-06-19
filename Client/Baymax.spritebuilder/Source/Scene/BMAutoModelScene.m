//
//  BMAutoModelScene.m
//  Baymax
//
//  Created by Killua Liu on 6/20/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAutoModelScene.h"

@implementation BMAutoModelScene

- (id)init
{
    if (self = [super init]) {
        self.navigationBar.delegate = self;
        self.navigationBar.titleLabel.string = @"车的型号";
        [self.navigationBar.leftBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_BACK];
        self.navigationBar.rightBarItem.title = BUTTON_TITLE_DONE;
        self.navigationBar.rightBarItem.enabled = NO;
    }
    return self;
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.leftBarItem]) {
        [self popScene];
    } else {
        [self dismissSceneAnimated:YES];
    }
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return 10;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryCheckmark];
    return cell;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.navigationBar.rightBarItem.enabled) {
        self.navigationBar.rightBarItem.enabled = YES;
    }
}

@end
