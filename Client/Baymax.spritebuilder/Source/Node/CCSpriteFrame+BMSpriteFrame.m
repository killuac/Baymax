//
//  CCSpriteFrame+BMSpriteFrame.m
//  Baymax
//
//  Created by Killua Liu on 6/13/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCSpriteFrame+BMSpriteFrame.h"

@implementation CCSpriteFrame (BMSpriteFrame)

+ (instancetype)frameWithContentsOfFile:(NSString*)path
{
    CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:path];
    if (!frame) {
        CCTexture* texture = [[CCTextureCache sharedTextureCache] addContentsOfFile:path];
        frame = [texture createSpriteFrame];
    }
    return frame;
}

@end
