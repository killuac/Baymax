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

- (void)showTextTip:(NSString *)text
{
    [self showTextTip:text withType:BMTextTipTypeError];
}

- (void)showTextTip:(NSString *)text withType:(BMTextTipType)type
{
    BMTextTip *textTip = (BMTextTip *)[CCBReader load:@"TextTip"];
    [textTip showText:text type:type inNode:self];
}

- (void)removeTextTip
{
    [self removeActivityIndicator];
    [self removeChildByName:@"textTip"];
}

- (void)showActivityIndicator
{
    BMActivityIndicator *activityIndicator = (BMActivityIndicator *)[CCBReader load:@"ActivityIndicator"];
    [activityIndicator showInNode:self];
}

- (void)removeActivityIndicator
{
    [self removeChildByName:@"activityIndicator"];
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

@end
