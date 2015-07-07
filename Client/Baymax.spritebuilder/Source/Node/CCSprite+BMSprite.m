//
//  CCSprite+BMSprite.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCSprite+BMSprite.h"

@implementation CCSprite (BMSprite)

+ (instancetype)spriteWithContentsOfFile:(NSString *)path
{
    return [self spriteWithSpriteFrame:[CCSpriteFrame frameWithContentsOfFile:path]];
}

+ (instancetype)spriteWithData:(NSData *)data
{
    return [self spriteWithSpriteFrame:[CCSpriteFrame frameWithData:data]];
}

- (id)copySprite
{
    CCSprite *sprite = [CCSprite spriteWithSpriteFrame:self.spriteFrame];
    [self copyPropertiesToSprite:sprite];
    return sprite;
}

- (id)copySprite9Slice
{
    CCSprite9Slice *sprite = [CCSprite9Slice spriteWithSpriteFrame:self.spriteFrame];
    [self copyPropertiesToSprite:sprite];
    return sprite;
}

- (void)copyPropertiesToSprite:(CCSprite *)sprite
{
    sprite.anchorPoint = self.anchorPoint;
    sprite.positionType = self.positionType;
    sprite.contentSizeType = self.contentSizeType;
    sprite.contentSize = self.contentSize;
}

- (CCSpriteFrame *)newRoundCornerSpriteFrameWithRadius:(CGFloat[])radiuses
{
    CGImageRef imageRef = [self newCGImage];
    size_t w = self.contentSize.width;
    size_t h = self.contentSize.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, w, h);
    addRoundedRectToPath(context, rect, radiuses);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, rect, imageRef);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    NSArray *array = [NSArray arrayWithObjects:@(radiuses[0]), @(radiuses[1]), @(radiuses[2]), @(radiuses[3]), nil];
    CCSprite *sprite = [CCSprite spriteWithCGImage:imageMasked key:[array componentsJoinedByString:@""]];
    CGImageRelease(imageMasked);
    
    return [CCSpriteFrame frameWithTexture:sprite.texture
                              rectInPixels:sprite.textureRect
                                   rotated:sprite.textureRectRotated
                                    offset:sprite.offsetPosition
                              originalSize:sprite.contentSize];
}

- (CGImageRef)newCGImage
{
    CCRenderTexture *renderTexture = [CCRenderTexture renderTextureWithWidth:self.contentSize.width height:self.contentSize.height];
    
    [renderTexture begin];
    [self visit];
    [renderTexture end];
    
    return [renderTexture newCGImage];
}

void addRoundedRectToPath(CGContextRef context, CGRect rect, CGFloat radiuses[4])
{
    CGContextSaveGState(context);
    float fw = CGRectGetWidth(rect);
    float fh = CGRectGetHeight(rect);
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, radiuses[0]);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, radiuses[1]);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, radiuses[2]);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, radiuses[3]);
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

//void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
//{
//    float fw, fh;
//    if (ovalWidth == 0 || ovalHeight == 0) {
//        CGContextAddRect(context, rect);
//        return;
//    }
//    
//    CGContextSaveGState(context);
//    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
//    CGContextScaleCTM(context, ovalWidth, ovalHeight);
//    fw = CGRectGetWidth(rect) / ovalWidth;
//    fh = CGRectGetHeight(rect) / ovalHeight;
//    CGContextMoveToPoint(context, fw, fh/2);
//    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
//    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
//    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
//    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
//    
//    CGContextClosePath(context);
//    CGContextRestoreGState(context);
//}

- (void)drawFullRoundCorner
{
//    CGFloat radiuses[4] = {40, 40, 40, 40};
//    self.spriteFrame = [self newRoundCornerSpriteFrameWithRadius:radiuses];
}

@end
