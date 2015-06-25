//
//  BMBaseScene.h
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCNode.h"
#import "BMConstant.h"
#import "BMBaseService.h"

@protocol BMDataService <NSObject>

- (void)loadData;

@end

@interface BMBaseScene : CCNode <BMDataService> {
    CCNodeColor *_background;
}

@property (nonatomic, strong, readonly) CCNodeColor *background;

- (void)presentScene:(CCScene *)scene animated:(BOOL)animated;
- (void)presentSceneWithName:(NSString *)sceneName animated:(BOOL)animated;
- (void)dismissSceneAnimated:(BOOL)animated;

@end