//
//  BMMainNextSceneModel.m
//  Baymax
//
//  Created by Killua Liu on 7/1/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMMainNextSceneModel.h"
#import "BMCredential.h"

@implementation BMModelItem

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

@implementation BMMainNextSceneModel

+ (instancetype)model
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:PlistFilePath(@"main-next-scene")];
    BMMainNextSceneModel *model = [self modelWithDictionary:dict];
    
    return model;
}

@end