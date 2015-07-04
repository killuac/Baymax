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
+ (instancetype)spriteWithData:(NSData *)data;

- (id)copySprite;
- (id)copySprite9Slice;

- (CGImageRef)newCGImage;
- (CCSpriteFrame *)newRoundCornerSpriteFrameWithRadius:(CGFloat[])radiuses;
- (void)drawFullRoundCorner;

@end
