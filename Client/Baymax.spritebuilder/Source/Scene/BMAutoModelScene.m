//
//  BMAutoModelScene.m
//  Baymax
//
//  Created by Killua Liu on 6/20/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAutoModelScene.h"
#import "BMTabBarScene.h"
#import "BMMainScene.h"
#import "BMAutoScene.h"

@implementation BMAutoModelScene {
    BMAutoModel *_autoModel;
}

- (id)init
{
    if (self = [super init]) {
        self.navigationBar.titleLabel.string = NAV_TITLE_AUTOMODEL;
        self.navigationBar.rightBarItem.title = BUTTON_TITLE_DONE;
        self.navigationBar.rightBarItem.enabled = NO;
        
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

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.leftBarItem]) {
        [super navigationBar:navBar didSelectItem:item];
    } else {
        BMAutomobile *automobile = [BMAutomobile new];
        automobile.userId = [[self selectedTabScene] userService].userId;
        automobile.autoModel = _autoModel;
        
        [_autoService createWithData:automobile result:^(id service) {
            [[self selectedTabScene] reloadData:_autoService.automobile];
            [self dismissToRootSceneAnimated:YES];
        }];
    }
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
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryCheckmark];
    cell.textLabel.string = [self.autoModels[indexPath.row] modelName];
    return cell;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _autoModel = self.autoModels[indexPath.row];
    self.navigationBar.rightBarItem.enabled = YES;
}

@end
