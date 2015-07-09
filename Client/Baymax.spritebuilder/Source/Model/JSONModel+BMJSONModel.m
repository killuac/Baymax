//
//  JSONModel+BMJSONModel.m
//  Baymax
//
//  Created by Killua Liu on 6/9/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "JSONModel+BMJSONModel.h"

@implementation JSONModel (BMJSONModel)

+ (instancetype)model
{
    return [[self alloc] init];
}

+ (instancetype)modelWithString:(NSString *)string
{
    NSError *error;
    id jsonModel = [[self alloc] initWithString:string error:&error];
    if (error)  NSLog(@"%@", error);
    return jsonModel;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    NSError *error;
    id jsonModel = [[self alloc] initWithDictionary:dictionary error:&error];
    if (error)  NSLog(@"%@", error);
    return jsonModel;
}

+ (instancetype)modelWithData:(NSData *)data
{
    NSError *error;
    id jsonModel = [[self alloc] initWithData:data error:&error];
    if (error)  NSLog(@"%@", error);
    return jsonModel;
}

- (void)setIsSelected:(BOOL)isSelected
{
    objc_setAssociatedObject(self, @selector(isSelected), @(isSelected), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isSelected
{
    return [objc_getAssociatedObject(self, @selector(isSelected)) boolValue];
}

@end

#pragma mark - Added classes
@implementation BMModelItem

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper jsonKeyMapperWithDictionary:@{
        @"isEditable": @"isEditableValue",
        @"maxLength": @"maxLengthValue",
        @"keyboardType": @"keyboardTypeValue"
    }];
}

- (BOOL)isEditable{
    return _isEditableValue.boolValue;
}

- (NSUInteger)maxLength
{
    return _maxLengthValue.unsignedIntegerValue;
}

- (BMKeyboardType)keyboardType
{
    return _keyboardTypeValue.unsignedIntegerValue;
}

@end

@implementation BMModelSection
@end