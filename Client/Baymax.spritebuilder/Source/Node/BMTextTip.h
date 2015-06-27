//
//  BMTextTip.h
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCNode.h"

#define NAME_TEXT_TIP   @"TextTip"

typedef NS_ENUM(NSUInteger, BMTextTipType) {
    BMTextTipTypeError,
    BMTextTipTypeWarning,
    BMTextTipTypeInformation,
    BMTextTipTypeSuccess,
    BMTextTipTypeHelp
};

@interface BMTextTip : CCNode

@property (nonatomic, weak, readonly) CCSprite *background;
@property (nonatomic, weak, readonly) CCSprite *iconSprite;
@property (nonatomic, weak, readonly) CCLabelTTF *textLabel;

- (void)showText:(NSString *)text type:(BMTextTipType)type inNode:(CCNode *)node;

@end
