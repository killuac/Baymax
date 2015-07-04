//
//  CCTextField+BMTextField.m
//  Baymax
//
//  Created by Killua Liu on 6/24/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCTextField+BMTextField.h"

#define PASSWORD_SECURE_SIGN    @"•"


@interface CCTextField ()

@property (nonatomic, strong) NSString *password;

@end

@implementation CCTextField (BMTextField)

- (void)setPlaceholder:(NSString *)placeholder
{
    self.platformTextField.placeholder = placeholder;
}

- (NSString *)placeholder
{
    return self.platformTextField.placeholder;
}

- (void)setMaxLength:(NSUInteger)maxLength
{
    self.platformTextField.maxLength = maxLength;
}

- (NSUInteger)maxLength
{
    return self.platformTextField.maxLength;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    self.platformTextField.secureTextEntry = secureTextEntry;
}

- (BOOL)isSecureTextEntry
{
    return self.platformTextField.secureTextEntry;
}

- (void)setKeyboardType:(BMKeyboardType)keyboardType
{
    self.platformTextField.keyboardType = keyboardType;
}

- (BMKeyboardType)keyboardType
{
    return self.platformTextField.keyboardType;
}

- (void)becomeFirstResponder
{
    [self.platformTextField becomeFirstResponder];
}

- (BOOL)isFirstResponder
{
    return [self.platformTextField isFirstResponder];
}

#if __CC_PLATFORM_MAC
- (void)setPassword:(NSString *)password
{
    objc_setAssociatedObject(self, @selector(password), password, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)password
{
    NSString *password = objc_getAssociatedObject(self, @selector(password));
    return (password) ? password : [NSString string];
}

- (void)update:(CCTime)delta
{
    NSMutableString *textString = [self.platformTextField.string mutableCopy];
    for (NSUInteger i = 0; i < textString.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *oneStr = [self.platformTextField.string substringWithRange:range];
        if (![oneStr isEqualToString:PASSWORD_SECURE_SIGN]) {
            self.password = [self.password stringByAppendingString:oneStr];
            [textString replaceCharactersInRange:range withString:PASSWORD_SECURE_SIGN];
        }
    }
    
    self.password = [self.password substringToIndex:textString.length];
    
    if (self.secureTextEntry) {
        self.platformTextField.string = textString;
    } else if (self.password.length > 0) {
        self.platformTextField.string = self.password;
        self.password = [NSString string];
    }
}
#endif

- (NSString *)string
{
#if __CC_PLATFORM_MAC
    return (self.password.length > 0) ? self.password : self.platformTextField.string;
#else
    return self.platformTextField.string;
#endif
}

- (void)setString:(NSString *)string
{
    if (string) {
        self.platformTextField.string = string;
    }
}

@end
