//
//  BMPartsScene.h
//  Baymax
//
//  Created by Killua Liu on 6/30/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTableViewScene.h"
#import "BMMainScene.h"

@interface BMPartsScene : BMTableViewScene

@property (nonatomic, weak, readonly) BMMainScene *mainScene;
@property (nonatomic, weak, readonly) BMPartsService *partsService;

@end
