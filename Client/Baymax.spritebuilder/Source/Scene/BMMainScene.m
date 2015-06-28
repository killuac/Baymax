//
//  BMMainScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMMainScene.h"
#import "BMTabBarScene.h"
#import "BMAutoBrandScene.h"

@implementation BMMainScene

- (void)didLoadFromCCB
{
    self.navigationBar.delegate = self;
    self.navigationBar.titleLabel.string = NAV_TITLE_MAINTENANCE;
    [self.navigationBar.rightBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_ADD];
    [self.navigationBar.leftBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_DROPDOWN];
    
    _orderService = [BMOrderService new];
}

- (void)loadData
{
    [self.userService findAutomobiles:^(id service) {
        self.navigationBar.titleLabel.string = [self.userService.automobiles.firstObject titleName];
    }];
    
    [self.orderService findAllItems:^(id service) {
        
    }];
}

- (void)reloadData
{
    [self.tableView reloadData];
}

- (void)reloadData:data
{
    [self.userService updateAutomobiles:data];
    [self reloadData];
}

- (BMUserService *)userService
{
    return ((BMTabBarScene *)(self.parent.parent)).userService;
}

- (NSArray *)allItems
{
    return self.orderService.allItems;
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.rightBarItem]) {
        [self presentScene:[CCScene sceneWithNode:[BMAutoBrandScene node]] animated:YES];
    } else {
//      !!! - 选择不同车辆
    }
}

@end
