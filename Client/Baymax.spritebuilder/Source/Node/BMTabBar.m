//
//  BMTabBar.m
//  Baymax
//
//  Created by Killua Liu on 6/11/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTabBar.h"

@implementation BMTabBar

- (void)didLoadFromCCB
{
    _items = _barItemsBox.children;
    _selectedItem = _items.firstObject;
    _selectedItem.selected = YES;
}

- (void)selectItem:(BMTabBarItem *)item
{
    item.selected = YES;
    _selectedItem.selected = NO;
    _selectedItem = item;
    
    [_delegate tabBar:self didSelectItem:item];
}

@end
