//
//  BMOrderScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMOrderScene.h"
#import "BMTabBarScene.h"

@implementation BMOrderScene

- (void)didLoadFromCCB
{
    self.navigationBar.titleLabel.string = NAV_TITLE_ORDER;
}

- (BMTabBarScene *)tabBarScene
{
    return (BMTabBarScene *)self.parent.parent;
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return 0;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleValue accessoryType:BMTableViewCellAccessoryCheckmark];
    cell.imageSprite.spriteFrame = [CCSpriteFrame frameWithImageNamed:@"ccbResources/bmw.png"];
    return cell;
}

@end
