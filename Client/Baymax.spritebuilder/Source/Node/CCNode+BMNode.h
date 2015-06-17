//
//  CCNode+BMNode.h
//  Baymax
//
//  Created by Killua Liu on 6/16/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCNode.h"

@interface CCNode (BMNode)

- (id)getNonRecursiveChildByName:(NSString *)name;
- (id)getRecursiveChildByName:(NSString *)name;

@end
