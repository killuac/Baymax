//
//  BMUserScene.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMNavigationScene.h"
#import "BMTableView.h"

@interface BMUserScene : BMNavigationScene

@property (nonatomic, weak, readonly) BMTableView *tableView;

@end
