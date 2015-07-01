//
//  BMCellButton.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMCellButton.h"
#import "BMTableViewCell.h"
#import "BMUtil.h"

@implementation BMCellButton

- (void)setBackgroundSpriteFrame:(CCSpriteFrame *)spriteFrame
{
    [self setBackgroundSpriteFrame:spriteFrame forState:CCControlStateNormal];
    [self setBackgroundSpriteFrame:spriteFrame forState:CCControlStateHighlighted];
}

- (void)drawTopRoundCorner
{
    CGFloat radiuses[4] = {8, 8, 0, 0};
    [self setBackgroundSpriteFrame:[self.background newRoundCornerSpriteFrameWithRadius:radiuses]];
}

- (void)drawBottomRoundCorner
{
    CGFloat radiuses[4] = {0, 0, 8, 8};
    [self setBackgroundSpriteFrame:[self.background newRoundCornerSpriteFrameWithRadius:radiuses]];
}

- (void)drawFullRoundCorner
{
    CGFloat radiuses[4] = {8, 8, 8, 8};
    [self setBackgroundSpriteFrame:[self.background newRoundCornerSpriteFrameWithRadius:radiuses]];
}

- (BMTableViewCell *)tableViewCell
{
    return (BMTableViewCell *)self.parent;
}

#if __CC_PLATFORM_IOS || __CC_PLATFORM_ANDROID
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [super touchBegan:touch withEvent:event];
    if (touch.tapCount == 1 && self.enabled) {
        [[self tableViewCell] setHighlighted:self.enabled];
    }
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    if (touch.tapCount <= 1 && self.enabled) {
        [[self tableViewCell] setHighlighted:NO];
        [super touchEnded:touch withEvent:event];
    }
}

- (void)touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    if (touch.tapCount <= 1 && self.enabled) {
        [[self tableViewCell] setHighlighted:NO];
        [super touchCancelled:touch withEvent:event];
    }
}

#else   // __CC_PLATFORM_MAC
- (void)mouseDown:(NSEvent *)theEvent
{
    [super mouseDown:theEvent];
    if (self.enabled) {
        [[self tableViewCell] setHighlighted:self.enabled];
    }
}

- (void)mouseDownExited:(NSEvent *)event
{
    if (self.enabled) {
        self.highlighted = NO;
        [[self tableViewCell] setHighlighted:NO];
    }
}

- (void)mouseUp:(NSEvent *)theEvent
{
    if (self.enabled) {
        [[self tableViewCell] setHighlighted:NO];
        [super mouseUp:theEvent];
    }
}
#endif

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p | Name = %@ | ZOrder = %tu | AnchorPoint = %@ | Position = %@ | ContentSize = %@>",
            [self class], self, _name, _zOrder, StringFromCGPoint(_anchorPoint), StringFromCGPoint(_position), StringFromCGSize(_contentSize)];
}

@end
