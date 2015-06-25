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
        self.navigationBar.titleLabel.string = NAV_TITLE_AUTOMODEL;
        [self.navigationBar.leftBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_BACK];
        self.navigationBar.rightBarItem.title = BUTTON_TITLE_DONE;
        self.navigationBar.rightBarItem.enabled = NO;
        
        [_tableView setupWithStyle:BMTableViewStyleGrouped];
    }
    return self;
}

- (void)setAutoService:(BMAutomobileService *)autoService
{
    _autoService = autoService;
    if (self.autoModels) [self.tableView reloadData];
}

- (NSArray *)autoModels
{
    return _autoService.selectedSeries.autoModels;
}

- (void)loadData
{
    if (self.autoModels) return;
    
    [_autoService findOneSeriesModels:^(id service) {
        [self.tableView reloadData];
    }];
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
    return self.autoModels.count;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryCheckmark];
    cell.textLabel.string = [self.autoModels[indexPath.row] modelName];
    return cell;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.navigationBar.rightBarItem.enabled) {
        self.navigationBar.rightBarItem.enabled = YES;
    }
}

@end
