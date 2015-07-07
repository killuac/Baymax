//
//  BMActivityIndicator.h
//  Baymax
//
//  Created by Killua Liu on 6/26/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCNode.h"

@interface BMActivityIndicator : CCNode

@property (nonatomic, weak, readonly) CCSprite *background;
@property (nonatomic, weak, readonly) CCSprite *bottomBox;
@property (nonatomic, weak, readonly) CCSprite *iconSprite;
@property (nonatomic, weak, readonly) CCLabelTTF *textLabel;

+ (void)show;
+ (void)showWithText:(NSString *)text;
+ (void)showWithText:(NSString *)text userInteractionEnabled:(BOOL)userInteractionEnabled;
+ (void)remove;
+ (void)resumeAnimation;

@end
