//
//  BMTabBarItem.m
//  Baymax
//
//  Created by Killua Liu on 6/11/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTabBarItem.h"

@implementation BMTabBarItem

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.enabled = !selected;
}

@end
