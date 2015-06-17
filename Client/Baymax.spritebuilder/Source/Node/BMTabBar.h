//
//  BMTabBar.h
//  Baymax
//
//  Created by Killua Liu on 6/11/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCNode.h"
#import "BMTabBarItem.h"

@protocol BMTabBarDelegate;

@interface BMTabBar : CCNode {
    CCLayoutBox *_barItemsBox;
}

@property (nonatomic, weak) id <BMTabBarDelegate> delegate;
@property (nonatomic, weak, readonly) NSArray *items;
@property (nonatomic, weak, readonly) BMTabBarItem *selectedItem;

- (void)selectItem:(BMTabBarItem *)item;

@end

@protocol BMTabBarDelegate<NSObject>

- (void)tabBar:(BMTabBar *)tabBar didSelectItem:(BMTabBarItem *)item;

@end
