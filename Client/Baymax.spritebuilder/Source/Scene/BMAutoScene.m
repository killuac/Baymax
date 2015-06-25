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

@implementation BMAutoScene {
    NSArray *_automobiles;
}

- (void)didLoadFromCCB
{
    self.navigationBar.delegate = self;
    self.navigationBar.titleLabel.string = NAV_TITLE_AUTOMOBILE;
    [self.navigationBar.rightBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_ADD];
}

- (void)loadData
{
    NSURL *url = [BMServerAPI sharedServerAPI].autoBrandsURL;
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMContainer *container = [BMContainer modelWithDictionary:responseObject];
        _automobiles = container.automobiles;
        [self.tableView reloadData];
    }];
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.rightBarItem]) {
        [self presentScene:[CCScene sceneWithNode:[BMAutoBrandScene node]] animated:YES];
    }
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return _automobiles.count;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMAutoTableViewCell *cell = [BMAutoTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryDisclosureIndicator];
    BMAutomobile *automobile = _automobiles[indexPath.row];
    cell.titleLabel.string = [automobile.brandName stringByAppendingString:automobile.seriesName];
    cell.modelLabel.string = automobile.modelName;
    cell.plateNoLabel.string = automobile.registrationPlate;
    cell.mainCountLabel.string = @(automobile.maintenanceCount).stringValue;
    return cell;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
