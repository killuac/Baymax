//
//  BMCellButton.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCButton.h"

@interface BMCellButton : CCButton

- (void)setBackgroundSpriteFrame:(CCSpriteFrame *)spriteFrame;

- (void)drawTopRoundCorner;
- (void)drawBottomRoundCorner;
- (void)drawFullRoundCorner;

@end