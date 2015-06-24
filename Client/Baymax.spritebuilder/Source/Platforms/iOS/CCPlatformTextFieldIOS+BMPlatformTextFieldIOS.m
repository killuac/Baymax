//
//  CCPlatformTextFieldIOS+BMPlatformTextFieldIOS.m
//  Baymax
//
//  Created by Killua Liu on 6/24/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCPlatformTextFieldIOS+BMPlatformTextFieldIOS.h"

@implementation CCPlatformTextFieldIOS (BMPlatformTextFieldIOS)

- (void)setPlaceholder:(NSString *)placeholder
{
    [self.nativeTextField setPlaceholder:placeholder];
}

- (NSString *)placeholder
{
    return [self.nativeTextField placeholder];
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    [self.nativeTextField resignFirstResponder];
    [self.nativeTextField setSecureTextEntry:secureTextEntry];
    [self becomeFirstResponder];
}

- (BOOL)isSecureTextEntry
{
    return [self.nativeTextField isSecureTextEntry];
}

- (void)setKeyboardType:(BMKeyboardType)keyboardType
{
    [self.nativeTextField setKeyboardType:(NSUInteger)keyboardType];
}

- (BMKeyboardType)keyboardType
{
    return (NSUInteger)[self.nativeTextField keyboardType];
}

- (void)becomeFirstResponder
{
    [(UITextField *)self.nativeTextField becomeFirstResponder];
}

- (BOOL)isFirstResponder
{
    return [self.nativeTextField isFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    BOOL returnKey = ([string rangeOfString: @"\n"].location != NSNotFound);
    return (self.maxLength > 0) ? (text.length <= self.maxLength || returnKey) : YES;
}

@end
