//
//  BMTextTip.m
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTextTip.h"
#import "BMConstant.h"

@implementation BMTextTip

- (void)showText:(NSString *)text type:(BMTextTipType)type inNode:(CCNode *)node
{
    [node removeTextTip];
    
    self.position = SCREEN_CENTER;
    _textLabel.string = text;
    [node addChild:self z:1000 name:@"textTip"];
    
    NSString *imageName = nil;
    switch (type) {
        case BMTextTipTypeError:
            imageName = @"icon_error.png";
            break;
            
        case BMTextTipTypeWarning:
            imageName = @"icon_warning.png";
            break;
            
        case BMTextTipTypeInformation:
            imageName = @"icon_information.png";
            break;
            
        case BMTextTipTypeSuccess:
            imageName = @"icon_success.png";
            break;
            
        case BMTextTipTypeHelp:
            imageName = @"icon_help.png";
            break;
    }
    _iconSprite.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(imageName)];
    
    [self scheduleBlock:^(CCTimer *timer) {
        [self.background runFadeOutWithBlock:^{
            [node removeTextTip];
        }];
    } delay:2];
}

@end
