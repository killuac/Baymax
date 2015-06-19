//
//  BMNavBarItem.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMNavBarItem.h"

@implementation BMNavBarItem

- (void)didLoadFromCCB
{
    self.visible = NO;
}

- (void)setNormalBackgroundImage:(NSString *)imageName
{
    CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:imageName];
    [self setBackgroundSpriteFrame:spriteFrame forState:CCControlStateNormal];
    
    self.visible = YES;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.visible = YES;
}

@end
