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
    [[self tableViewCell] setHighlighted:self.enabled];
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [super touchEnded:touch withEvent:event];
    [[self tableViewCell] setHighlighted:NO];
}

- (void)touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [super touchCancelled:touch withEvent:event];
    [[self tableViewCell] setHighlighted:NO];
}

#else   // __CC_PLATFORM_MAC
- (void)mouseDown:(NSEvent *)theEvent
{
    [super mouseDown:theEvent];
    [[self tableViewCell] setHighlighted:self.enabled];
}

- (void)mouseDownExited:(NSEvent *)event
{
    self.highlighted = NO;
    [[self tableViewCell] setHighlighted:NO];
}

- (void)mouseUp:(NSEvent *)theEvent
{
    [[self tableViewCell] setHighlighted:NO];
    [super mouseUp:theEvent];
}
#endif

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p | Name = %@ | ZOrder = %tu | AnchorPoint = %@ | Position = %@ | ContentSize = %@>",
            [self class], self, _name, _zOrder, StringFromCGPoint(_anchorPoint), StringFromCGPoint(_position), StringFromCGSize(_contentSize)];
}

@end
