//
//  CCPlatformTextField+BMPlatformTextField.h
//  Baymax
//
//  Created by Killua Liu on 6/24/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCPlatformTextField.h"

@interface CCPlatformTextField (BMPlatformTextField)

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) BMKeyboardType keyboardType;
@property (nonatomic, assign) NSUInteger maxLength;
@property (nonatomic, getter=isSecureTextEntry) BOOL secureTextEntry;

- (void)becomeFirstResponder;
- (BOOL)isFirstResponder;

@end
