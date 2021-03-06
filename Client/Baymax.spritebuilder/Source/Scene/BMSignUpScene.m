//
//  BMSignUpScene.m
//  Baymax
//
//  Created by Killua Liu on 6/23/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMSignUpScene.h"
#import "BMButtonFactory.h"

@implementation BMSignUpScene {
    __weak CCTextField *_vcodeTextField;
    __weak CCButton *_fetchVcodeButton;
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
    if (indexPath.row < 2) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    BMTableViewCell *cell = [BMTableViewCell cellWithStyle:BMTableViewCellStyleDefault accessoryType:BMTableViewCellAccessoryDetailDisclosureButton];
    cell.imageSprite.spriteFrame = [CCSpriteFrame frameWithImageNamed:IMG_FILE_NAME(@"icon_verification_code.png")];
    
    _fetchVcodeButton = [BMButtonFactory createNormalAccessoryButtonInCell:cell];
    _fetchVcodeButton.title = BUTTON_TITLE_FETCH_VCODE;
    _fetchVcodeButton.position = ccpAdd(_fetchVcodeButton.position, ccp(5, 0));
    [_fetchVcodeButton setTarget:self selector:@selector(fetchVerificationCode:)];
    
    _vcodeTextField = cell.textField;
    CGFloat width = _vcodeTextField.contentSize.width - (_fetchVcodeButton.preferredSize.width+15);
    _vcodeTextField.preferredSize = CGSizeMake(width, _vcodeTextField.preferredSize.height);
    _vcodeTextField.maxLength = VERIFICATION_CODE_LENGTH;
    _vcodeTextField.placeholder = PLACEHOLDER_VCODE;
    
    return cell;
}

- (void)loadOnce
{
    [super loadOnce];
    _vcodeTextField.placeholder = PLACEHOLDER_VCODE;
    _vcodeTextField.keyboardType = BMKeyboardTypeNumberPad;
    
    [_passwordTextField setTarget:self selector:@selector(textFieldDidFinishEditing:)];
}

- (void)textFieldDidFinishEditing:(CCTextField *)textField
{
    if (!_vcodeTextField.isFirstResponder) {
        [_vcodeTextField becomeFirstResponder];
    }
}

- (void)update:(CCTime)delta
{
    [super update:delta];
    _fetchVcodeButton.enabled = (_mobileTextField.string.length == MOBILE_MAX_LENGTH);
    _signButton.enabled = (_signButton.enabled && (_vcodeTextField.string.length == VERIFICATION_CODE_LENGTH));
}

- (void)fetchVerificationCode:(CCButton *)button
{
//  !!! - 获取短信验证码
//    [[BMSessionManager sharedSessionManager].requestSerializer setValue:@"1be2mlt1k90hbmi0g2byirrgk8ksy1yblwx0hnj4d9vs9xgk"
//                                                     forHTTPHeaderField:@"X-AVOSCloud-Application-Id"];
//    [[BMSessionManager sharedSessionManager].requestSerializer setValue:@"zj9gowlpfnfdscncuukyg02v3vtp5f75ptcrjek182nloqio"
//                                                     forHTTPHeaderField:@"X-AVOSCloud-Application-Key"];
//    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"18516057455" forKey:@"mobilePhoneNumber"];
//    [[BMSessionManager sharedSessionManager] POST:@"https://api.leancloud.cn/1.1/requestSmsCode"
//                                       parameters:dict
//                                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [BMTextTip showText:@"成功"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
//    }];
    
    BMSMSCode *smsCode = [[BMSMSCode alloc] init];
    smsCode.mobile = _mobileTextField.string;
    
    [self.userService sendSMSWithData:smsCode result:^(id service) {
        
    }];
}

- (void)navigationBar:(BMNavigationBar *)navBar didSelectItem:(BMNavBarItem *)item
{
    if ([item isEqual:self.navigationBar.leftBarItem]) {
        [super navigationBar:navBar didSelectItem:item];
    }
}

- (void)signUp:(CCButton *)button
{
    BMUser *user = [[BMUser alloc] init];
    user.mobile = _mobileTextField.string;
    user.password = _passwordTextField.string;
    user.verificationCode = _vcodeTextField.string;
    
    [self.userService createWithData:user result:^(id service) {
        if (self.userService.user.isMobileTaken) {
            [BMTextTip showText:TIP_MOBILE_TAKEN];
        } else if (self.userService.user.isWrongVcode) {
            [BMTextTip showText:TIP_VCODE_WRONG];
        } else {
            [self showMainScene];
        }
    }];
}

@end
