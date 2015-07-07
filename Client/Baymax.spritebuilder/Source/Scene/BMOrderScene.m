//
//  BMOrderScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMOrderScene.h"
#import "BMTabBarScene.h"
#import "BMOrderTableViewCell.h"

@implementation BMOrderScene

- (void)didLoadFromCCB
{
    self.navigationBar.titleLabel.string = NAV_TITLE_ORDER;
}

- (void)loadData
{
    if (self.allOrders.count) {
        return;
    }
    
    [self.userService findAllOrders:^(id service) {
        [self reloadData];
    }];
}

- (BMTabBarScene *)tabBarScene
{
    return (BMTabBarScene *)self.parent.parent;
}

- (BMUserService *)userService
{
    return ((BMTabBarScene *)(self.parent.parent)).userService;
}

- (NSArray *)allOrders
{
    return self.userService.orders;
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return self.allOrders.count;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMOrder *order = self.allOrders[indexPath.row];
    BMOrderTableViewCell *cell = [BMOrderTableViewCell cellWithStyle:BMTableViewCellStyleValue accessoryType:BMTableViewCellAccessoryNone];
    cell.imageSprite.spriteFrame = [CCSpriteFrame frameWithContentsOfFile:order.autoLogoFile];
    CGFloat width = cell.imageSprite.contentSize.width - 15;
    cell.imageSprite.contentSize = CGSizeMake(width, width);
    cell.titleLabel.string = order.automobile.titleName;
    cell.createTimeLabel.string = [cell.createTimeLabel.string stringByAppendingString:[order.createTime toString]];
    cell.serviceTimeLabel.string = [cell.serviceTimeLabel.string stringByAppendingString:order.reserveDate];
    cell.statusLabel.string = order.statusName;
    cell.amountLabel.string = [NSString stringWithFormat:@"%.f %@", order.amount, TEXT_PRICE_UNIT];
    
    return cell;
}

- (CGFloat)tableView:(BMTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(BMTableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
