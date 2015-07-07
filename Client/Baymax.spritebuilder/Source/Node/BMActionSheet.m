//
//  BMActionSheet.m
//  Baymax
//
//  Created by Killua Liu on 6/25/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMActionSheet.h"
#import "BMConstant.h"

@implementation BMActionSheet

+ (instancetype)actionSheet
{
    BMActionSheet *actionSheet = [self actionSheetWithCancelButtonTitle:BUTTON_TITLE_CANCEL destructiveButtonTitle:@""];
    [actionSheet.destructiveButton removeFromParent];
    return actionSheet;
}

+ (instancetype)actionSheetWithCancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle
{
    BMActionSheet *actionSheet = (BMActionSheet *)[CCBReader load:@"ActionSheet"];
    actionSheet.cancelButton.title = cancelButtonTitle;
    actionSheet.destructiveButton.title = destructiveButtonTitle;
    return actionSheet;
}

- (void)didLoadFromCCB
{
    for (CCButton *button in _buttonsBox.children) {
        button.block = ^(id sender) {
            if ([_delegate respondsToSelector:@selector(actionSheet:clickedButton:)]) {
                [_delegate actionSheet:self clickedButton:sender];
            }
        };
    }
}

- (void)addButtonWithTitle:(NSString *)title
{
    CCButton *button = [_cancelButton copyButtonWithTitle:title];
    button.label.fontColor = [CCColor colorWithRed:0 green:145/255.0 blue:1];
    button.block = ^(id sender) {
        if ([_delegate respondsToSelector:@selector(actionSheet:clickedButton:)]) {
            [_delegate actionSheet:self clickedButton:sender];
        }
    };
    
    [_buttonsBox addChild:button];
}

- (CCScene *)runningScene
{
    return [CCDirector sharedDirector].runningScene;
}

- (void)show
{
    [self.runningScene setUserInteractionEnabledRecursively:NO];
    
    [self runAnimationWithName:@"show" block:nil];
    [self.runningScene addChild:self];
}

- (void)dismiss
{
    [self runAnimationWithName:@"dismiss" block:^(id sender) {
        [self removeFromParent];
        [self.runningScene setUserInteractionEnabledRecursively:YES];
    }];
}

@end
