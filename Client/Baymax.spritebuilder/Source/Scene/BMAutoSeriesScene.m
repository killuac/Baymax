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
        self.navigationBar.delegate = self;
        self.navigationBar.titleLabel.string = @"车的系列";
        [self.navigationBar.leftBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_BACK];
        
        [_tableView setupWithStyle:BMTableViewStyleGrouped];
    }
    return self;
}

- (void)setAutoBrand:(BMAutoBrand *)autoBrand
{
    _autoBrand = autoBrand;
    if (_autoBrand.autoSerieses) {
        [self.tableView reloadData];
    }
}

- (void)loadData
{
    if (_autoBrand.autoSerieses) return;
    
    NSURL *url = _autoBrand.autoSeriesesURL;
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _autoBrand.autoSerieses = container.autoSerieses;
        [self.tableView reloadData];
    }];
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.leftBarItem]) {
        [self popScene];
    }
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return _autoBrand.autoSerieses.count;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryDisclosureIndicator];
    cell.textLabel.string = [_autoBrand.autoSerieses[indexPath.row] seriesName];
    return cell;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMAutoModelScene *node = [BMAutoModelScene node];
    node.autoSeries = _autoBrand.autoSerieses[indexPath.row];
    [self pushScene:[CCScene sceneWithNode:node]];
}

@end
