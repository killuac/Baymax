//
//  CCTextureCache+BMTextureCache.m
//  Baymax
//
//  Created by Killua Liu on 6/13/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCTextureCache+BMTextureCache.h"
#import "CCTexture_Private.h"

@implementation CCTextureCache (BMTextureCache)

- (CCTexture *)addContentsOfFile:(NSString*)path
{
    NSAssert(path != nil, @"TextureCache: fileimage MUST not be nil");
    
    __block CCTexture *tex = nil;
    
    dispatch_sync(_dictQueue, ^{
        tex = [_textures objectForKey: path];
    });
    
    if (!tex) {
        CGFloat contentScale = [CCDirector sharedDirector].contentScaleFactor;
        
        tex = [self addPVRImage:path];
        
#if __CC_PLATFORM_IOS || __CC_PLATFORM_ANDROID
        
#if __CC_PLATFORM_IOS
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
        tex = [[CCTexture alloc] initWithCGImage:image.CGImage contentScale:contentScale];
#else // Android
        BOOL png = [path hasSuffix:@".png"];
        CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData((__bridge CFDataRef)[NSData dataWithContentsOfFile:path]);
        CGImageRef image = (png) ? CGImageCreateWithPNGDataProvider(imgDataProvider, NULL, true, kCGRenderingIntentDefault) : CGImageCreateWithJPEGDataProvider(imgDataProvider, NULL, true, kCGRenderingIntentDefault) ;
        tex = [[CCTexture alloc] initWithCGImage:image contentScale:contentScale];
        CGDataProviderRelease(imgDataProvider);
        CGImageRelease(image);
#endif
        CCLOGINFO(@"Texture loaded: %@", path);
        
        if( tex ){
            dispatch_sync(_dictQueue, ^{
                [_textures setObject: tex forKey:path];
                CCLOGINFO(@"Texture %@ cached: %p", path, tex);
            });
        }else{
            CCLOG(@"cocos2d: Couldn't create texture for file:%@ in CCTextureCache", path);
        }
        
#elif __CC_PLATFORM_MAC
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSBitmapImageRep *image = [[NSBitmapImageRep alloc] initWithData:data];
        tex = [ [CCTexture alloc] initWithCGImage:[image CGImage] contentScale:contentScale];


        if( tex ){
            dispatch_sync(_dictQueue, ^{
                [_textures setObject: tex forKey:path];
            });
        }else{
            CCLOG(@"cocos2d: Couldn't create texture for file:%@ in CCTextureCache", path);
        }
#endif
    }
    
    return((id)tex.proxy);
}

@end
