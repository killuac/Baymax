//
//  BMAutoScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAutoScene.h"
#import "BMAutomobile.h"
#import "BMAutoBrandScene.h"
#import "BMAutoTableViewCell.h"

@implementation BMAutoScene

- (void)didLoadFromCCB
{
    self.navigationBar.delegate = self;
    self.navigationBar.titleLabel.string = NAV_TITLE_AUTOMOBILE;
    [self.navigationBar.rightBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_ADD];
    
    [_tableView setupWithStyle:BMTableViewStyleGrouped];
}

- (void)loadData
{
    if (self.automobiles.count) {
        [self reloadData]; return;
    }
    
    [self.userService findAutomobiles:^(id service) {
        [self reloadData];
    }];
}

- (void)reloadData:data
{
    [self.userService updateAutomobiles:data];
    [self reloadData];
}

- (NSArray *)automobiles
{
    return self.userService.user.automobiles;
}

- (BMUserService *)userService
{
    return ((BMTabBarScene *)(self.parent.parent)).userService;
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.rightBarItem]) {
        [self presentScene:[CCScene sceneWithNode:[BMAutoBrandScene node]] animated:YES];
    }
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return 1;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMAutoTableViewCell *cell = [BMAutoTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryDisclosureIndicator];
    BMAutomobile *automobile = self.automobiles[indexPath.section];
    cell.imageSprite.spriteFrame = [CCSpriteFrame frameWithContentsOfFile:automobile.logoFile];
    cell.titleLabel.string = automobile.titleName;
    cell.modelLabel.string = automobile.modelName;
    if (automobile.registrationPlate)
        cell.plateNoLabel.string = automobile.registrationPlate;
    NSString *string = cell.mainCountLabel.string;
    cell.mainCountLabel.string = [string stringByReplacingOccurrencesOfString:@"&" withString:@(automobile.maintenanceCount).stringValue];
    return cell;
}

- (CGFloat)tableView:(BMTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSUInteger)numberOfSectionsInTableView:(BMTableView *)tableView
{
    return self.automobiles.count;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
