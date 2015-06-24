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

+ (id)nodeWithData:(id)data
{
    return [CCNode node];
}

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

- (void)showText:(NSString *)text
{
    //!!!:
}

- (void)showActivityIndicator
{
    [self removeActivityIndicator];
    
    CCSprite *indicator = [CCSprite spriteWithImageNamed:IMG_FILE_NAME(@"activity_indicator.png")];
    indicator.position = SCREEN_CENTER;
    [self addChild:indicator z:1000 name:@"activityIndicator"];
    [indicator runRotateForever];
}

- (void)removeActivityIndicator
{
    [self removeChildByName:@"activityIndicator"];
}

- (void)runRotateForever
{
    id rotate = [CCActionRotateBy actionWithDuration:0.75 angle:360];
    id repeat = [CCActionRepeatForever actionWithAction:rotate];
    
    [self runAction:repeat];
}

@end
