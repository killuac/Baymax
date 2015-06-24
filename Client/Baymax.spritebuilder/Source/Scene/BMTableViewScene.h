//
//  BMTableViewScene.h
//  Baymax
//
//  Created by Killua Liu on 6/19/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMNavigationScene.h"
#import "BMTableView.h"

@interface BMTableViewScene : BMNavigationScene <BMTableViewDataSource, BMTableViewDelegate> {
    BMTableView *_tableView;
}

@property (nonatomic, strong, readonly) BMTableView *tableView;

@end
