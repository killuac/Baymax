//
//  CCNode+BMNode.m
//  Baymax
//
//  Created by Killua Liu on 6/16/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCNode+BMNode.h"
#import "BMConstant.h"

@implementation CCNode (BMNode)

- (NSArray *)getAllChildren
{
    NSMutableArray *allChildren = [NSMutableArray array];
    [self getChildrenFrom:self.children to:allChildren];
    return allChildren;
}

- (void)getChildrenFrom:(NSArray *)array to:(NSMutableArray *)allChildren
{
    for (CCNode *node in array) {
        [allChildren addObject:node];
        if (node.children) {
            [self getChildrenFrom:node.children to:allChildren];
        }
    }
}

- (id)getNonRecursiveChildByName:(NSString *)name
{
    return [self getChildByName:name recursively:NO];
}

- (id)getRecursiveChildByName:(NSString *)name
{
    return [self getChildByName:name recursively:YES];
}

- (void)setUserInteractionEnabledRecursively:(BOOL)userInteractionEnabled
{
    for (id node in self.children) {
        if ([node isKindOfClass:[CCButton class]]) {
            [node setUserInteractionEnabled:userInteractionEnabled];
        } else {
            [node setUserInteractionEnabledRecursively:userInteractionEnabled];
        }
    }
}

#pragma mark - Animation
- (void)runRotateForever
{
    id rotate = [CCActionRotateBy actionWithDuration:DURATION_ROTATE angle:360];
    id repeat = [CCActionRepeatForever actionWithAction:rotate];
    
    [self runAction:repeat];
}

- (void)runFadeInWithBlock:(void (^)())block
{
    id fade = [CCActionFadeIn actionWithDuration:DURATION_FADE];
    id callBlock = (block) ? [CCActionCallBlock actionWithBlock:block] : nil;
    
    [self runAction:[CCActionSequence actions:fade, callBlock, nil]];
}

- (void)runFadeOutWithBlock:(void (^)())block
{
    id fade = [CCActionFadeOut actionWithDuration:DURATION_FADE];
    id callBlock = (block) ? [CCActionCallBlock actionWithBlock:block] : nil;
    
    [self runAction:[CCActionSequence actions:fade, callBlock, nil]];
}

- (void)runAnimationWithName:(NSString *)name block:(void (^)(id sender))block
{
    CCAnimationManager *animationManager = self.userObject;
    [animationManager setCompletedAnimationCallbackBlock:block];
    [animationManager runAnimationsForSequenceNamed:name];
}

@end
