//
//  CCPlatformTextFieldMac+BMPlatformTextFieldMac.m
//  Baymax
//
//  Created by Killua Liu on 6/24/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCPlatformTextFieldMac+BMPlatformTextFieldMac.h"

@implementation CCPlatformTextFieldMac (BMPlatformTextFieldMac)

- (void)setPlaceholder:(NSString *)placeholder
{
    [[self.nativeTextField cell] setPlaceholderString:placeholder];
}

- (NSString *)placeholder
{
    return [[self.nativeTextField cell] placeholderString];
}

- (void)becomeFirstResponder
{
    [(NSTextField *)self.nativeTextField becomeFirstResponder];
}

- (BOOL)isFirstResponder
{
    return [self.nativeTextField acceptsFirstResponder];
}

@end
