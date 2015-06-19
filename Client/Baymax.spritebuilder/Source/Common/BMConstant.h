//
//  BMConstant.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#ifndef Baymax_BMConstant_h
#define Baymax_BMConstant_h

#define SCREEN_SIZE             [CCDirector sharedDirector].designSize
#define SCREEN_WIDTH            SCREEN_SIZE.width
#define SCREEN_HEIGHT           SCREEN_SIZE.height
#define SCREEN_CENTER           ccp(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)

#define SWAP(a, b)              (a ^= b, b ^= a, a ^= b)


#define MAIN_SCENE              @"TabBarScene"
#define SIGN_SCENE              @"SignScene"

#define IMG_DIRECTORY           @"ccbResources/"
#define IMG_FILE_NAME(str)      [IMG_DIRECTORY stringByAppendingString:str]
#define IMG_NAV_BUTTON_ADD      IMG_FILE_NAME(@"nav_button_add.png")
#define IMG_NAV_BUTTON_BACK     IMG_FILE_NAME(@"nav_button_back.png")
#define IMG_NAV_BUTTON_DROPDOWN IMG_FILE_NAME(@"nav_button_dropdown.png")

#define BUTTON_TITLE_CANCEL     NSLocalizedString(@"取消", "")
#define BUTTON_TITLE_DONE       NSLocalizedString(@"完成", "")

#endif
