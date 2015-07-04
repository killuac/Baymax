//
//  CCScene+BMScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCScene+BMScene.h"
#import "BMConstant.h"

@implementation CCScene (BMScene)

+ (void)load
{
    Method original = class_getInstanceMethod(self.class, @selector(init));
    Method swizzled = class_getInstanceMethod(self.class, @selector(swizzledInit));
    
    method_exchangeImplementations(original, swizzled);
}

- (instancetype)swizzledInit
{
    CCScene *scene = [self swizzledInit];
    scene.colorRGBA = BACKGROUND_COLOR;
    return scene;
}

+ (instancetype)sceneWithNode:(CCNode *)node
{
    CCScene *scene = [CCScene node];
    [scene addChild:node];
    return scene;
}

- (void)setLastScene:(CCScene *)lastScene
{
    objc_setAssociatedObject(self, @selector(lastScene), lastScene, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CCScene *)lastScene
{
    return objc_getAssociatedObject(self, @selector(lastScene));
}

@end
