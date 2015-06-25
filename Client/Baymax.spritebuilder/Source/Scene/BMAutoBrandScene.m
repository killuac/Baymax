//
//  BMAutoBrandScene.m
//  Baymax
//
//  Created by Killua Liu on 6/19/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAutoBrandScene.h"
#import "BMAutoSeriesScene.h"

@implementation BMAutoBrandScene

- (id)init
{
    if (self = [super init]) {
        self.navigationBar.delegate = self;
        self.navigationBar.titleLabel.string = NAV_TITLE_AUTOBRAND;
        self.navigationBar.leftBarItem.title = BUTTON_TITLE_CANCEL;
        
        [_tableView setupWithStyle:BMTableViewStyleGrouped];
        
        _autoService = [BMAutomobileService new];
    }
    return self;
}

- (NSArray *)autoBrands
{
    return _autoService.autoBrands;
}

- (void)loadData
{
    if (self.autoBrands) return;
    
    [_autoService findAllBrands:^(id service) {
        [self.tableView reloadData];
    }];
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.leftBarItem]) {
        [self dismissSceneAnimated:YES];
    }
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return self.autoBrands.count;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryDisclosureIndicator];
    cell.textLabel.string = [self.autoBrands[indexPath.row] brandName];
    return cell;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _autoService.selectedBrand = self.autoBrands[indexPath.row];
    
    BMAutoSeriesScene *node = [BMAutoSeriesScene node];
    node.autoService = self.autoService;
    [self pushScene:[CCScene sceneWithNode:node]];
}

@end
