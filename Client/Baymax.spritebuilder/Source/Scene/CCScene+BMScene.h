//
//  CCScene+BMScene.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCScene.h"

@interface CCScene (BMScene)

@property (nonatomic, strong) CCScene *lastScene;

+ (instancetype)sceneWithNode:(CCNode *)node;

@end
