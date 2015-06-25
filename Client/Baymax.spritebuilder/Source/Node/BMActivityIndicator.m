//
//  BMActivityIndicator.m
//  Baymax
//
//  Created by Killua Liu on 6/26/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMActivityIndicator.h"
#import "BMConstant.h"

@implementation BMActivityIndicator

- (void)showInNode:(CCNode *)node
{
    [self removeActivityIndicator];
    
    self.position = SCREEN_CENTER;
    [node addChild:self z:1000 name:@"activityIndicator"];
    [_iconSprite runRotateForever];
}

@end
