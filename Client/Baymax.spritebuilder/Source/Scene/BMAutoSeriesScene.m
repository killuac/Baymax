//
//  BMAutoSeriesScene.m
//  Baymax
//
//  Created by Killua Liu on 6/20/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAutoSeriesScene.h"
#import "BMAutoModelScene.h"

@implementation BMAutoSeriesScene

- (id)init
{
    if (self = [super init]) {
        self.navigationBar.titleLabel.string = NAV_TITLE_AUTOSERIES;
//        [self.navigationBar.rightBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_HOME];
        
        [_tableView setupWithStyle:BMTableViewStyleGrouped];
    }
    return self;
}

- (void)setAutoService:(BMAutomobileService *)autoService
{
    _autoService = autoService;
    if (self.autoSerieses) [self reloadData];
}

- (NSArray *)autoSerieses
{
    return _autoService.selectedBrand.autoSerieses;
}

- (void)loadData
{
    if (self.autoSerieses.count) return;
    
    [_autoService findOneBrandSerieses:^(id service) {
        [self reloadData];
    }];
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.leftBarItem]) {
        [super navigationBar:navBar didSelectItem:item];
    } else {
        [self dismissToRootSceneAnimated:YES];
    }
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return self.autoSerieses.count;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryDisclosureIndicator];
    cell.textLabel.string = [self.autoSerieses[indexPath.row] seriesName];
    return cell;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _autoService.selectedSeries = self.autoSerieses[indexPath.row];
    
    BMAutoModelScene *node = [BMAutoModelScene node];
    node.autoService = self.autoService;
    [self pushScene:[CCScene sceneWithNode:node] animated:YES];
}

@end
