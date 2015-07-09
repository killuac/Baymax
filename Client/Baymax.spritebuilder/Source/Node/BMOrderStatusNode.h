//
//  BMOrderStatusNode.h
//  Baymax
//
//  Created by Killua Liu on 7/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCNode.h"
#import "BMOrderStatusSprite.h"

@interface BMOrderStatusNode : CCNode

@property (nonatomic, weak, readonly) BMOrderStatusSprite *stepCreated;
@property (nonatomic, weak, readonly) BMOrderStatusSprite *stepAcceptance;
@property (nonatomic, weak, readonly) BMOrderStatusSprite *stepCompletion;

@property (nonatomic, weak, readonly) CCSprite9Slice *linkLineOne;
@property (nonatomic, weak, readonly) CCSprite9Slice *linkLineTwo;

- (void)updateStatus;

@end
