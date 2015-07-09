//
//  BMUserSceneModel.m
//  Baymax
//
//  Created by Killua Liu on 7/1/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "BMUserSceneModel.h"
#import "BMUtil.h"

@implementation BMUserSceneModel

+ (instancetype)model
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:PlistFilePath(@"user-scene")];
    BMUserSceneModel *model = [self modelWithDictionary:dict];
    
    return model;
}

@end
