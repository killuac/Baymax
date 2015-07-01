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
#import "BMPartsScene.h"
#import "BMMainNextScene.h"

#define IS_PARTS(item)  [item isMemberOfClass:[BMParts class]]

@implementation BMMainScene

- (void)didLoadFromCCB
{
    self.navigationBar.delegate = self;
    self.navigationBar.titleLabel.string = NAV_TITLE_MAINTENANCE;
    [self.navigationBar.rightBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_ADD];
    [self.navigationBar.leftBarItem setNormalBackgroundImage:IMG_NAV_BUTTON_DROPDOWN];
    
    self.nextButton.enabled = NO;
    
    _orderService = [BMOrderService new];
}

- (void)loadData
{
    if (self.allItems.count) {
        return;
    }
    
    [self.userService findAutomobiles:^(id service) {
        self.navigationBar.titleLabel.string = [self.userService.automobiles.firstObject titleName];
        _automobile = self.userService.automobiles.firstObject;
        
        [self.orderService findAllItems:^(id service) {
            [self reloadData];
            [self addNodesToTableView];
        }];
    }];
}

- (void)addNodesToTableView
{
    CGFloat tableHeight = _tableView.contentNode.contentSize.height;
    
    _nextButton.position = ccp(_nextButton.position.x, tableHeight+15);
    [_nextButton removeFromParent];
    _nextButton.visible = YES;
    [_tableView.contentNode addChild:_nextButton];
    
//    _amountLabel.position = ccp(_amountLabel.position.x, tableHeight+35);
//    [_amountLabel removeFromParent];
//    _amountLabel.visible = YES;
//    [_tableView.contentNode addChild:_amountLabel];

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

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return self.allItems.count;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = self.allItems[indexPath.row];
    BMTableViewCellAccessoryType accessory = IS_PARTS(item) ? BMTableViewCellAccessoryDisclosureIndicator : BMTableViewCellAccessoryNone;
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleValue accessoryType:accessory];
    cell.allowsSelection = IS_PARTS(item);
    
//    cell.imageSprite.spriteFrame = [CCSpriteFrame frameWithContentsOfFile:[item imageFile]];
    cell.textLabel.string = IS_PARTS(item) ? [item partsName] : [item serviceName];
    double price = IS_PARTS(item) ? 0 : [item price];
    self.orderService.amount += price;
    cell.detailTextLabel.string = [NSString stringWithFormat:@"%.f %@", price, TEXT_PRICE_UNIT];
    return cell;
}

- (CGFloat)tableView:(BMTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _orderService.partsService.selectedParts = self.allItems[indexPath.row];
    
    BMPartsScene *partsScene = [BMPartsScene node];
    partsScene.delegate = self;
    partsScene.navigationBar.titleLabel.string = [self.allItems[indexPath.row] partsName];
    [self pushScene:[CCScene sceneWithNode:partsScene] animated:YES];
}

- (BMParts *)selectedParts
{
    return self.orderService.partsService.selectedParts;
}

- (void)navigationSceneDidPop:(BMPartsScene *)navScene
{
    double price = 0;
    NSString *itemName;
    
    BMPartsItem *partsItem = [self.selectedParts selectedPartsItem];
    if (partsItem) {
        itemName = [partsItem brandName];
        price = [partsItem totalPrice].doubleValue;
    } else {
        itemName = [self.selectedParts partsName];
    }
    
    BMTableViewCell *cell = self.tableView.selectedCell;
//    id item = (partsItem) ? partsItem : self.selectedParts;
//    cell.imageSprite.spriteFrame = [CCSpriteFrame frameWithContentsOfFile:[item imageFile]];
    cell.textLabel.string = itemName;
    cell.detailTextLabel.string = [NSString stringWithFormat:@"%.f %@", price, TEXT_PRICE_UNIT];
    
    _amountLabel.string = [NSString stringWithFormat:@"%.f %@", self.orderService.amount, TEXT_PRICE_UNIT];
}

- (void)update:(CCTime)delta
{
    for (BMParts *parts in self.orderService.partsService.allPartses) {
        for (BMPartsItem *partsItem in parts.partsItems) {
            if (partsItem.isSelected) {
                _nextButton.enabled = YES; return;
            }
        }
    }
    
    _nextButton.enabled = YES;  // !!! - Temp set YES
}

- (void)nextStep:(CCButton *)button
{
    [self pushSceneWithName:@"MainNextScene" animated:YES];
}

@end
