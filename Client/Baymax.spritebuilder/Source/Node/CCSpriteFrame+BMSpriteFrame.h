//
//  CCSpriteFrame+BMSpriteFrame.h
//  Baymax
//
//  Created by Killua Liu on 6/13/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCSpriteFrame.h"

@interface CCSpriteFrame (BMSpriteFrame)

+ (instancetype)frameWithContentsOfFile:(NSString *)path;
+ (instancetype)frameWithData:(NSData *)data;

@end
