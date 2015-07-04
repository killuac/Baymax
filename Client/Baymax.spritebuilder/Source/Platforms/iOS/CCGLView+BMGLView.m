//
//  CCGLView+BMGLView.m
//  Baymax
//
//  Created by Killua Liu on 7/2/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCGLView+BMGLView.h"

@implementation CCGLView (BMGLView)

+ (void)load
{
    Method original = class_getInstanceMethod(self.class, @selector(touchesEnded:withEvent:));
    Method swizzled = class_getInstanceMethod(self.class, @selector(swizzledTouchesEnded:withEvent:));
    
    method_exchangeImplementations(original, swizzled);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    for (UIView *view in self.superview.subviews) {
        if ([view isMemberOfClass:[UITextField class]]) {
            UIView *hitedView = [view hitTest:point withEvent:event];
            if (hitedView) {
                return hitedView;
            }
        }
    }

    return [super hitTest:point withEvent:event];
}

- (void)swizzledTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self swizzledTouchesEnded:touches withEvent:event];
    
    for (UIView *view in self.superview.subviews) {
        view.userInteractionEnabled = YES;
    }
}

+ (void)removeBackgroundUIView
{
    UIView *superView = [CCDirector sharedDirector].view.superview;
    
    for (UIView *view in superView.subviews) {
        if ([view isMemberOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
}

@end
