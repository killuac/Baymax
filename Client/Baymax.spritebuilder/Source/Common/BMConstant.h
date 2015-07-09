//
//  BMConstant.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#ifndef Baymax_BMConstant_h
#define Baymax_BMConstant_h

#define SCREEN_SIZE                 [CCDirector sharedDirector].designSize
#define SCREEN_WIDTH                SCREEN_SIZE.width
#define SCREEN_HEIGHT               SCREEN_SIZE.height
#define SCREEN_CENTER               ccp(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)

#define BACKGROUND_COLOR                [CCColor colorWithWhite:0.95 alpha:1]
#define BACKGROUND_COLOR_TRANSPARENT    [CCColor colorWithWhite:0 alpha:0]

#define MOBILE_MAX_LENGTH           11
#define PASSWORD_MIN_LENGTH         6
#define VERIFICATION_CODE_LENGTH    6
#define REGISTRATION_PLATE_LENGTH   6

#define MAIN_SCENE                  @"TabBarScene"
#define SIGN_SCENE                  @"SignScene"

#define IMG_DIRECTORY               @"ccbResources/"
#define IMG_FILE_NAME(str)          [IMG_DIRECTORY stringByAppendingString:str]
#define IMG_NAV_BUTTON_ADD          IMG_FILE_NAME(@"nav_button_add.png")
#define IMG_NAV_BUTTON_BACK         IMG_FILE_NAME(@"nav_button_back.png")
#define IMG_NAV_BUTTON_HOME         IMG_FILE_NAME(@"nav_button_home.png")
#define IMG_NAV_BUTTON_DROPDOWN     IMG_FILE_NAME(@"nav_button_dropdown.png")
#define IMG_NAV_BUTTON_SETTING      IMG_FILE_NAME(@"nav_button_setting.png")


#define NAV_TITLE_MAINTENANCE       NSLocalizedString(@"保养", "")
#define NAV_TITLE_AUTOMOBILE        NSLocalizedString(@"我的爱车", "")
#define NAV_TITLE_ORDER             NSLocalizedString(@"我的订单", "")
#define NAV_TITLE_ME                NSLocalizedString(@"我", "")
#define NAV_TITLE_AUTOBRAND         NSLocalizedString(@"车的品牌", "")
#define NAV_TITLE_AUTOSERIES        NSLocalizedString(@"车的系列", "")
#define NAV_TITLE_AUTOMODEL         NSLocalizedString(@"车的型号", "")
#define NAV_TITLE_PLATE             NSLocalizedString(@"车牌号码", "")
#define NAV_TITLE_MAIN_NEXT         NSLocalizedString(@"保养订单", "")
#define NAV_TITLE_ORDER_DETAIL      NSLocalizedString(@"订单详情", "")

#define BUTTON_TITLE_CANCEL         NSLocalizedString(@"取消", "")
#define BUTTON_TITLE_DONE           NSLocalizedString(@"完成", "")
#define BUTTON_TITLE_SIGNIN         NSLocalizedString(@"登录", "")
#define BUTTON_TITLE_SIGNUP         NSLocalizedString(@"注册", "")
#define BUTTON_TITLE_FETCH_VCODE    NSLocalizedString(@"获取验证码", "")
#define BUTTON_TITLE_REFETCH        NSLocalizedString(@"重新获取", "")

#define PLACEHOLDER_MOBILE          NSLocalizedString(@"手机号码 (11位)", "")
#define PLACEHOLDER_PASSWORD        NSLocalizedString(@"密码 (不小于6位)", "")
#define PLACEHOLDER_VCODE           NSLocalizedString(@"短信验证码 (6位)", "")
#define PLACEHOLDER_PLATE           NSLocalizedString(@"车牌号码 (6位)", "")

#define TIP_CONNECTION_FAILED       NSLocalizedString(@"暂时无法连接到服务器", "")
#define TIP_CONNECTION_BROKEN       NSLocalizedString(@"网络连接似乎断了", "")
#define TIP_MOBILE_INVALID          NSLocalizedString(@"手机号码无效", "")
#define TIP_MOBILE_TAKEN            NSLocalizedString(@"手机号码已经被注册", "")
#define TIP_MOBILE_NOT_FOUND        NSLocalizedString(@"手机号码尚未注册", "")
#define TIP_PASSWORD_WRONG          NSLocalizedString(@"密码错误", "")
#define TIP_PASSWORD_INVALID        NSLocalizedString(@"密码含有非法字符", "")
#define TIP_VCODE_WRONG             NSLocalizedString(@"验证码错误", "")
#define TIP_INITIALIZATION          NSLocalizedString(@"初始化...", "")
#define TIP_SIGNING_UP              NSLocalizedString(@"创建中...", "")
#define TIP_SIGNING_IN              NSLocalizedString(@"登录中...", "")
#define TIP_CREATING                NSLocalizedString(@"创建中...", "")

#define TEXT_YES                    NSLocalizedString(@"是", "")
#define TEXT_NO                     NSLocalizedString(@"否", "")
#define TEXT_PRICE_UNIT             NSLocalizedString(@"元", "")
#define TEXT_NO_CONTENT             NSLocalizedString(@"暂无", "")
#define TEXT_TOTAL_AMOUNT           NSLocalizedString(@"金额总计：& 元", "")

#define SWAP(a, b)                  (a ^= b, b ^= a, a ^= b)

#endif
