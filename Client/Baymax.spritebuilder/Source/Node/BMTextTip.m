//
//  BMTextTip.m
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMTextTip.h"
#import "BMConstant.h"

#define NAME_TEXT_TIP   @"TextTip"

@implementation BMTextTip

+ (void)showText:(NSString *)text
{
    [self showText:text type:BMTextTipTypeError];
}

+ (void)showText:(NSString *)text type:(BMTextTipType)type
{
    [self removeText];
    
    BMTextTip *textTip = (BMTextTip *)[CCBReader load:NAME_TEXT_TIP];
    [textTip showText:text type:type inScece:[CCDirector sharedDirector].runningScene];
}

+ (void)removeText
{
    [[CCDirector sharedDirector].runningScene removeChildByName:NAME_TEXT_TIP];
}

- (void)showText:(NSString *)text type:(BMTextTipType)type inScece:(CCScene *)scene;
{
    self.position = SCREEN_CENTER;
    self.textLabel.string = text;
    [scene addChild:self z:1000 name:NAME_TEXT_TIP];
    
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
            [self.class removeText];
        }];
    } delay:2];
}

@end
