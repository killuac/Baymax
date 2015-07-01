//
//  BMPartsScene.m
//  Baymax
//
//  Created by Killua Liu on 6/30/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMPartsScene.h"

@implementation BMPartsScene

- (id)init
{
    if (self = [super init]) {
        [_tableView setupWithStyle:BMTableViewStyleGrouped];
    }
    return self;
}

- (void)loadData
{
    if (self.allPartsItems) {
        [self reloadData];
        
        if (self.partsService.selectedPartsItem) {
            NSUInteger idx = [self.allPartsItems indexOfObject:self.partsService.selectedPartsItem];
            BMTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
            cell.selected = YES;
        }
        return;
    }
    
    [self.partsService findOnePartsItems:^(id service) {
        [self reloadData];
    }];
}

- (BMMainScene *)mainScene
{
    return (BMMainScene *)[self.scene.lastScene.children.firstObject selectedScene];
}

- (BMPartsService *)partsService
{
    return self.mainScene.orderService.partsService;
}

- (BMAutomobile *)automobile
{
    return self.mainScene.automobile;
}

- (NSArray *)allPartsItems
{
    return self.partsService.selectedParts.partsItems;
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return self.allPartsItems.count;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMPartsItem *partsItem = self.allPartsItems[indexPath.row];
    double price = (self.automobile.oilCapacity/4)*partsItem.fourLiterPrice + (self.automobile.oilCapacity%4)*partsItem.price;
    price = (partsItem.fourLiterPrice > 0) ? price : partsItem.price;
    partsItem.totalPrice = [NSNumber numberWithDouble:price];
    
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleValue accessoryType:BMTableViewCellAccessoryCheckmark];
//    cell.imageSprite.spriteFrame = [CCSpriteFrame frameWithContentsOfFile:partsItem.imageFile];
    cell.textLabel.string = partsItem.brandName;
    cell.detailTextLabel.string = [NSString stringWithFormat:@"%.0f %@", price, TEXT_PRICE_UNIT];
    
    return cell;
}

- (void)tableView:(BMTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMPartsItem *partsItem = self.partsService.selectedPartsItem;
    partsItem.selected = @(NO);
    self.mainScene.orderService.amount -= partsItem.totalPrice.doubleValue;
    
    partsItem = self.allPartsItems[indexPath.row];
    [partsItem setSelected:@(YES)];
    self.mainScene.orderService.amount += partsItem.totalPrice.doubleValue;
}

- (void)tableView:(BMTableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMPartsItem *partsItem = self.allPartsItems[indexPath.row];
    partsItem.selected = @(NO);
    self.mainScene.orderService.amount -= partsItem.totalPrice.doubleValue;
    
}

@end
