//
//  CCPlatformTextFieldIOS.h
//  cocos2d-osx
//
//  Created by Sergey Klimov on 7/1/14.
//
//

#import <UIKit/UIKit.h>
#import "CCPlatformTextField.h"

@interface CCPlatformTextFieldIOS : CCPlatformTextField <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;       // Added by Killua
@property (nonatomic, assign) CGFloat scaleMultiplier;      // Added by Killua

@end
