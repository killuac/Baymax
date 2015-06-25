//
//  BMSignInScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMSignInScene.h"
#import "BMCredential.h"

@implementation BMSignInScene

- (void)didLoadFromCCB
{
    self.signButton.enabled = NO;
    
    self.navigationBar.delegate = self;
    self.navigationBar.titleLabel.string = BUTTON_TITLE_SIGNIN;
    self.navigationBar.leftBarItem.title = BUTTON_TITLE_CANCEL;
    
    _tableView.verticalScrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self scheduleOnce:@selector(loadOnce) delay:0];
    
    _userService = [BMUserService new];
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return 2;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryNone];
    
    NSString *imageName = nil;
    if (0 == indexPath.row) {
        imageName = @"icon_mobile.png";
        _mobileTextField = cell.textField;
        _mobileTextField.maxLength = MOBILE_MAX_LENGTH;
    }
    else {
        imageName = @"icon_password.png";
        CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"button_password.png")];
        CCSpriteFrame *spriteFrameSel = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"button_password_selected.png")];
        CCSprite *sprite = [CCSprite spriteWithSpriteFrame:spriteFrame];
        CCButton *accessoryButton = cell.accessoryButton;
        accessoryButton.preferredSize = accessoryButton.maxSize = sprite.contentSize;
        [accessoryButton setBackgroundSpriteFrame:spriteFrame forState:CCControlStateNormal];
        [accessoryButton setBackgroundSpriteFrame:spriteFrameSel forState:CCControlStateSelected];
        accessoryButton.visible = YES;
        accessoryButton.userInteractionEnabled = accessoryButton.togglesSelectedState = YES;
        [accessoryButton setTarget:self selector:@selector(eyePressed:)];
        
        _passwordTextField = cell.textField;
        CGFloat width = _passwordTextField.contentSize.width - accessoryButton.preferredSize.width;
        _passwordTextField.preferredSize = CGSizeMake(width, _passwordTextField.preferredSize.height);
        _passwordTextField.secureTextEntry = YES;
    }
    cell.imageSprite.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(imageName)];
    
    return cell;
}

- (BOOL)tableView:(BMTableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)eyePressed:(CCButton *)button
{
    CCControlState controlState = (button.selected) ? CCControlStateSelected : CCControlStateNormal;
    [button setBackgroundSpriteFrame:[button backgroundSpriteFrameForState:controlState] forState:CCControlStateHighlighted];
    
    _passwordTextField.secureTextEntry = !button.selected;
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.leftBarItem]) {
        [self dismissSceneAnimated:YES];
    }
}

- (void)loadOnce
{
//  CCEditText(Android) is created async by calling dispatch_async(), so need set placeholder until creation finished.
    _mobileTextField.placeholder = PLACEHOLDER_MOBILE;
    _passwordTextField.placeholder = PLACEHOLDER_PASSWORD;
    
    _mobileTextField.keyboardType = BMKeyboardTypeNumberPad;
    _passwordTextField.keyboardType = BMKeyboardTypeASCIICapable;
    
    _mobileTextField.string = [BMCredential sharedCredential].mobile;
    [_mobileTextField becomeFirstResponder];
}

- (void)update:(CCTime)delta
{
    _signButton.enabled = (_mobileTextField.string.length == MOBILE_MAX_LENGTH && _passwordTextField.string.length >= PASSWORD_MIN_LENGTH);
}

- (void)signIn:(CCButton *)button
{
    BMUser *user = [BMUser new];
    user.mobile = _mobileTextField.string;
    user.password = _passwordTextField.string;
    
    [_userService signInWithData:user result:^(id service) {
        if (_userService.user.isNotFound) {
            [self showTextTip:TIP_MOBILE_NOT_FOUND];
        } else if (_userService.user.isWrongPassword) {
            [self showTextTip:TIP_PASSWORD_WRONG];
        } else {
            [self showMainScene];
        }
    }];
}

- (void)showMainScene
{
    CCScene *scene = [CCBReader loadAsScene:MAIN_SCENE];
    [[CCDirector sharedDirector] replaceScene:scene withTransition:[CCTransition transitionFade]];
    
    [self saveUserCredential];
}

- (void)saveUserCredential
{
    [BMCredential sharedCredential].mobile = _mobileTextField.string;
    [BMCredential sharedCredential].password = _passwordTextField.string;
    [BMCredential sharedCredential].isSignedIn = YES;
    [[BMCredential sharedCredential] save];
}

@end
