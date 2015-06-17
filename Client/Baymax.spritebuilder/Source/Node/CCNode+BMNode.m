//
//  CCNode+BMNode.m
//  Baymax
//
//  Created by Killua Liu on 6/16/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCNode+BMNode.h"

@implementation CCNode (BMNode)

- (id)getNonRecursiveChildByName:(NSString *)name
{
    return [self getChildByName:name recursively:NO];
}

- (id)getRecursiveChildByName:(NSString *)name
{
    return [self getChildByName:name recursively:YES];
}

@end
