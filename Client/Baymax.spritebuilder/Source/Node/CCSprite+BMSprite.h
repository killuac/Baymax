//
//  CCSprite+BMSprite.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCSprite.h"

@interface CCSprite (BMSprite)

+ (instancetype)spriteWithContentsOfFile:(NSString *)path;

- (id)copySprite;
- (id)copySprite9Slice;

- (CCSpriteFrame *)newRoundCornerSpriteFrameWithRadius:(CGFloat[])radiuses;

@end
