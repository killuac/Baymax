//
//  BMNavigationBar.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMNavigationBar.h"

@implementation BMNavigationBar

- (void)didLoadFromCCB
{
#if __CC_PLATFORM_ANDROID
    [self setHeight:[self height] - 20];
#endif
}

- (void)setHeight:(CGFloat)height
{
    self.contentSize = CGSizeMake(self.contentSize.width, height);
}

- (CGFloat)height
{
    return self.contentSize.height;
}

- (void)selectItem:(BMNavBarItem *)item
{
    if ([_delegate respondsToSelector:@selector(navigationBar:didSelectItem:)]) {
        [_delegate navigationBar:self didSelectItem:item];
    }
}

@end
