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
    [_tableView setupWithStyle:BMTableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (BMTabBarScene *)tabBarScene
{
    return (BMTabBarScene *)self.parent.parent;
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return 10;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleValue accessoryType:BMTableViewCellAccessoryDisclosureIndicator];
    cell.imageSprite.spriteFrame = [CCSpriteFrame frameWithImageNamed:@"ccbResources/bmw.png"];
    return cell;
}

- (NSUInteger)numberOfSectionsInTableView:(BMTableView *)tableView
{
    return 5;
}

- (CGFloat)tableView:(BMTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

@end
