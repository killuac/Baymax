//
//  BMButtonFactory.m
//  Baymax
//
//  Created by Killua Liu on 7/3/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMButtonFactory.h"
#import "BMConstant.h"

@implementation BMButtonFactory

+ (id)createToggleButton
{
    CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"button_toggle_off.png")];
    CCSpriteFrame *spriteFrameSel = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"button_toggle_on.png")];
    CCButton *toggle = [CCButton buttonWithTitle:@"" spriteFrame:spriteFrame highlightedSpriteFrame:nil disabledSpriteFrame:nil];
    [toggle setBackgroundSpriteFrame:spriteFrameSel forState:CCControlStateSelected];
    toggle.togglesSelectedState = YES;
    toggle.anchorPoint = ccp(1, 0.5);
    
    return toggle;
}

+ (id)createToggleButton:(BMTableViewCell *)cell
{
    CCButton *button = [self createToggleButton];
    [self addButton:button toCell:cell];
    
    return button;
}

+ (id)createPasswordButtonInCell:(BMTableViewCell *)cell
{
    CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"button_password.png")];
    CCSpriteFrame *spriteFrameSel = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"button_password_selected.png")];
    CCButton *button = [CCButton buttonWithTitle:@"" spriteFrame:spriteFrame highlightedSpriteFrame:nil disabledSpriteFrame:nil];
    [button setBackgroundSpriteFrame:spriteFrameSel forState:CCControlStateSelected];
    button.togglesSelectedState = YES;
    [self addButton:button toCell:cell];
    
    return button;
}

+ (id)createNormalAccessoryButtonInCell:(BMTableViewCell *)cell
{
    CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"button_accessory.png")];
    CCButton *button = [CCButton buttonWithTitle:@"" spriteFrame:spriteFrame];
    [self addButton:button toCell:cell];
    
    return button;
}

+ (void)addButton:(CCButton *)button toCell:(BMTableViewCell *)cell
{
    button.anchorPoint = cell.accessoryButton.anchorPoint;
    button.position = cell.accessoryButton.position;
    button.positionType = cell.accessoryButton.positionType;
    [cell addChild:button];
    
    [cell.accessoryButton removeFromParent];
    cell.accessoryButton = button;
}

+ (id)createAccessoryButtonWithImageName:(NSString *)imageName inCell:(BMTableViewCell *)cell
{
    CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:[imageName stringByAppendingString:@".png"]];
    CCSpriteFrame *spriteFrameHL = [CCSpriteFrame frameWithImageNamed:[imageName stringByAppendingString:@"_highlighted.png"]];
    CCButton *button = [CCButton buttonWithTitle:@"" spriteFrame:spriteFrame highlightedSpriteFrame:spriteFrameHL disabledSpriteFrame:nil];
    [button setBackgroundSpriteFrame:spriteFrame forState:CCControlStateSelected];
    [button setBackgroundColor:[CCColor whiteColor] forState:CCControlStateHighlighted];
    [self addButton:button toCell:cell];
    
    return button;
}

@end
