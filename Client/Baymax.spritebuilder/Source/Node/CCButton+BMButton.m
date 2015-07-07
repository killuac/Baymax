//
//  CCButton+BMButton.m
//  Baymax
//
//  Created by Killua Liu on 6/26/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCButton+BMButton.h"

@implementation CCButton (BMButton)

- (id)copyButtonWithTitle:(NSString *)title
{
    CCButton *button = [CCButton buttonWithTitle:title spriteFrame:self.background.spriteFrame];
    [button setBackgroundSpriteFrame:[self backgroundSpriteFrameForState:CCControlStateHighlighted] forState:CCControlStateHighlighted];
    [button setBackgroundSpriteFrame:[self backgroundSpriteFrameForState:CCControlStateSelected] forState:CCControlStateSelected];
    [button setBackgroundSpriteFrame:[self backgroundSpriteFrameForState:CCControlStateDisabled] forState:CCControlStateDisabled];
    
    button.anchorPoint = self.anchorPoint;
    button.positionType = self.positionType;
    button.contentSizeType = self.contentSizeType;
    button.contentSize = self.contentSize;
    button.preferredSize = self.preferredSize;
    button.maxSize = self.maxSize;
    button.label.fontSize = self.label.fontSize;
    
    return button;
}

#if !__CC_PLATFORM_MAC
static NSTimeInterval previousTimestamp;

// To avoid press two different buttons instancely
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    if (touch.tapCount == 1 && (touch.timestamp - previousTimestamp) > DURATION_SCENE_TRANSITION) {
        [super touchBegan:touch withEvent:event];
    }
    previousTimestamp = touch.timestamp;
}

- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    if (touch.tapCount == 1) {
        [super touchMoved:touch withEvent:event];
    }
    previousTimestamp = touch.timestamp;
}
#endif

@end
