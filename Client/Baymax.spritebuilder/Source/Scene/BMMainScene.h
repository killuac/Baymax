//
//  BMMainScene.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMNavigationScene.h"
#import "BMTableView.h"

@interface BMMainScene : BMNavigationScene

@property (nonatomic, weak, readonly) BMTableView *tableView;

@end
