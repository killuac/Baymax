//
//  BMActivityIndicator.h
//  Baymax
//
//  Created by Killua Liu on 6/26/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCNode.h"

#define NAME_ACTIVITY_INDICATOR @"ActivityIndicator"

@interface BMActivityIndicator : CCNode

@property (nonatomic, weak, readonly) CCSprite *background;
@property (nonatomic, weak, readonly) CCSprite *iconSprite;

- (void)showInNode:(CCNode *)node;

@end
