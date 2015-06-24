//
//  BMTableViewScene.m
//  Baymax
//
//  Created by Killua Liu on 6/19/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewScene.h"
#import "BMTabBarScene.h"

@implementation BMTableViewScene

- (id)init
{
    if (self = [super init]) {
        _tableView = (BMTableView *)[CCBReader load:@"TableView"];
        NSLog(@"%f, %f", self.navigationBar.contentSize.height, [self tabBar].contentSize.height);
        CGFloat height = SCREEN_HEIGHT - self.navigationBar.contentSize.height - [self tabBar].contentSize.height;
        _tableView.position = ccp(self.position.x, self.navigationBar.contentSize.height);
        _tableView.positionType = CCPositionTypeMake(CCPositionUnitPoints, CCPositionUnitPoints, CCPositionReferenceCornerTopLeft);
        _tableView.contentSize = CGSizeMake(self.contentSize.width, height);
        [self addChild:_tableView];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return self;
}

- (BMTabBar *)tabBar
{
    return [[self tabBarScene] respondsToSelector:@selector(tabBar)] ? (BMTabBar *)[[self tabBarScene] tabBar] : nil;
}

- (BMTabBarScene *)tabBarScene
{
    return (BMTabBarScene *)self.parent.parent;
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return 0;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
