//
//  BMSignInScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMSignInScene.h"
#import "BMCredential.h"
#import "BMTabBarScene.h"
#import "BMButtonFactory.h"

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
    [_tableView setupWithStyle:BMTableViewStylePlain];
    
    [self scheduleOnce:@selector(loadOnce) delay:0];
    
    _userService = [[BMUserService alloc] init];
}

- (NSUInteger)tableView:(BMTableView *)tableView numberOfRowsInSection:(NSUInteger)section
{
    return 2;
}

- (BMTableViewCell *)tableView:(BMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMTableViewCellAccessoryType accessoryType = (0 == indexPath.row) ? BMTableViewCellAccessoryNone : BMTableViewCellAccessoryDetailDisclosureButton;
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:accessoryType];
    
    NSString *imageName = nil;
    if (0 == indexPath.row) {
        imageName = @"icon_mobile.png";
        _mobileTextField = cell.textField;
        _mobileTextField.maxLength = MOBILE_MAX_LENGTH;
        _mobileTextField.placeholder = PLACEHOLDER_MOBILE;
    }
    else {
        imageName = @"icon_password.png";
        cell.accessoryButton = [BMButtonFactory createPasswordButtonInCell:cell];
        [cell.accessoryButton setTarget:self selector:@selector(eyePressed:)];
        
        _passwordTextField = cell.textField;
        CGFloat width = _passwordTextField.contentSize.width - cell.accessoryButton.preferredSize.width;
        _passwordTextField.preferredSize = CGSizeMake(width, _passwordTextField.preferredSize.height);
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.placeholder = PLACEHOLDER_PASSWORD;
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
    
    [_mobileTextField setTarget:self selector:@selector(checkMobileNumber:)];
    [_passwordTextField setTarget:self selector:@selector(checkPassword:)];
}

- (void)checkMobileNumber:(CCTextField *)textField
{
//  !!! - 校验手机号码是否有效
}

- (void)checkPassword:(CCTextField *)textField
{
//  !!! - 校验密码是否含有非法字符
}

- (void)update:(CCTime)delta
{
    _signButton.enabled = (_mobileTextField.string.length == MOBILE_MAX_LENGTH && _passwordTextField.string.length >= PASSWORD_MIN_LENGTH);
}

- (void)signIn:(CCButton *)button
{    
    BMUser *user = [[BMUser alloc] init];
    user.mobile = _mobileTextField.string;
    user.password = _passwordTextField.string;
    
    [_userService signInWithData:user result:^(id service) {
        if (_userService.user.isNotFound) {
            [BMTextTip showText:TIP_MOBILE_NOT_FOUND];
        } else if (_userService.user.isWrongPassword) {
            [BMTextTip showText:TIP_PASSWORD_WRONG];
        } else {
            [self showMainScene];
        }
    }];
}

- (void)showMainScene
{
    if (!_userService.user) return;
    
    BMTabBarScene *tabBarScene = (BMTabBarScene *)[CCBReader load:MAIN_SCENE];
    tabBarScene.userService = _userService;
    CCScene *scene = [CCScene sceneWithNode:tabBarScene];
    [(id)[CCDirector sharedDirector] replaceScene:scene animated:YES];
    
    [self saveUserCredential];
}

- (void)saveUserCredential
{
    [BMCredential sharedCredential].mobile = _mobileTextField.string;
    [BMCredential sharedCredential].password = _passwordTextField.string;
    [BMCredential sharedCredential].isSignedIn = YES;
    [[BMCredential sharedCredential] save];
}


#if __CC_PLATFORM_IOS
- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    [self showBackgroundUIView];
}

- (void)onExitTransitionDidStart
{
    [super onExitTransitionDidStart];
    [self hideBackgroundUIView];
}
#endif

@end
