//
//  BMAutoScene.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewScene.h"

@interface BMAutoScene : BMNavigationScene <BMTableViewDataSource, BMTableViewDelegate>

@property (nonatomic, weak, readonly) BMTableView *tableView;

@end
