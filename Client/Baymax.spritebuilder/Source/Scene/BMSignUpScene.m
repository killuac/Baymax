//
//  BMSignUpScene.m
//  Baymax
//
//  Created by Killua Liu on 6/23/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMSignUpScene.h"

@implementation BMSignUpScene {
    __weak CCTextField *_vcodeTextField;
    __weak CCButton *_sendButton;
}

- (void)didLoadFromCCB
{
    [super didLoadFromCCB];
    self.navigationBar.titleLabel.string = BUTTON_TITLE_SIGNUP;
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return 3;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (2 == indexPath.row) {
        BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryNone];
        cell.imageSprite.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"icon_verification_code.png")];
        
        CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"button_accessory.png")];
        CCSprite *sprite = [CCSprite spriteWithSpriteFrame:spriteFrame];
        _sendButton = cell.accessoryButton;
        _sendButton.title = @"发送";
        _sendButton.position = ccpAdd(cell.accessoryButton.position, ccp(5, 0));
        _sendButton.preferredSize = cell.accessoryButton.maxSize = sprite.contentSize;
        [_sendButton setBackgroundSpriteFrame:spriteFrame forState:CCControlStateNormal];
        _sendButton.visible = YES;
        _sendButton.enabled= NO;
        _sendButton.userInteractionEnabled = cell.accessoryButton.togglesSelectedState = YES;
        [_sendButton setTarget:self selector:@selector(send:)];
        
        _vcodeTextField = cell.textField;
        CGFloat width = _vcodeTextField.contentSize.width - _sendButton.preferredSize.width;
        _vcodeTextField.preferredSize = CGSizeMake(width, _vcodeTextField.preferredSize.height);
        _vcodeTextField.maxLength = VERIFICATION_CODE_LENGTH;
        
        return cell;
    } else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)loadOnce
{
    [super loadOnce];
    _vcodeTextField.placeholder = @"短信验证码 (6位)";
    _vcodeTextField.keyboardType = BMKeyboardTypeNumberPad;
    
    _passwordTextField.block = ^(CCTextField *textField) {
        [_vcodeTextField becomeFirstResponder];
    };
}

- (void)update:(CCTime)delta
{
    [super update:delta];
    _sendButton.enabled = (_mobileTextField.string.length == MOBILE_MAX_LENGTH);
    _signButton.enabled = (_signButton.enabled && (_vcodeTextField.string.length == VERIFICATION_CODE_LENGTH));
}

- (void)send:(CCButton *)button
{
    
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.leftBarItem]) {
        [super navigationBar:navBar didSelectItem:item];
    }
}

- (void)signUp:(CCButton *)button
{
    NSURL *url = [BMServerAPI sharedServerAPI].usersURL;
    [[BMSessionManager sharedSessionManager] POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    }];
}

@end
