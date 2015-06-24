//
//  CCPlatformTextFieldAndroid+BMPlatformTextFieldAndroid.m
//  Baymax
//
//  Created by Killua Liu on 6/24/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCPlatformTextFieldAndroid+BMPlatformTextFieldAndroid.h"

@implementation CCPlatformTextFieldAndroid (BMPlatformTextFieldAndroid)

- (void)setPlaceholder:(NSString *)placeholder
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.nativeTextField setHint:placeholder];
    });
}

- (NSString *)placeholder
{
    return [[self.nativeTextField hint] description];
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    [super setSecureTextEntry:secureTextEntry];
    self.keyboardType = BMKeyboardTypeASCIICapable;
}

- (void)setKeyboardType:(BMKeyboardType)keyboardType
{
    int32_t inputType = AndroidInputTypeTypeClassText;
    
    switch (keyboardType) {
        case BMKeyboardTypeNumberPad:
            inputType = AndroidInputTypeTypeClassNumber;
            break;
            
        case BMKeyboardTypeASCIICapable: {
            int32_t type = ((self.secureTextEntry) ? AndroidInputTypeTypeTextVariationPassword : AndroidInputTypeTypeTextVariationVisiblePassword);
            inputType |= type | AndroidInputTypeTypeTextFlagNoSuggestions;
            break;
        }
            
        default:
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.nativeTextField setInputType:inputType];
    });
}

- (BMKeyboardType)keyboardType
{
    return [self.nativeTextField inputType];
}

- (void)setMaxLength:(NSUInteger)maxLength
{
    [super setMaxLength:maxLength];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.nativeTextField setFilters:[NSArray arrayWithObject:@(maxLength)]];
//    });
}

- (void)becomeFirstResponder
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.nativeTextField setFocusable:YES];
        [self.nativeTextField setFocusableInTouchMode:YES];
    });
}

- (BOOL)isFirstResponder
{
    return [self.nativeTextField isFocused];
}

@end
