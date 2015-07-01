//
//  CCButton+BMButton.m
//  Baymax
//
//  Created by Killua Liu on 6/26/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCButton+BMButton.h"

@implementation CCButton (BMButton)

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
