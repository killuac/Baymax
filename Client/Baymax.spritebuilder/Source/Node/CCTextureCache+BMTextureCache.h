//
//  CCTextureCache+BMTextureCache.h
//  Baymax
//
//  Created by Killua Liu on 6/13/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCTextureCache.h"

@interface CCTextureCache (BMTextureCache)

- (CCTexture *)addContentsOfFile:(NSString*)path;

@end
