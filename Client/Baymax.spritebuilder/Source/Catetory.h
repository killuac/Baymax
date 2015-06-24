//
//  Catetory.h
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#ifndef Baymax_Catetory_h
#define Baymax_Catetory_h

#import "CCNode+BMNode.h"
#import "CCSprite+BMSprite.h"
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
#import "CCPlatformTextFieldIOS+BMPlatformTextFieldIOS.h"

#elif __CC_PLATFORM_MAC
#import "CCPlatformTextFieldMac+BMPlatformTextFieldMac.h"

#elif __CC_PLATFORM_ANDROID
#import "CCPlatformTextFieldAndroid+BMPlatformTextFieldAndroid.h"
#endif

#endif
