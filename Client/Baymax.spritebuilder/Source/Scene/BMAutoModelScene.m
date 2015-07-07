//
//  BMAutoModelScene.m
//  Baymax
//
//  Created by Killua Liu on 6/20/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAutoModelScene.h"
#import "BMMainScene.h"
#import "BMAutoScene.h"
#import "BMPlateScene.h"

@implementation BMAutoModelScene

- (id)init
{
    if (self = [super init]) {
        self.navigationBar.titleLabel.string = NAV_TITLE_AUTOMODEL;
        
        [_tableView setupWithStyle:BMTableViewStyleGrouped];
    }
    return self;
}

- (void)setAutoService:(BMAutomobileService *)autoService
{
    _autoService = autoService;
    if (self.autoModels) [self reloadData];
}

- (NSArray *)autoModels
{
    return _autoService.selectedSeries.autoModels;
}

- (void)loadData
{
    if (self.autoModels.count) return;
    
    [_autoService findOneSeriesModels:^(id service) {
        [self reloadData];
    }];
}

- (id)selectedTabScene
{
    return [self.rootScene.children.firstObject selectedScene];
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return self.autoModels.count;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryDisclosureIndicator];
    cell.textLabel.string = [self.autoModels[indexPath.row] modelName];
    return cell;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _autoService.selectedModel = self.autoModels[indexPath.row];

    BMPlateScene *node = [BMPlateScene node];
    node.autoService = self.autoService;
    [self pushScene:[CCScene sceneWithNode:node] animated:YES];
}

@end
