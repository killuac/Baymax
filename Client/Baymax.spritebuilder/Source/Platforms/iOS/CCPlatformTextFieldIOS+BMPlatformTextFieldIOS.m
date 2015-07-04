//
//  CCPlatformTextFieldIOS+BMPlatformTextFieldIOS.m
//  Baymax
//
//  Created by Killua Liu on 6/24/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "CCPlatformTextFieldIOS+BMPlatformTextFieldIOS.h"
#import "BMConstant.h"

@implementation CCPlatformTextFieldIOS (BMPlatformTextFieldIOS)

+ (void)load
{
    Method original = class_getInstanceMethod(self.class, @selector(init));
    Method swizzled = class_getInstanceMethod(self.class, @selector(swizzledInit));
    
    method_exchangeImplementations(original, swizzled);
}

- (instancetype)swizzledInit
{
    CCPlatformTextFieldIOS *platformTextField = [self swizzledInit];
    platformTextField.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addBackgroundView];
    
    return platformTextField;
}

- (void)setBackground:(UIView *)background
{
    objc_setAssociatedObject(self, @selector(background), background, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)background
{
    return objc_getAssociatedObject(self, @selector(background));
}

- (void)addBackgroundView
{
    UIView *glView = [CCDirector sharedDirector].view;
    UIView *superView = glView.superview;
    glView.opaque = NO;
    
    if (![superView.subviews.firstObject isMemberOfClass:[UIView class]]) {
        CGSize size = [CCDirector sharedDirector].designSize;
        CGRect frame = CGRectMake(0, 0, size.width, size.height);
        self.background = [[UIView alloc] initWithFrame:frame];
        self.background.backgroundColor = [BACKGROUND_COLOR UIColor];
        [superView addSubview:self.background];
        [superView sendSubviewToBack:self.background];
    }
}

- (void)addUITextView
{
    UIView *glView = [[CCDirector sharedDirector] view];
    UIView *superView = glView.superview;
    [superView insertSubview:self.textField belowSubview:glView];
}

- (void)setImageView:(UIImageView *)imageView
{
    objc_setAssociatedObject(self, @selector(imageView), imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)imageView
{
    return objc_getAssociatedObject(self, @selector(imageView));
}

- (void)positionInControl:(CCControl *)control padding:(CGFloat)padding
{
    CGPoint worldPos = [control convertToWorldSpace:CGPointZero];
    CGPoint viewPos = [[CCDirector sharedDirector] convertToUI:worldPos];
    viewPos.x += padding;
//    viewPos.y += padding;
    
    CGSize size = control.contentSizeInPoints;
    size.width *= self.scaleMultiplier;
    size.height *= self.scaleMultiplier;
    
    viewPos.y -= size.height;
    size.width -= padding * 2;
//    size.height -= padding * 2;
    
    CGFloat yPadding = 0;
    if (self.textField.frame.size.height > 44) {
        yPadding = padding;
        viewPos.y += padding;
        size.height -= padding * 2;
        self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    }
    
    CGRect frame = CGRectZero;
    frame.origin = viewPos;
    frame.size = size;
    
    self.textField.frame = frame;
    
    CGPoint point = self.imageView.frame.origin;
    frame.origin = CGPointMake(point.x, viewPos.y - yPadding);
    frame.size = self.imageView.frame.size;
    self.imageView.frame = frame;
}

#pragma mark - Additional property
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
