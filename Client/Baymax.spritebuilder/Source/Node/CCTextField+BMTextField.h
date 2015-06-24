//
//  CCTextField+BMTextField.h
//  Baymax
//
//  Created by Killua Liu on 6/24/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCTextField.h"

typedef NS_ENUM(NSUInteger, BMKeyboardType) {
    BMKeyboardTypeDefault,                // Default type for the current input method.
    BMKeyboardTypeASCIICapable,           // Displays a keyboard which can enter ASCII characters, non-ASCII keyboards remain active
    BMKeyboardTypeNumbersAndPunctuation,  // Numbers and assorted punctuation.
    BMKeyboardTypeURL,                    // A type optimized for URL entry (shows . / .com prominently).
    BMKeyboardTypeNumberPad,              // A number pad (0-9). Suitable for PIN entry.
    BMKeyboardTypePhonePad,               // A phone pad (1-9, *, 0, #, with letters under the numbers).
    BMKeyboardTypeNamePhonePad,           // A type optimized for entering a person's name or phone number.
    BMKeyboardTypeEmailAddress            // A type optimized for multiple email address entry (shows space @ . prominently).
};

@interface CCTextField (BMTextField)

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) BMKeyboardType keyboardType;
@property (nonatomic, assign) NSUInteger maxLength;
@property (nonatomic, getter=isSecureTextEntry) BOOL secureTextEntry;

- (void)becomeFirstResponder;
- (BOOL)isFirstResponder;

@end
