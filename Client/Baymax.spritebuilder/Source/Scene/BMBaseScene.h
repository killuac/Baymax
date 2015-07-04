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
- (void)reloadData;

@optional
- (void)reloadData:(id)data;

@end

@interface BMBaseScene : CCNode <BMDataService> {
    CCNodeColor *_background;
}

@property (nonatomic, strong, readonly) CCScene *rootScene;

//@property (nonatomic, strong, readonly) CCNodeColor *background;

- (void)presentScene:(CCScene *)scene animated:(BOOL)animated;
- (void)presentSceneWithName:(NSString *)sceneName animated:(BOOL)animated;
- (void)dismissSceneAnimated:(BOOL)animated;
- (void)dismissToRootSceneAnimated:(BOOL)animated;

@end