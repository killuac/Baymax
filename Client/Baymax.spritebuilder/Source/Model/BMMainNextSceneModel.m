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

- (NSString<Optional> *)value
{
    return (_value) ? _value : @"";
}

@end

@implementation BMModelSection

@end

@implementation BMMainNextSceneModel

+ (instancetype)new
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:PlistFilePath(@"main-next-scene")];
    BMMainNextSceneModel *model = [self modelWithDictionary:dict];
    ((BMModelItem *)[model.sections.firstObject items][1]).value = [BMCredential sharedCredential].mobile;
    
    return model;
}

@end
