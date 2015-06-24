//
//  BMAutoBrandScene.m
//  Baymax
//
//  Created by Killua Liu on 6/19/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMAutoBrandScene.h"
#import "BMAutoSeriesScene.h"

@implementation BMAutoBrandScene {
    NSArray *_autoBrands;
}

- (id)init
{
    if (self = [super init]) {
        self.navigationBar.delegate = self;
        self.navigationBar.titleLabel.string = @"车的品牌";
        self.navigationBar.leftBarItem.title = BUTTON_TITLE_CANCEL;
        
        [_tableView setupWithStyle:BMTableViewStyleGrouped];
    }
    return self;
}

- (void)loadData
{
    if (_autoBrands) return;
    
    NSURL *url = [BMServerAPI sharedServerAPI].autoBrandsURL;
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _autoBrands = container.autoBrands;
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
    return _autoBrands.count;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryDisclosureIndicator];
    cell.textLabel.string = [_autoBrands[indexPath.row] brandName];
    return cell;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMAutoSeriesScene *node = [BMAutoSeriesScene node];
    node.autoBrand = _autoBrands[indexPath.row];
    [self pushScene:[CCScene sceneWithNode:node]];
}

@end
