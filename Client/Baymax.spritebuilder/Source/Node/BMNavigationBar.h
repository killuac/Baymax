//
//  BMNavigationBar.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCNode.h"
#import "BMNavBarItem.h"

@protocol BMNavigationBarDelegate;

@interface BMNavigationBar : CCNode

@property (nonatomic, weak) id <BMNavigationBarDelegate> delegate;
@property (nonatomic, weak, readonly) CCLabelTTF *titleLabel;
@property (nonatomic, weak, readonly) BMNavBarItem *leftBarItem;
@property (nonatomic, weak, readonly) BMNavBarItem *rightBarItem;

- (void)selectItem:(BMNavBarItem *)item;

@end

@protocol BMNavigationBarDelegate<NSObject>

@optional
- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item;

@end