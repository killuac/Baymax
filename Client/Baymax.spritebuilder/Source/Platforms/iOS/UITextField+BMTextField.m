//
//  UITextField+BMTextField.m
//  Baymax
//
//  Created by Killua Liu on 7/2/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "UITextField+BMTextField.h"

@implementation UITextField (BMTextField)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(self.frame, point) && self.userInteractionEnabled) {
        return self;
    }
    return nil;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.userInteractionEnabled = NO;
}

@end
