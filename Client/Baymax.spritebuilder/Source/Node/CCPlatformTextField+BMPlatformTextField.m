//
//  CCPlatformTextField+BMPlatformTextField.m
//  Baymax
//
//  Created by Killua Liu on 6/24/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCPlatformTextField+BMPlatformTextField.h"

@implementation CCPlatformTextField (BMPlatformTextField)

@dynamic placeholder;
@dynamic keyboardType;

- (void)setMaxLength:(NSUInteger)maxLength
{
    objc_setAssociatedObject(self, @selector(maxLength), @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSUInteger)maxLength
{
    return [objc_getAssociatedObject(self, @selector(maxLength)) unsignedIntegerValue];
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    objc_setAssociatedObject(self, @selector(isSecureTextEntry), @(secureTextEntry), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isSecureTextEntry
{
    return [objc_getAssociatedObject(self, @selector(isSecureTextEntry)) boolValue];
}

- (void)setKeyboardType:(BMKeyboardType)keyboardType
{
    
}

- (void)becomeFirstResponder
{
    
}

- (BOOL)isFirstResponder
{
    return [self.nativeTextField isFirstResponder];
}

@end
