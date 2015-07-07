//
//  Catetory.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#ifndef Baymax_Catetory_h
#define Baymax_Catetory_h

#import "NSDate+BMDate.h"

#import "CCNode+BMNode.h"
#import "CCSprite+BMSprite.h"
#import "CCButton+BMButton.h"
#import "CCTextField+BMTextField.h"
#import "CCPlatformTextField+BMPlatformTextField.h"
#import "CCSpriteFrame+BMSpriteFrame.h"
#import "CCTextureCache+BMTextureCache.h"
#import "CCScene+BMScene.h"
#import "CCTransition+BMTransition.h"

#import "JSONModel+BMJSONModel.h"
#import "JSONKeyMapper+BMJSONKeyMapper.h"
#import "JSONValueTransformer+BMJSONValueTransformer.h"

#if __CC_PLATFORM_IOS
#import "CCDirectorIOS+BMDirectorIOS.h"
#import "CCGLView+BMGLView.h"
#import "UITextField+BMTextField.h"
#import "CCPlatformTextFieldIOS+BMPlatformTextFieldIOS.h"

#elif __CC_PLATFORM_MAC
#import "CCDirectorMac+BMDirectorMac.h"
#import "CCPlatformTextFieldMac+BMPlatformTextFieldMac.h"

#elif __CC_PLATFORM_ANDROID
#import "CCDirectorAndroid+BMDirectorAndroid.h"
#import "CCPlatformTextFieldAndroid+BMPlatformTextFieldAndroid.h"
#endif

#endif
