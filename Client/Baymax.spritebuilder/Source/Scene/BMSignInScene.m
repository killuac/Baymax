//
//  BMSignInScene.m
//  Baymax
//
//  Created by Killua Liu on 6/12/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMSignInScene.h"

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
    _mobileTextField.placeholder = @"手机号码 (11位)";
    _passwordTextField.placeholder = @"密码 (不小于6位)";
    
    _mobileTextField.keyboardType = BMKeyboardTypeNumberPad;
    _passwordTextField.keyboardType = BMKeyboardTypeASCIICapable;
    
    [_mobileTextField becomeFirstResponder];
}

- (void)update:(CCTime)delta
{
    _signButton.enabled = (_mobileTextField.string.length == MOBILE_MAX_LENGTH && _passwordTextField.string.length >= PASSWORD_MIN_LENGTH);
}

- (void)signIn:(CCButton *)button
{
    NSURL *url = [BMServerAPI sharedServerAPI].usersURL;
    [[BMSessionManager sharedSessionManager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BMUser *user = [BMUser modelWithDictionary:responseObject];
        if (404 == operation.response.statusCode) {
            //            !!! - 手机号不存在
        } else if (401 == operation.response.statusCode) {
            //            !!! - 密码错误
        } else {
            
        }
    }];
}

@end
